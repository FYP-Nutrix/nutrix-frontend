import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrix/Screens/Login/login_screen.dart';
import 'package:nutrix/Screens/Profile/components/info.dart';
import 'package:nutrix/Screens/Profile/components/profile_menu_item.dart';
import 'package:nutrix/components/rounded_button.dart';

class EditProfilePicture extends StatefulWidget {
  const EditProfilePicture({Key? key}) : super(key: key);

  @override
  State<EditProfilePicture> createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Faield to pick image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Info(
      name: "Chui Yee Test",
      email: "cy@mail.com",
      image: "assets/images/cysotsot.png",
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          EditProfilePicture(),
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
          RoundedButton(
            text: "Log Out",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
