import 'package:flutter/material.dart';
import './buttons/black_filter_button.dart';

class FilterButtons extends StatefulWidget {
  const FilterButtons({super.key, required this.onFilterChanged});

  final ValueChanged<List<String>> onFilterChanged;

  @override
  State<FilterButtons> createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  final List<String> buttonLabels = [
    'Roman',
    'Şiir',
    'Öykü',
    'Tarih',
    'Bilim Kurgu',
    'Felsefe',
    'Psikoloji',
    'Klasikler',
    'Edebiyat',
    'Fantastik',
    'Polisiye',
    'Korku',
    'Macera',
    'Biyografi',
    'Otobiyografi',
    'Gezi Yazısı',
    'Araştırma',
    'Deneme',
    'Anı',
    'Mizah'
  ];

  List<String> filterWords = [];

  void addWordToFilter(String word) {
    setState(() {
      final wordExistInList = filterWords.contains(word);
      if (wordExistInList) {
        filterWords.remove(word);
      } else {
        filterWords.add(word);
      }
      widget.onFilterChanged(filterWords);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: buttonLabels.map((label) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BlackFilterButton(
              text: label,
              onPressed: () => addWordToFilter(label),
            ),
          );
        }).toList(),
      ),
    );
  }
}
