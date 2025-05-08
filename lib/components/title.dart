import 'package:flutter/material.dart';
import 'package:kitapp/providers/page_provider.dart';
import 'package:provider/provider.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, required this.text, required this.showAllBooks});

  final String text;
  final bool showAllBooks;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Cy', fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 5),
          ],
        ),
        showAllBooks
            ? TextButton.icon(
                onPressed: () {
                  Provider.of<PageProvider>(context, listen: false).updateIndex(
                      1); //Go books page if clicked this (1 refers to index of books page)
                },
                label: const Text(
                  'Tüm kitaplar',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'Cy',
                      fontWeight: FontWeight.w400),
                ),
                icon: const Icon(Icons.arrow_right, size: 18),
                iconAlignment: IconAlignment.end,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 10, right: 0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
