import 'package:flutter/material.dart';
import 'package:nutrix/Screens/Home/home_screen.dart';
import 'package:nutrix/Screens/Profile/profile_screen.dart';

class NavItem {
  final int id;
  final String icon;
  final Widget destination;

  NavItem({required this.id, required this.icon, required this.destination});

  // if there is no destination then it helps us
  bool destinationChecker() {
    if (destination != null) {
      return true;
    }
    return false;
  }
}

class NavItems extends ChangeNotifier {
  int selectedIndex = 0;

  void changeNavIndex({required int index}) {
    selectedIndex = index;
    // if any changes made it notify widgets that use the value
    notifyListeners();
  }

  List<NavItem> items = [
    NavItem(
      id: 1,
      icon: "assets/icons/home.svg",
      destination: HomeScreen(),
    ),
    NavItem(id: 2, icon: "assets/icons/list.svg", destination: HomeScreen()),
    NavItem(id: 3, icon: "assets/icons/camera.svg", destination: HomeScreen()),
    NavItem(
        id: 4, icon: "assets/icons/chef_nav.svg", destination: HomeScreen()),
    NavItem(id: 5, icon: "assets/icons/user.svg", destination: ProfileScreen()),
  ];
}
