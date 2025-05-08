import 'package:flutter/material.dart';
import 'package:kitapp/models/author_model.dart';
import 'package:kitapp/services/database_service.dart';
import 'package:slider_button/slider_button.dart';

import '../../../utils/utils.dart';

class DeleteAuthor extends StatefulWidget {
  const DeleteAuthor({super.key});

  @override
  State<DeleteAuthor> createState() => _DeleteAuthorState();
}

class _DeleteAuthorState extends State<DeleteAuthor> {
  late Future<List<AuthorModel>> authorsFuture;
  List<AuthorModel> allAuthors = [];
  AuthorModel? _selectedAuthor;

  @override
  void initState() {
    super.initState();
    authorsFuture = DatabaseService().getAllAuthors();
    _loadAuthors();
  }

  void deleteAuthorById(String id) async {
    await DatabaseService().deleteAuthorById(id);
    Utils().showToastSuccess('Yazar başarıyla silindi.');
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _loadAuthors() async {
    final authors = await DatabaseService().getAllAuthors();
    setState(() {
      allAuthors = authors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Yazar Sil",
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
              Autocomplete<AuthorModel>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable.empty();
                  }
                  return allAuthors.where((AuthorModel author) {
                    return author.authorName!.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                  });
                },
                displayStringForOption: (AuthorModel option) =>
                    option.authorName ?? '',
                onSelected: (AuthorModel selection) {
                  setState(() {
                    _selectedAuthor = selection;
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
                      hintText: 'Silinecek yazar adı girin',
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
                      deleteAuthorById(_selectedAuthor!.authorId ?? '');
                    },
                    label: const Text(
                      "Yazarı silmek için kaydır.",
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
