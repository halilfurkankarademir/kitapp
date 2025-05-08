import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/categories.dart';
import 'package:kitapp/components/title.dart';
import 'package:kitapp/pages/home/read_book_page.dart';
import 'package:kitapp/services/database_service.dart';
import '../../models/book_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';

class HomepageContent extends StatefulWidget {
  const HomepageContent({super.key});

  @override
  State<HomepageContent> createState() => _HomepageContentState();
}

class _HomepageContentState extends State<HomepageContent> {
  late Future<List<BookModel>> booksFuture;
  final box = GetStorage();
  // All continue reading datas
  Map<String, dynamic> allData = {};

  @override
  void initState() {
    super.initState();
    booksFuture = DatabaseService().getAllBooks();
    _loadContinueReadingData();
  }

  Future<void> _loadContinueReadingData() async {
    final keys = box.getKeys();
    final Map<String, dynamic> data = {};

    final books = await booksFuture;

    for (var key in keys) {
      for (var book in books) {
        if (book.bookId == key) {
          data[key] = box.read(key);
          break;
        }
      }
    }

    setState(() {
      allData = data;
    });
  }

  // Get datas again when page is refreshed
  Future<void> loadDatas() async {
    final books = DatabaseService().getAllBooks();
    setState(() {
      booksFuture = books;
    });
    _loadContinueReadingData();
  }

  void openPdf(String bookId, String pdfUrl, String bookName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReadBookPage(
                bookId: bookId, pdfUrl: pdfUrl, bookName: bookName)));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await loadDatas();
      },
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const TitleRow(
                  text: 'Popüler',
                  showAllBooks: true,
                ),
                const SizedBox(height: 20),
                BookCardsRender(bookDetails: booksFuture),
                const SizedBox(height: 30),
                const TitleRow(
                  text: 'Kategoriler',
                  showAllBooks: false,
                ),
                const SizedBox(height: 20),
                const Categories(),
                const SizedBox(height: 30),
                const TitleRow(
                  text: 'Okuma Geçmişin',
                  showAllBooks: false,
                ),
                const SizedBox(height: 20),
                continueReadingWidget(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget continueReadingWidget() {
    return FutureBuilder<List<BookModel>>(
      future: booksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Kitap bulunamadı.'));
        } else {
          final books = snapshot.data!;
          final continueReadingBooks =
              books.where((book) => allData.containsKey(book.bookId)).toList();

          if (continueReadingBooks.isEmpty) {
            return const Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Okuduğunuz kitap bulunamadı.',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
                ),
              ],
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: continueReadingBooks.map((book) {
                final remainingPages = allData[book.bookId].toString();

                final List<Color> pastelColors = [
                  const Color.fromRGBO(179, 235, 242, 1), // Pastel Pink
                  const Color.fromRGBO(255, 238, 140, 1), // Pastel Yellow
                  const Color.fromRGBO(255, 116, 108, 1), // Pastel Green
                  const Color.fromRGBO(128, 239, 128, 1), // Pastel Blue
                  const Color.fromRGBO(255, 197, 211, 1), // Pastel Purple
                ];

                final random = Random();
                int randomNumber = random.nextInt(5);

                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        width: 360,
                        height: 175,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: pastelColors[randomNumber],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    book.coverImageUrl ?? '',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.bookName ?? '',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      '$remainingPages sayfa kaldı.',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BlackRoundedButton(
                              text: 'Okumaya Devam Et',
                              icon: const Icon(Icons.play_circle_fill_rounded),
                              onPressed: () {
                                openPdf(book.bookId ?? '', book.pdfUrl ?? '',
                                    book.bookName ?? '');
                              },
                            ),
                          ],
                        )));
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

// BookCardsRender widget'ı
class BookCardsRender extends StatelessWidget {
  final Future<List<BookModel>> bookDetails;

  const BookCardsRender({
    super.key,
    required this.bookDetails,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookModel>>(
      future: bookDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Kitap bulunamadı.'));
        } else {
          final books = snapshot.data!;
          final limitedBooks = books.take(5).toList();
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: limitedBooks.map((book) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'BookDetailsPage',
                            arguments: book.bookId);
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 100,
                            height: 150,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 240, 240, 240),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(book.coverImageUrl ?? ''),
                                fit: BoxFit.cover,
                                height: 125,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            book.bookName!,
                            style: const TextStyle(
                                fontFamily: 'Cy',
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12),
                          ),
                        ],
                      )),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
