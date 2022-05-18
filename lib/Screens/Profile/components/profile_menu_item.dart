import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrix/constrants.dart';


class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key? key,
    required this.iconScr,
    required this.title,
    required this.press,
  }) : super(key: key);
  final String iconScr, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              SvgPicture.asset(iconScr),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: kTextLightColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: kTextLightColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
