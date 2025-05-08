import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

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
                  image: AssetImage('assets/images/onboarding3.jpg')),
              SizedBox(
                height: 100,
              ),
              Text(
                "Artık Kitapp'i \n kullanmaya hazırsın! ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: 'Poppins'),
              )
            ],
          ),
        ));
  }
}
