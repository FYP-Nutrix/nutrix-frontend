import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Home/home_screen.dart';
import 'package:nutrix/Screens/Login/login_screen.dart';
import 'package:nutrix/Screens/Welcome/welcome_screen.dart';
import 'package:nutrix/api/auth_api.dart';
import 'package:nutrix/api/user_api.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/models/NavItem.dart';
import 'package:nutrix/models/user_model.dart';
import 'package:nutrix/utility/shared_preference.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<UserModel> getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthAPI()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => NavItems(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Eiyo Hehe',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
            accentColor: kPrimaryLightColor,
          ),
          home: WelcomeScreen(),
          routes: {
            '/login': (context) => LoginScreen(),
            '/dashboard': (context) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
