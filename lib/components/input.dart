import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.controllerName,
      required this.hintText,
      this.icon,
      this.isObscure});

  final TextEditingController controllerName;
  final String hintText;
  final Icon? icon;
  final bool? isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerName,
      obscureText: isObscure ?? false,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: icon,
          hintStyle: const TextStyle(
              fontFamily: 'Poppins', color: Colors.black, fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
