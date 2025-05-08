import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../providers/page_provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final pageProvider =
        Provider.of<PageProvider>(context); // PageProvider'a erişim

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 219, 219, 219),
            width: 2.0,
          ),
        ),
      ),
      child: GNav(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        color: const Color.fromARGB(255, 0, 0, 0),
        activeColor: const Color.fromARGB(255, 255, 120, 1),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Color.fromARGB(255, 255, 120, 0),
          fontWeight: FontWeight.w600,
        ),
        gap: 10,
        selectedIndex:
            pageProvider.currentIndex, // PageProvider'dan aktif indeks alınıyor
        onTabChange: (index) => pageProvider
            .updateIndex(index), // PageProvider'ın indeksini güncelliyoruz
        tabs: const [
          GButton(
            icon: Icons.home_rounded,
            text: 'Ana Sayfa',
          ),
          GButton(
            icon: Icons.menu_book_rounded,
            text: 'Kitaplar',
          ),
          GButton(
            icon: Icons.favorite,
            text: 'Favorilerim',
          ),
          GButton(
            icon: Icons.account_circle_rounded,
            text: 'Hesabım',
          ),
        ],
      ),
    );
  }
}
