import 'package:flutter/material.dart';
import 'package:kitapp/components/cards/book_card.dart';
import 'package:kitapp/components/filter_buttons.dart';
import 'package:kitapp/components/search_bar.dart';
import 'package:kitapp/services/database_service.dart';

import '../../models/book_model.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late Future<List<BookModel>> booksFuture;
  List<BookModel> allBooks = [];
  List<BookModel> filteredBooks = [];

  List<String> activeFilters = [];

  //Filter books by category
  void _onFilterChanged(List<String> filters) {
    setState(() {
      activeFilters = filters;
      filteredBooks = allBooks.where((book) {
        return filters.isEmpty ||
            filters.any((filter) =>
                book.category?.toLowerCase().contains(filter.toLowerCase()) ??
                false);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    booksFuture = DatabaseService().getAllBooks();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final books = await DatabaseService().getAllBooks();
    setState(() {
      allBooks = books;
      filteredBooks = books;
      activeFilters = [];
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredBooks = allBooks
          .where((book) =>
              book.bookName?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MySearchBar(onSearchChanged: _onSearchChanged),
            const SizedBox(height: 20),
            FilterButtons(
              onFilterChanged: _onFilterChanged,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.65),
                itemCount: filteredBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  final book = filteredBooks[index];
                  return BookCard(
                    title: book.bookName ?? '',
                    imageUrl: book.coverImageUrl ?? '',
                    author: book.author ?? '',
                    bookId: book.bookId ?? '',
                    category: book.category ?? '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
