import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QuestionPage3 extends StatefulWidget {
  const QuestionPage3(
      {super.key,
      required this.textEditingController,
      required this.onButtonClick});

  final TextEditingController textEditingController;
  final VoidCallback onButtonClick;

  @override
  State<QuestionPage3> createState() => _QuestionPage3State();
}

class _QuestionPage3State extends State<QuestionPage3> {
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
                  'https://img.freepik.com/free-vector/clock-concept-illustration_114360-27336.jpg?t=st=1730468571~exp=1730472171~hmac=45f293e60c86629640a4a50b5879de4c5ab3cf762f3f915fc50a86b8cc144f33&w=740',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Son olarak ne sıklıkla kitap okursun?',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 65,
              ),
              InputWidget(
                  controllerName: widget.textEditingController,
                  hintText: 'Okuma sıklığı'),
              const SizedBox(
                height: 40,
              ),
              BlackRoundedButton(
                text: 'Benzer kitap öner',
                icon: Icon(MdiIcons.magicStaff),
                onPressed: () {
                  widget.onButtonClick();
                },
              )
            ],
          ),
        ));
  }
}
