import 'package:flutter/material.dart';

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
