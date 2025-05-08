import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';

class ChooseAction extends StatelessWidget {
  const ChooseAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/choose_action.jpg'),
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 100,
            ),
            BlackRoundedButton(
              text: 'Hesap Oluştur',
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'RegisterPage');
              },
            ),
            const SizedBox(
              height: 50,
            ),
            BlackRoundedButton(
              text: 'Giriş Yap',
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'LoginPage');
              },
            ),
          ],
        ),
      )),
    );
  }
}
