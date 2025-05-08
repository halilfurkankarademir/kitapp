import 'package:flutter/material.dart';
import 'package:kitapp/services/database_service.dart';
import 'package:kitapp/utils/utils.dart';
import 'package:slider_button/slider_button.dart';
import '../../../models/book_model.dart';

class DeleteBook extends StatefulWidget {
  const DeleteBook({super.key});

  @override
  State<DeleteBook> createState() => _DeleteBookState();
}

class _DeleteBookState extends State<DeleteBook> {
  late Future<List<BookModel>> booksFuture;
  List<BookModel> allBooks = [];
  BookModel? _selectedBook;

  @override
  void initState() {
    super.initState();
    booksFuture = DatabaseService().getAllBooks();
    _loadBooks();
  }

  void deleteBookById(String id) async {
    await DatabaseService().deleteBookByBookId(id);
    Utils().showToastSuccess('Kitap başarıyla silindi.');
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _loadBooks() async {
    final books = await DatabaseService().getAllBooks();
    setState(() {
      allBooks = books;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Kitap Sil",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Autocomplete<BookModel>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable.empty();
                  }
                  return allBooks.where((BookModel book) {
                    return book.bookName!.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                  });
                },
                displayStringForOption: (BookModel option) =>
                    option.bookName ?? '',
                onSelected: (BookModel selection) {
                  setState(() {
                    _selectedBook = selection;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: const InputDecoration(
                      hintText: 'Silinecek kitap adı girin',
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: SliderButton(
                    height: 60,
                    width: 400,
                    radius: 30,
                    backgroundColor: Colors.black,
                    buttonColor: Colors.red,
                    // ignore: body_might_complete_normally_nullable
                    action: () async {
                      deleteBookById(_selectedBook!.bookId ?? '');
                    },
                    label: const Text(
                      "Kitabı silmek için kaydır.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    icon: const Icon(Icons.delete_outline_rounded)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
