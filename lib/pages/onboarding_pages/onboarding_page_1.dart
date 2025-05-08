import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Image(
                        width: 300,
                        height: 300,
                        image: AssetImage('assets/images/onboarding1.jpg')),
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Sınırsız kitap oku!",
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
                      "Kitapp ile dilediğin kadar kitap okuyabilir,",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ))));
  }
}
