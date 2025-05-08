import 'package:flutter/material.dart';
import 'package:kitapp/components/my_drawer.dart';
import 'package:kitapp/components/nav_bars/bottom_navigation.dart';
import 'package:kitapp/components/nav_bars/my_app_bar.dart';
import 'package:kitapp/pages/home/account_page.dart';
import 'package:kitapp/pages/home/books_page.dart';
import 'package:kitapp/pages/home/favorites_page.dart';
import 'package:kitapp/pages/home/homepage_content.dart';
import 'package:provider/provider.dart';
import '../../providers/page_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _HomePageState();
}

class _HomePageState extends State<MainPage> {
  final List<Widget> _pages = [
    const HomepageContent(),
    const BooksPage(),
    const FavoritesPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavigation(),
      body: IndexedStack(
        index: pageProvider.currentIndex,
        children: _pages,
      ),
      drawer: const MyDrawer(),
    );
  }
}
