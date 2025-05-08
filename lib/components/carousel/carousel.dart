import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kitapp/services/database_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomepageCarousel extends StatefulWidget {
  const HomepageCarousel({super.key});

  @override
  State<HomepageCarousel> createState() => _CarouselState();
}

class _CarouselState extends State<HomepageCarousel> {
  bool _isLoading = true;
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    try {
      final imagesData = await DatabaseService().getCarousel();
      setState(() {
        images = imagesData;
        _isLoading = false;
      });
    } catch (e) {
      print("Hata: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _isLoading,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                aspectRatio: 16 / 9,
              ),
              items: images.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
    );
  }
}
