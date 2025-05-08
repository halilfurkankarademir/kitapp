import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';

class BookSettings extends StatefulWidget {
  const BookSettings({super.key});

  @override
  State<BookSettings> createState() => _BookSettingsState();
}

class _BookSettingsState extends State<BookSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text(
          "Kitap Ayarları",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              BlackRoundedButton(
                text: 'Kitap Ekle',
                onPressed: () {
                  Navigator.pushNamed(context, 'AddBook');
                },
              ),
              const SizedBox(
                height: 40,
              ),
              BlackRoundedButton(
                text: 'Kitap Sil',
                onPressed: () {
                  Navigator.pushNamed(context, 'DeleteBook');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
