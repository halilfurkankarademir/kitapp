import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/pages/home/read_book_page.dart';
import 'package:kitapp/services/database_service.dart';
import 'package:kitapp/utils/utils.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late String bookId;
  BookModel? book;
  bool isLoading = true;
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      bookId = ModalRoute.of(context)!.settings.arguments as String;
      fetchBookData();
    }
  }

  Future<void> fetchBookData() async {
    final fetchedBook = await DatabaseService().getBookByBookId(bookId);
    final favoriteStatus = await DatabaseService().isFavorite(bookId);
    setState(() {
      book = fetchedBook;
      isFavorite = favoriteStatus;
      isLoading = false;
    });
  }

  void deleteBookById() async {
    await DatabaseService().deleteBookByBookId(bookId);
    Utils().showToastSuccess('Kitap başarıyla silindi.');
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void addFavorite() async {
    await DatabaseService().addFavorites(bookId, book!.bookName ?? '',
        book!.author ?? '', book!.category ?? '', book!.coverImageUrl ?? '');
    setState(() {
      isFavorite = true;
    });
  }

  void deleteFavorite() async {
    await DatabaseService().deleteFavorite(bookId);
    setState(() {
      isFavorite = false;
    });
  }

  void handleFavButtonClick() async {
    if (isFavorite) {
      deleteFavorite();
    } else {
      addFavorite();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Kitap detayları',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                handleFavButtonClick();
              },
              icon: isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.orange,
                    )
                  : const Icon(Icons.favorite_border_outlined))
        ],
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : book == null
                  ? const Text('Kitap bulunamadı.')
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Image.network(
                              book!.coverImageUrl ??
                                  'https://bouwactief.com/wp-content/uploads/2020/04/placeholder-1080x1080.jpg',
                              width: 200,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            book!.bookName ?? 'Kitap adı bulunamadı',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                overflow: TextOverflow.ellipsis),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            book!.author ?? 'Bilinmeyen',
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 96, 96, 96)),
                          ),
                          const SizedBox(height: 16),
                          DetailsWidget(book: book),
                          const SizedBox(height: 50),
                          DescriptionWidget(book: book),
                          const SizedBox(height: 40),
                          BlackRoundedButton(
                            text: 'Kitabı Oku',
                            icon: const Icon(Icons.read_more_rounded),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReadBookPage(
                                            bookId: bookId,
                                            pdfUrl: book?.pdfUrl ?? 'null',
                                            bookName: book?.bookName,
                                          )));
                            },
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    required this.onRatingUpdate,
  });

  final ValueChanged<double> onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RatingBar.builder(
        itemSize: 30,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: onRatingUpdate,
      ),
    );
  }
}

//Comments section

// Description widget
class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.book});
  final BookModel? book;

  @override
  Widget build(BuildContext context) {
    return InfoSection(
      title: 'Açıklama',
      content: book?.description ?? 'Açıklama yok.',
      icon: const Icon(Icons.info_outline_rounded),
    );
  }
}

// Reusable InfoSection widget for any title-content pair
class InfoSection extends StatelessWidget {
  const InfoSection(
      {super.key, required this.title, required this.content, this.icon});
  final String title;
  final String content;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(child: icon)
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// Book details section
class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key, required this.book});
  final BookModel? book;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoColumn(label: 'Sayfa Sayısı', value: book?.pageNumber ?? '?'),
        const VerticalDividerWidget(),
        InfoColumn(label: 'Kategori', value: book?.category ?? '?'),
        const VerticalDividerWidget(),
        InfoColumn(label: 'Yayın Yılı', value: book?.releaseDate ?? '?'),
      ],
    );
  }
}

// Reusable InfoColumn widget for displaying label-value pairs
class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        )
      ],
    );
  }
}

// Reusable vertical divider widget
class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey,
    );
  }
}
