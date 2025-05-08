import 'package:flutter/material.dart';
import 'package:kitapp/components/buttons/black_rounded_button.dart';
import 'package:kitapp/components/input.dart';
import 'package:kitapp/services/auth.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  void signOut() async {
    await Auth().signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, 'LoginPage');
    }
  }

  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'Hesabım',
                  style: TextStyle(
                      fontFamily: 'Cy',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.person,
                  color: Colors.orange,
                  size: 24,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InputWidget(
                controllerName: _usernameController, hintText: 'Kullanıcı Adı'),
            const SizedBox(
              height: 20,
            ),
            BlackRoundedButton(
              text: 'Değişiklikleri Kaydet',
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.save_rounded),
            ),
            const SizedBox(
              height: 20,
            ),
            BlackRoundedButton(
              text: 'Çıkış Yap',
              onPressed: () {
                signOut();
              },
              icon: const Icon(Icons.logout_rounded),
            )
          ],
        ),
      ),
    );
  }
}
