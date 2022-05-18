import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrix/models/RecipeBundel.dart';

class RecipeBundelcard extends StatelessWidget {
  final RecipeBundle recipeBundle;
  final VoidCallback press;

  const RecipeBundelcard(
      {Key? key, required this.recipeBundle, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
          decoration: BoxDecoration(
            color: recipeBundle.color,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        recipeBundle.title,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        recipeBundle.description,
                        style: TextStyle(color: Colors.white54),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      buildInfoRow(
                        iconSrc: "assets/icons/pot.svg",
                        text: "${recipeBundle.recipes} Recipes",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildInfoRow(
                        iconSrc: "assets/icons/chef.svg",
                        text: "${recipeBundle.chefs} Chefs",
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              AspectRatio(
                aspectRatio: 0.71,
                child: Image.asset(
                  recipeBundle.imageSrc,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          )),
    );
  }

  Row buildInfoRow({required String iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
