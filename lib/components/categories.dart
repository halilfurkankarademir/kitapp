import 'dart:math';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Map<String, String> categories = {
    'Roman': 'https://cdn-icons-png.flaticon.com/512/10558/10558808.png',
    'Öykü': 'https://cdn-icons-png.flaticon.com/512/5078/5078755.png',
    'Tarih': 'https://cdn-icons-png.flaticon.com/512/7514/7514354.png',
    'B.Kurgu': 'https://cdn-icons-png.flaticon.com/512/5381/5381421.png',
    'Psikoloji': 'https://cdn-icons-png.flaticon.com/512/4987/4987513.png',
    'Fantastik': 'https://cdn-icons-png.flaticon.com/512/3839/3839827.png',
    'Polisiye': 'https://cdn-icons-png.flaticon.com/512/5318/5318971.png',
    'Macera': 'https://cdn-icons-png.flaticon.com/512/3839/3839548.png',
  };

  void openCategory(String category) {
    Navigator.pushNamed(context, 'CategoryDetailsPage', arguments: category);
  }

  final List<Color> pastelColors = [
    const Color.fromRGBO(179, 235, 242, 1), // Pastel Pink
    const Color.fromRGBO(255, 238, 140, 1), // Pastel Yellow
    const Color.fromRGBO(255, 116, 108, 1), // Pastel Green
    const Color.fromRGBO(128, 239, 128, 1), // Pastel Blue
    const Color.fromRGBO(255, 197, 211, 1), // Pastel Purple
  ];

  int randomNumber = Random().nextInt(5);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.entries.map((item) {
          return GestureDetector(
              onTap: () {
                openCategory(item.key);
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 10), //Padding between items
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: pastelColors[randomNumber],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    children: [
                      Image.network(
                        item.value,
                        width: 25,
                        height: 25,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        item.key,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ));
        }).toList(),
      ),
    );
  }
}
