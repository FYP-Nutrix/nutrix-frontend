import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Profile/components/info.dart';
import 'package:nutrix/Screens/Profile/components/profile_menu_item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Info(
            name: "Chui Yee Bii Biiii",
            email: "cy@mail.com",
            image: "assets/images/cysotsot.png",
          ),
          SizedBox(height: 20),
          ProfileMenuItem(
            iconScr: "assets/icons/bookmark_fill.svg",
            title: "Pending 1",
            press: () {},
          ),
          ProfileMenuItem(
            iconScr: "assets/icons/chef_color.svg",
            title: "Pending 2",
            press: () {},
          ),
          ProfileMenuItem(
            iconScr: "assets/icons/language.svg",
            title: "Pending 3",
            press: () {},
          ),
          ProfileMenuItem(
            iconScr: "assets/icons/info.svg",
            title: "Pending 4",
            press: () {},
          ),
        ],
      ),
    );
  }
}
