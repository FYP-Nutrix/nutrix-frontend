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
    imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/38.jpg",
    color: Color(0xFF90AF17),
  ),
  RecipeBundle(
    id: 3,
    chefs: 1,
    recipes: 43,
    title: "Dinner",
    description: "Pasta",
  imageSrc: "https://foodimage.blob.core.windows.net/labelimages/meal_logging/38.jpg",
    color: Color(0xFF2DBBD8),
  ),
];
