import 'package:flutter/material.dart';
import 'package:recipe/models/get_all_recipe.dart';
import 'package:recipe/widgets/all_recipe_widgets.dart';

import '../database/api/api.dart';

class AllRecipeGridView extends StatefulWidget {
  const AllRecipeGridView({super.key});

  @override
  State<AllRecipeGridView> createState() => _AllRecipeGridViewState();
}

class _AllRecipeGridViewState extends State<AllRecipeGridView> {
  late List<Recipes> recipeList = [];

  @override
  void initState() {
    super.initState();
    fetchAllRecipe();
  }

  void fetchAllRecipe() async {
    final api = API();
    final response = await api.getAllRecipe();
    final getAllRecipe = GetAllRecipe.fromJson(response);
    setState(() {
      recipeList = getAllRecipe.recipes ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.47,
        ),
        itemCount: recipeList.length,
        itemBuilder: (context, index) {
          final recipe = recipeList[index];
          return AllRecipeWidgets(
            recipeImage: recipe.image ?? '',
            tags: recipe.tags ?? [],
            recipeTitle: recipe.name ?? '',
            preparationTime: '${recipe.prepTimeMinutes} mins',
            cookingTime: '${recipe.cookTimeMinutes} mins',
            difficulty: recipe.difficulty ?? '',
            cuisine: recipe.difficulty ?? '',
          );
        },
      ),
    );
  }
}
