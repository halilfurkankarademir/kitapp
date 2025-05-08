import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';
import 'package:kitapp/services/auth.dart';
import '../../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    final isValid =
        Utils.isValidLogin(emailController.text, passwordController.text);
    if (isValid) {
      try {
        await Auth().signIn(
            email: emailController.text, password: passwordController.text);

        if (mounted) {
          Navigator.pushReplacementNamed(context, 'HomePage');
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    } else {
      Utils().showToastError('Tüm boşlukları doldurunuz!');
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
                'Giriş Yap',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ).animate().fadeIn(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeInOut),

              const SizedBox(height: 25),
              const Image(
                  width: 200,
                  height: 200,
                  image: AssetImage('assets/images/login_register.jpg')),
              const SizedBox(height: 50),
              InputWidget(
                controllerName: emailController,
                hintText: 'Email',
                icon: const Icon(
                  Icons.email_rounded,
                  size: 16,
                ),
              ),
              const SizedBox(height: 30),
              InputWidget(
                controllerName: passwordController,
                isObscure: true,
                hintText: 'Şifre',
                icon: const Icon(
                  Icons.lock,
                  size: 16,
                ),
              ),
              const SizedBox(height: 50),
              BlackRoundedButton(
                  text: 'Giriş Yap',
                  onPressed: () {
                    signIn();
                  }),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, 'RegisterPage'),
                child: const Text('Kayıt Ol'),
              ),
              const SizedBox(height: 50), // Altta yeterli boşluk bırakmak için
            ],
          ),
        ),
      ),
    );
  }
}
