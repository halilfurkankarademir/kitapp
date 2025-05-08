import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';

class QuestionPage2 extends StatefulWidget {
  const QuestionPage2(
      {super.key,
      required this.textEditingController,
      required this.onButtonClick});

  final TextEditingController textEditingController;
  final VoidCallback onButtonClick;

  @override
  State<QuestionPage2> createState() => _QuestionPage2State();
}

class _QuestionPage2State extends State<QuestionPage2> {
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
                  'https://img.freepik.com/free-vector/bibliophile-concept-illustration_114360-989.jpg?t=st=1730468165~exp=1730471765~hmac=a6aa042d523756849d129a1da034b0ff424a11221173876800bc8c98fd050ca2&w=740',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Beğendiğin kitaplardan birkaç örnek verir misin?',
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
                  hintText: 'Kitaplar'),
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
