import 'package:flutter/material.dart';

class BlackRoundedButton extends StatelessWidget {
  const BlackRoundedButton(
      {super.key, required this.text, required this.onPressed, this.icon});

  final String text;
  final VoidCallback onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        icon: icon,
        label: Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
