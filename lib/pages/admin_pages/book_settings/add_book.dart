import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';
import 'package:kitapp/services/database_service.dart';
import 'package:kitapp/utils/utils.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final bookName = TextEditingController();
  final author = TextEditingController();
  final releaseDate = TextEditingController();
  final category = TextEditingController();
  final pageNumber = TextEditingController();
  final description = TextEditingController();
  final coverImageUrl = TextEditingController();
  final pdfUrl = TextEditingController();

  @override
  void dispose() {
    bookName.dispose();
    author.dispose();
    releaseDate.dispose();
    category.dispose();
    pageNumber.dispose();
    description.dispose();
    coverImageUrl.dispose();
    pdfUrl.dispose();
    super.dispose();
  }

  void saveBook() async {
    final isEmptyBookDetails = Utils.isEmptyBookDetails(
        bookName.text,
        author.text,
        releaseDate.text,
        category.text,
        pageNumber.text,
        description.text,
        coverImageUrl.text,
        pdfUrl.text);

    if (isEmptyBookDetails) {
      Utils().showToastError('Boş alan kalmamalıdır!');
    } else {
      try {
        await DatabaseService().saveBook(
            bookName.text.trim(),
            author.text.trim(),
            releaseDate.text.trim(),
            category.text.trim(),
            pageNumber.text.trim(),
            description.text.trim(),
            coverImageUrl.text.trim(),
            pdfUrl.text.trim());
        Utils().showToastSuccess('Kitap başarıyla kaydedildi!');
        setState(() {
          bookName.text = '';
          author.text = '';
          releaseDate.text = '';
          category.text = '';
          pageNumber.text = '';
          description.text = '';
          coverImageUrl.text = '';
          pdfUrl.text = '';
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Kitap Ekle",
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  InputWidget(
                    controllerName: bookName,
                    hintText: 'Kitap Adı',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: author,
                    hintText: 'Yazar Adı',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: releaseDate,
                    hintText: 'Çıkış Yılı',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: category,
                    hintText: 'Kategori',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: pageNumber,
                    hintText: 'Sayfa Sayısı',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: description,
                    hintText: 'Açıklama',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: coverImageUrl,
                    hintText: 'Fotoğraf (url)',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: pdfUrl,
                    hintText: 'Pdf (url)',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlackRoundedButton(
                    text: 'Kitap Ekle',
                    onPressed: () {
                      saveBook();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
