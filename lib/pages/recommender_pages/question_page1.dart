import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';

class QuestionPage1 extends StatefulWidget {
  const QuestionPage1(
      {super.key,
      required this.textEditingController,
      required this.onButtonClick});

  final TextEditingController textEditingController;
  final VoidCallback onButtonClick;

  @override
  State<QuestionPage1> createState() => _QuestionPage1State();
}

class _QuestionPage1State extends State<QuestionPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  'https://img.freepik.com/free-vector/questions-concept-illustration_114360-1513.jpg?t=st=1730467049~exp=1730470649~hmac=3947c20ccdfdbe3c11fd23726d707624ac121d014e6217791c69d27cb2cabbb9&w=740',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Öncelikle bana sevdiğin kitap türlerini yazar mısın?',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 40,
              ),
              InputWidget(
                  controllerName: widget.textEditingController,
                  hintText: 'Türler'),
              const SizedBox(
                height: 40,
              ),
              BlackRoundedButton(
                text: 'İleri',
                onPressed: () {
                  widget.onButtonClick();
                },
              )
            ],
          ),
        ));
  }
}
