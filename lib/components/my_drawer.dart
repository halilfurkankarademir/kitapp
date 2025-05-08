import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 1,
      child: ListView(
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
                child: Image.asset(
              'assets/images/logo.png',
            )),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings_rounded),
            title: const Text(
              'Admin Panel',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'AdminHomePage');
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.magicStaff),
            title: const Text(
              'Kitap Önerici',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'RecommenderPage');
            },
          ),
        ],
      ),
    );
  }
}
