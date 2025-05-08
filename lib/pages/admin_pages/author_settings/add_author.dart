import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/services/database_service.dart';
import 'package:kitapp/utils/utils.dart';

class AddAuthor extends StatefulWidget {
  const AddAuthor({super.key});

  @override
  State<AddAuthor> createState() => _AddAuthorState();
}

class _AddAuthorState extends State<AddAuthor> {
  final authorName = TextEditingController();
  final authorImageUrl = TextEditingController();

  @override
  void dispose() {
    authorName.dispose();
    authorImageUrl.dispose();
    super.dispose();
  }

  void addAuthor() async {
    try {
      DatabaseService().addAuthor(authorName.text, authorImageUrl.text);
      Utils().showToastSuccess('Yazar eklendi.');
      setState(() {
        authorName.text = '';
        authorImageUrl.text = '';
      });
    } catch (e) {
      Utils().showToastError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Yazar Ekle",
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
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
                    controllerName: authorName,
                    hintText: 'Yazar Adı',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: authorImageUrl,
                    hintText: 'Yazar Fotoğrafı (url)',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlackRoundedButton(
                    text: 'Yazar Ekle',
                    onPressed: () {
                      addAuthor();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key, required this.controllerName, required this.hintText});

  final TextEditingController controllerName;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerName,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              const TextStyle(fontFamily: 'Poppins', color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
