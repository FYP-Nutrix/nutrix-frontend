import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrix/Screens/Login/components/background.dart';
import 'package:nutrix/components/rounded_button.dart';
import 'package:nutrix/components/rounded_input_field.dart';
import 'package:nutrix/components/rounded_password_field.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset(
            "assets/images/sign_in.svg",
            height: size.height * 0.35,
          ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            hintText: "Your Password",
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "Login",
            press: () {},
          )
        ],
      ),
    );
  }
}
