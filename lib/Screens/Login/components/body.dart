import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrix/Screens/Login/components/background.dart';
import 'package:nutrix/Screens/SignUp/new_signup_screen.dart';
import 'package:nutrix/api/auth_api.dart';
import 'package:nutrix/components/already_have_an_account_check.dart';
import 'package:nutrix/components/rounded_button.dart';
import 'package:nutrix/components/rounded_input_field.dart';
import 'package:nutrix/components/rounded_password_field.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _LoginPageBodyState createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<Body> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  String _email = "", _password = "";

  @override
  Widget build(BuildContext context) {
    AuthAPI auth = Provider.of<AuthAPI>(context);
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/images/sign_in.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Form(
              key: globalFormKey,
              child: Column(
                children: <Widget>[
                  RoundedInputField(
                    hintText: "Your Email",
                    onSaved: (value) => _email = value!,
                  ),
                  RoundedPasswordField(
                    hintText: "Your Password",
                    onSaved: (value) => _password = value!,
                  ),
                  RoundedButton(
                    text: "Login",
                    press: () {
                      final form = globalFormKey.currentState;
            
                      if (form!.validate()) {
                        form.save();
            
                        final Future<Map<String, dynamic>> response =
                            auth.login(_email, _password);
            
                        response.then((response) {
                          if (response['message'] == "Succesful") {
                            // navigate to homescreen
                            Navigator.pushReplacementNamed(context, '/dashboard');
                          }
                        });
                      } else {
                        Flushbar(
                          title: 'Invalid form',
                          message: 'Please complete the form properly',
                          duration: Duration(seconds: 10),
                        ).show(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Register();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
