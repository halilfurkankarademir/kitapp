import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Image(
        image: AssetImage('assets/images/logo.png'),
        width: 150,
        height: 150,
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'RecommenderPage');
            },
            icon: Icon(
              MdiIcons.magicStaff,
              color: Colors.black,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
