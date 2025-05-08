import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';
import 'package:kitapp/services/database_service.dart';
import 'package:kitapp/utils/utils.dart';

class CarouselSettings extends StatefulWidget {
  const CarouselSettings({super.key});

  @override
  State<CarouselSettings> createState() => _CarouselState();
}

class _CarouselState extends State<CarouselSettings> {
  final TextEditingController image1Controller = TextEditingController();
  final TextEditingController image2Controller = TextEditingController();
  final TextEditingController image3Controller = TextEditingController();
  List<String> images = [];

  void saveCarousel() async {
    try {
      await DatabaseService().saveCarousel(image1Controller.text.trim(),
          image2Controller.text.trim(), image3Controller.text.trim());
      Utils().showToastSuccess('Başarıyla kaydedildi.');
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadImagesUrls() async {
    try {
      final imagesData = await DatabaseService().getCarousel();
      setState(() {
        images = imagesData;
        //Set if image has already url
        image1Controller.text = images[0];
        image2Controller.text = images[1];
        image3Controller.text = images[2];
      });
    } catch (e) {
      print("Hata: $e");
    }
  }

  @override
  void initState() {
    loadImagesUrls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Carousel Düzenle",
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  InputWidget(
                    controllerName: image1Controller,
                    hintText: 'Carousel fotoğraf 1 (url)',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: image2Controller,
                    hintText: 'Carousel fotoğraf 2 (url)',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputWidget(
                    controllerName: image3Controller,
                    hintText: 'Carousel fotoğraf 3 (url)',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlackRoundedButton(
                    text: 'Fotoğrafları kaydet',
                    onPressed: () {
                      saveCarousel();
                    },
                    icon: const Icon(Icons.save_rounded),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
