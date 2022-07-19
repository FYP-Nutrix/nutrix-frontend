import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nutrix/Screens/CaloriesSetting/edit_calories.dart';
import 'package:nutrix/Screens/Profile/components/info.dart';
import 'package:nutrix/Screens/Profile/components/profile_menu_item.dart';
import 'package:nutrix/api/user_api.dart';
import 'package:nutrix/components/rounded_button.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/models/user_model.dart';
import 'package:nutrix/utility/settings.dart';
import 'package:nutrix/utility/shared_preference.dart';
import 'package:provider/provider.dart';

class EditProfilePicture extends StatefulWidget {
  const EditProfilePicture({Key? key}) : super(key: key);

  @override
  State<EditProfilePicture> createState() => _EditProfilePictureState();
}

class _EditProfilePictureState extends State<EditProfilePicture> {
  late Future<UserModel> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = UserProvider().fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 240,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 150,
                    color: kPrimaryColor,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 8,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  snapshot.data!.profile_pic),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        snapshot.data!.firstName +
                            " " +
                            snapshot.data!.lastName,
                        style: TextStyle(
                          fontSize: 22,
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data!.email,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8492A2),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
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
          CaloriesMenuItem(),
          RoundedButton(
            text: "Log Out",
            press: () {
              UserPreferences().removeUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

class CaloriesMenuItem extends StatefulWidget {
  const CaloriesMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  State<CaloriesMenuItem> createState() => _CaloriesMenuItemState();

}

class _CaloriesMenuItemState extends State<CaloriesMenuItem> {
    @override
  Widget build(BuildContext context) {
    return ProfileMenuItem(
      iconScr: "assets/icons/bookmark_fill.svg",
      title: "Calories Settings",
      press: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EditCaloriesScreen();
            },
          ),
        );
      },
    );
  }
}