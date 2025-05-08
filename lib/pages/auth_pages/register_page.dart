import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';
import 'package:kitapp/services/auth.dart';
import 'package:kitapp/services/database_service.dart';

import '../../utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    super.dispose();
  }

  Future<void> createUser() async {
    final isEmptyRegister = Utils.isEmptyRegister(
        usernameController.text,
        emailController.text,
        passwordController.text,
        passwordAgainController.text);

    final passwordMatch = Utils.passwordMatch(
        passwordController.text, passwordAgainController.text);

    if (isEmptyRegister) {
      Utils().showToastError('Tüm alanları doldurunuz!');
    } else if (!passwordMatch) {
      Utils().showToastError('Şifreler eşleşmiyor!');
    } else {
      try {
        await Auth().createUser(
            email: emailController.text, password: passwordController.text);
        DatabaseService()
            .saveUserDetails(usernameController.text, emailController.text);
        if (mounted) {
          Navigator.pushReplacementNamed(context, 'HomePage');
        }
      } on FirebaseAuthException catch (e) {
        // ignore: avoid_print
        print('hata $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Kayıt Ol',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              const Image(
                  width: 200,
                  height: 200,
                  image: AssetImage('assets/images/login_register.jpg')),
              const SizedBox(
                height: 25,
              ),
              InputWidget(
                controllerName: usernameController,
                hintText: 'Kullanıcı Adı',
                icon: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 25,
              ),
              InputWidget(
                controllerName: emailController,
                hintText: 'Email',
                icon: const Icon(
                  Icons.email_rounded,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InputWidget(
                controllerName: passwordController,
                isObscure: true,
                hintText: 'Şifre',
                icon: const Icon(
                  Icons.lock,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InputWidget(
                controllerName: passwordAgainController,
                isObscure: true,
                hintText: 'Şifre Tekrar',
                icon: const Icon(
                  Icons.lock,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              BlackRoundedButton(
                  text: 'Kayıt Ol',
                  onPressed: () {
                    createUser();
                  }),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, 'LoginPage'),
                child: const Text('Giriş Yap'),
              ),
              const SizedBox(height: 50), // Alt boşluk eklemek için
            ],
          ),
        ),
      ),
    );
  }
}
