import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';

class AuthorSettings extends StatefulWidget {
  const AuthorSettings({super.key});

  @override
  State<AuthorSettings> createState() => _AuthorSettingsState();
}

class _AuthorSettingsState extends State<AuthorSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Yazar Ayarları',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlackRoundedButton(
              text: 'Yazar Ekle',
              onPressed: () {
                Navigator.pushNamed(context, 'AddAuthor');
              },
            ),
            const SizedBox(
              height: 40,
            ),
            BlackRoundedButton(
              text: 'Yazar Sil',
              onPressed: () {
                Navigator.pushNamed(context, 'DeleteAuthor');
              },
            )
          ],
        ),
      ),
    );
  }
}
