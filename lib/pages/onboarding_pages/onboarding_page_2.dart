import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image(
                  width: 300,
                  height: 300,
                  image: AssetImage('assets/images/onboarding2.jpg')),
              SizedBox(
                height: 100,
              ),
              Text(
                "Yapay Zeka Destekli",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: 'Cy'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Kitapp ile yapay zeka destekli kitap önerisi alabilirsin!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Poppins'),
              )
            ],
          ),
        ));
  }
}
