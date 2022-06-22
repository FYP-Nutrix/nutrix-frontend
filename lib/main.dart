import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Welcome/welcome_screen.dart';
import 'package:nutrix/constrants.dart';
import 'package:nutrix/models/NavItem.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
      ),
    );
  }
}
