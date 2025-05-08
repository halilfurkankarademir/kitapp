import 'package:flutter/material.dart';
import 'package:kitapp/components/cards/book_card.dart';
import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/services/database_service.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<BookModel>> booksFuture;

  @override
  void initState() {
    super.initState();
    booksFuture = DatabaseService().getFavoriteBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              booksFuture = DatabaseService().getFavoriteBooks();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Favorilerim',
                      style: TextStyle(
                          fontFamily: 'Cy',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.orange,
                      size: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: BooksRenderer(booksFuture: booksFuture))
              ],
            ),
          ),
        ));
  }
}

class BooksRenderer extends StatelessWidget {
  const BooksRenderer({
    super.key,
    required this.booksFuture,
  });

  final Future<List<BookModel>> booksFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookModel>>(
      future: booksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Hata oluştu.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Favori kitap bulunamadı.'));
        } else {
          final favoriteBooks = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.6,
              ),
              itemCount: favoriteBooks.length,
              itemBuilder: (BuildContext context, int index) {
                final book = favoriteBooks[index];
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
      },
    );
  }
}
