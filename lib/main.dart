import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kitapp/pages/admin_pages/admin_homepage.dart';
import 'package:kitapp/pages/admin_pages/author_settings/add_author.dart';
import 'package:kitapp/pages/admin_pages/author_settings/author_settings.dart';
import 'package:kitapp/pages/admin_pages/author_settings/delete_author.dart';
import 'package:kitapp/pages/admin_pages/book_settings/add_book.dart';
import 'package:kitapp/pages/admin_pages/book_settings/book_settings.dart';
import 'package:kitapp/pages/admin_pages/book_settings/delete_book.dart';
import 'package:kitapp/pages/admin_pages/carousel_settings.dart';
import 'package:kitapp/pages/home/category_details_page.dart';
import 'package:kitapp/pages/home/book_detail_page.dart';
import 'package:kitapp/pages/home/books_page.dart';
import 'package:kitapp/pages/home/main_page.dart';
import 'package:kitapp/pages/home/read_book_page.dart';
import 'package:kitapp/pages/onboarding_pages/choose_action.dart';
import 'package:kitapp/pages/onboarding_pages/onboarding_main.dart';
import 'package:kitapp/pages/recommender_pages/recommender_page.dart';
import 'package:kitapp/providers/page_provider.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'pages/auth_pages/login_page.dart';
import 'pages/auth_pages/register_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(), //Check auth status and navigate on auth change
      routes: {
        'LoginPage': (context) => const LoginPage(),
        'RegisterPage': (context) => const RegisterPage(),
        'HomePage': (context) => const MainPage(),
        'ChooseAction': (context) => const ChooseAction(),
        'Books': (context) => const BooksPage(),
        'AddBook': (context) => const AddBook(),
        'DeleteBook': (context) => const DeleteBook(),
        'BookDetailsPage': (context) => const BookDetailPage(),
        'AdminHomePage': (context) => const AdminHomepage(),
        'CategoryDetailsPage': (context) => const CategoryDetailsPage(),
        'BookSettings': (context) => const BookSettings(),
        'AuthorSettings': (context) => const AuthorSettings(),
        'AddAuthor': (context) => const AddAuthor(),
        'DeleteAuthor': (context) => const DeleteAuthor(),
        'CarouselSettings': (context) => const CarouselSettings(),
        'RecommenderPage': (context) => const RecommenderPage(),
        'ReadBookPage': (context) => const ReadBookPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //If logged in return Home page
      return const MainPage();
    } else {
      //If not logged in return login page
      return const OnboardingMain();
    }
  }
}
