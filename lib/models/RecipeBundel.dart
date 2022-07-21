import 'package:flutter/material.dart';

class RecipeBundle {
  final int id, chefs, recipes;
  final String title, description, imageSrc;
  final Color color;

  RecipeBundle(
      {required this.id,
      required this.chefs,
      required this.recipes,
      required this.title,
      required this.description,
      required this.imageSrc,
      required this.color});
}

// Demo list
List<RecipeBundle> recipeBundles = [
  RecipeBundle(
    id: 1,
    chefs: 1,
    recipes: 95,
    title: "Breakfast",
    description: "Pasta",
    imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/38.jpg",
    color: Color(0xFFD82D40),
  ),
  RecipeBundle(
    id: 2,
    chefs: 1,
    recipes: 26,
    title: "Lunch",
    description: "Pasta",
    imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/1.jpg",
    color: Color(0xFF90AF17),
  ),
  RecipeBundle(
    id: 3,
    chefs: 1,
    recipes: 43,
    title: "Dinner",
    description: "Pasta",
  imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/2.jpg",
    color: Color(0xFF2DBBD8),
  ),
];

List<RecipeBundle> newrecipeBundles = [
  RecipeBundle(
    id: 1,
    chefs: 1,
    recipes: 95,
    title: "Breakfast",
    description: "Pasta",
    imageSrc: "https://www.seriouseats.com/thmb/_BkW9V2wK3Zed-zQAETkRSJS8ac=/1500x1125/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2018__04__20180309-french-fries-vicky-wasik-15-5a9844742c2446c7a7be9fbd41b6e27d.jpg",
    color: Color(0xFFD82D40),
  ),
  RecipeBundle(
    id: 2,
    chefs: 1,
    recipes: 95,
    title: "Breakfast",
    description: "Pasta",
    imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/38.jpg",
    color: Color(0xFFD82D40),
  ),
  RecipeBundle(
    id: 3,
    chefs: 1,
    recipes: 26,
    title: "Lunch",
    description: "Pasta",
    imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/1.jpg",
    color: Color(0xFF90AF17),
  ),
  RecipeBundle(
    id: 4,
    chefs: 1,
    recipes: 43,
    title: "Dinner",
    description: "Pasta",
  imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/2.jpg",
    color: Color(0xFF2DBBD8),
  ),
];