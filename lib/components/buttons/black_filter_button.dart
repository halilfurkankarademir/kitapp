import 'package:flutter/material.dart';

class BlackFilterButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const BlackFilterButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BlackFilterButtonState createState() => _BlackFilterButtonState();
}

class _BlackFilterButtonState extends State<BlackFilterButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
        setState(() {
          isPressed = !isPressed; // Basıldığında rengi değiştirmek için
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isPressed
            ? const Color.fromARGB(255, 255, 151, 33)
            : const Color.fromARGB(255, 242, 242, 242),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isPressed ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
        ),
      ),
    );
  }
}
