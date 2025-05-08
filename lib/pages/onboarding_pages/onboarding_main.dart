import 'package:flutter/material.dart';
import 'package:kitapp/pages/onboarding_pages/onboarding_page_1.dart';
import 'package:kitapp/pages/onboarding_pages/onboarding_page_2.dart';
import 'package:kitapp/pages/onboarding_pages/onboarding_page_3.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({super.key});

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) => {
            setState(() {
              onLastPage = (index == 2);
            })
          },
          children: const [
            OnboardingPage1(),
            OnboardingPage2(),
            OnboardingPage3()
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100, // Genişlik 100px
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Arka plan siyah
                      foregroundColor: Colors.white, // Yazı rengi beyaz
                    ),
                    onPressed: () {
                      _controller.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    label: const Text('Geri',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins')),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.black,
                        dotHeight: 10,
                        dotWidth: 10)),
                onLastPage
                    ? SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'ChooseAction');
                          },
                          child: const Text(
                            'Başla',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 100,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          label: const Text(
                            'İleri',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          iconAlignment: IconAlignment.end,
                        ),
                      ),
              ],
            ))
      ],
    ));
  }
}
