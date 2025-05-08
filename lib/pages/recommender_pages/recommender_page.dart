import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/pages/recommender_pages/question_page1.dart';
import 'package:kitapp/pages/recommender_pages/question_page2.dart';
import 'package:kitapp/pages/recommender_pages/question_page3.dart';
import 'package:lottie/lottie.dart';

class RecommenderPage extends StatefulWidget {
  const RecommenderPage({super.key});

  @override
  State<RecommenderPage> createState() => _RecommenderPageState();
}

class _RecommenderPageState extends State<RecommenderPage> {
  String? apiKey = dotenv.env['gemini_api_key'];
  String? recommend;
  String welcomeText =
      "Merhaba Kitap Önerici'ye hoş geldin! Senden aldığım bilgiler ile sana en doğru kitabı önermeye çalışacağım.";
  bool hasResponse = false;
  bool isLoading = false;
  bool onLastPage = false;
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final TextEditingController _type = TextEditingController();
  final TextEditingController _likedBooks = TextEditingController();
  final TextEditingController _frequency = TextEditingController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _type.dispose();
    _likedBooks.dispose();
    _frequency.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _model =
        GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey.toString());
    _chatSession = _model.startChat();
  }

  Future<void> _sendRequest() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await _chatSession.sendMessage(
        Content.text(
            'Merhaba bana ${_type.text} türünde kitaplar önermeni istiyorum, işte bazı bilgiler. Beğendiğim kitaplar ${_likedBooks.text} kitap okuma sıklığım ${_frequency.text}. Lütfen bana cevap olarak kitabın konusunu, yazarını, adını gibi temel detayları yaz.'),
      );
      var text = response.text;
      // Remove unnecessary symbols
      text = text?.replaceAll(RegExp(r'\*{1,2}'), '');
      text = text?.trim();
      setState(() {
        recommend = text;
        hasResponse = true;
        isLoading = false;
      });
      print('Cevap : $text');
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Kitap Önerici',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            if (!isLoading && !hasResponse) // Yalnızca yüklenmiyorsa göster
              PageView(
                controller: _pageController,
                children: [
                  QuestionPage1(
                    textEditingController: _type,
                    onButtonClick: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                  ),
                  QuestionPage2(
                    textEditingController: _likedBooks,
                    onButtonClick: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                  ),
                  QuestionPage3(
                    textEditingController: _frequency,
                    onButtonClick: () {
                      _sendRequest();
                    },
                  )
                ],
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = (index == 2);
                  });
                },
              ),
            if (isLoading)
              Center(
                child: Lottie.asset('assets/animations/loading.json',
                    width: 125, height: 125),
              ),
            if (hasResponse && !isLoading)
              Center(
                child: ResponseWidget(recommend: recommend),
              ),
          ],
        ),
      ),
    );
  }
}

class ResponseWidget extends StatelessWidget {
  const ResponseWidget({
    super.key,
    required this.recommend,
  });

  final String? recommend;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 226, 226, 226),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            recommend ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          BlackRoundedButton(
            icon: const Icon(Icons.logout_rounded),
            text: 'Çıkış',
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      )),
    );
  }
}
