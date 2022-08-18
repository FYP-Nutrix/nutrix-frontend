import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nutrix/Screens/Login/login_screen.dart';
import 'package:nutrix/api/auth_api.dart';
import 'package:nutrix/components/already_have_an_account_check.dart';
import 'package:nutrix/components/build_input_decoration.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/models/user_model.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _switchValue = true;
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  final formKey = GlobalKey<FormState>();

  String _firstName = "",
      _lastName = "",
      _email = "",
      _phoneNumber = "",
      _confimrPassword = "",
      _password = "";

  bool _is_patient = false;

  @override
  Widget build(BuildContext context) {
    AuthAPI auth = Provider.of<AuthAPI>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please Wait"),
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        auth.loggedInStatus = Status.Authenticating;
        auth.notify();

        Future.delayed(loginTime).then((_) {
          Navigator.pushReplacementNamed(context, '/login');
          auth.loggedInStatus = Status.LoggedIn;
          auth.notify();
        });

        if (_password == _confimrPassword) {
          auth
              .register(_firstName, _lastName, _email, _phoneNumber, _password)
              .then((response) {
            if (response['status']) {
              UserModel user = response['data'];
            }
          });
        }
      } else {
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign Up Now"),
                SizedBox(height: 15),
                Text("Email"),
                TextFormField(
                  autofocus: false,
                  // validator: validateEmail,
                  onSaved: (value) => _email = value!,
                  decoration: buildInputDecoration("Enter Email", Icons.email),
                ),
                SizedBox(height: 20),
                Text("First Name"),
                SizedBox(height: 5),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => _firstName = value!,
                  decoration: buildInputDecoration(
                      "Enter First Name", Icons.text_fields),
                ),
                SizedBox(height: 20),
                Text("Last Name"),
                SizedBox(height: 5),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => _lastName = value!,
                  decoration: buildInputDecoration(
                      "Enter Last Name", Icons.text_fields),
                ),
                SizedBox(height: 20),
                Text("Phone Number"),
                SizedBox(height: 5),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => _phoneNumber = value!,
                  decoration:
                      buildInputDecoration("Enter Phone Number", Icons.phone),
                ),
                SizedBox(height: 20),
                Text("Password"),
                SizedBox(height: 5),
                TextFormField(
                  obscureText: true,
                  autofocus: false,
                  onSaved: (value) => _password = value!,
                  decoration:
                      buildInputDecoration("Enter Password", Icons.lock),
                ),
                SizedBox(height: 20),
                Text("Confirm Password"),
                SizedBox(height: 5),
                TextFormField(
                  obscureText: true,
                  autofocus: false,
                  onSaved: (value) => _confimrPassword = value!,
                  decoration: buildInputDecoration(
                      "Enter Confirm Password", Icons.lock),
                ),
                SizedBox(height: 20),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : MaterialButton(
                        onPressed: doRegister,
                        textColor: kPrimaryLightColor,
                        color: kPrimaryColor,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        height: 45,
                        minWidth: 600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                AlreadyHaveAnAccountCheck(
                  login: false,
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
          ),
        ),
      ),
    );
  }
}
