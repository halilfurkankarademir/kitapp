import 'package:flutter/material.dart';
import 'package:kitapp/components/cards/book_card.dart';
import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/services/database_service.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({super.key});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  late String categoryName;
  List<BookModel> books = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      categoryName = ModalRoute.of(context)!.settings.arguments as String;
      fetchAuthorData();
    }
  }

  Future<void> fetchAuthorData() async {
    final fetchedBooks =
        await DatabaseService().getBooksByCategory(categoryName.trim());
    setState(() {
      books = fetchedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          categoryName,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              books.isNotEmpty
                  ? BooksRenderer(books: books)
                  : Center(
                      child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Image.network(
                          'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-26121.jpg?t=st=1732060951~exp=1732064551~hmac=74c691623746e18aa85e0667c3f04afffab20059e0a9f4f169dce3daadf1ff96&w=740',
                          height: 300,
                          width: 300,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'İlgili kategoride kitap bulunamadı.',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ))
            ],
          ),
        ),
      ),
    );
  }
}

class BooksRenderer extends StatelessWidget {
  const BooksRenderer({
    super.key,
    required this.books,
  });

  final List<BookModel> books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.65,
              ),
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                final book = books[index];
                return BookCard(
                  title: book.bookName ?? '',
                  imageUrl: book.coverImageUrl ?? '',
                  author: book.author ?? '',
                  bookId: book.bookId ?? '',
                  category: book.category ?? '',
                );
              },
            ),
    );
  }
}
