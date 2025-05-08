import 'package:flutter/material.dart';
import 'package:kitapp/services/database_service.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  int _usersCount = 0;
  int _booksCount = 0;
  int _authorsCount = 0;

  void _getCountDatas() async {
    final int userCount = await DatabaseService().getUsersCount();
    final int bookCount = await DatabaseService().getBooksCount();
    final int authorCount = await DatabaseService().getAuthorsCount();
    setState(() {
      _usersCount = userCount;
      _booksCount = bookCount;
      _authorsCount = authorCount;
    });
  }

  @override
  void initState() {
    _getCountDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            'Admin Panel',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AdminButtons(
                  text: 'Kitap Ayarları',
                  onPressed: () {
                    Navigator.pushNamed(context, 'BookSettings');
                  },
                  icon: const Icon(Icons.book),
                ),
                const SizedBox(
                  height: 25,
                ),
                AdminButtons(
                  text: 'Carousel',
                  onPressed: () {
                    Navigator.pushNamed(context, 'CarouselSettings');
                  },
                  icon: const Icon(Icons.image),
                ),
                const SizedBox(
                  height: 25,
                ),
                StatsWidget(
                  usersCount: _usersCount,
                  booksCount: _booksCount,
                )
              ],
            )));
  }
}

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required int usersCount,
    required int booksCount,
  })  : _usersCount = usersCount,
        _booksCount = booksCount;

  final int _usersCount;
  final int _booksCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatsContainer(
          count: _usersCount,
          text: 'Kullanıcı',
          icon: const Icon(Icons.person_2_rounded),
        ),
        const SizedBox(
          width: 30,
        ),
        StatsContainer(
          count: _booksCount,
          text: 'Kitap',
          icon: const Icon(Icons.menu_book_rounded),
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }
}

class StatsContainer extends StatelessWidget {
  const StatsContainer({
    super.key,
    required int count,
    required this.text,
    required this.icon,
  }) : _count = count;

  final int _count;
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 227, 227, 227),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 100,
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$_count',
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            icon
          ],
        ));
  }
}

class AdminButtons extends StatelessWidget {
  const AdminButtons({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,
        label: Text(
          text,
          style: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 227, 227, 227),
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2),
      ),
    );
  }
}
