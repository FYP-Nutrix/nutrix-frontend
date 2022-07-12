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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(),
                      Text(
                        recipeBundle.title,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        recipeBundle.description,
                        style: const TextStyle(color: Colors.white54),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      buildInfoRow(
                        iconSrc: "assets/icons/pot.svg",
                        text: "${recipeBundle.recipes} Recipes",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildInfoRow(
                        iconSrc: "assets/icons/chef.svg",
                        text: "${recipeBundle.chefs} Chefs",
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
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
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
