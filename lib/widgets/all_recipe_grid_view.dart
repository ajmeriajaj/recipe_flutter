import 'package:flutter/material.dart';
import 'package:recipe/models/get_all_recipe.dart';
import 'package:recipe/widgets/all_recipe_widgets.dart';

class AllRecipeGridView extends StatefulWidget {
  final List<Recipes> recipeList;
  final ScrollController controller;

  const AllRecipeGridView({
    super.key,
    required this.recipeList,
    required this.controller
  });

  @override
  State<AllRecipeGridView> createState() => _AllRecipeGridViewState();
}

class _AllRecipeGridViewState extends State<AllRecipeGridView> {



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: widget.controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.40,
      ),
      itemCount: widget.recipeList.length,
      itemBuilder: (context, index) {
        final recipe = widget.recipeList[index];
        return AllRecipeWidgets(
          recipeImage: recipe.image ?? '',
          tags: recipe.tags ?? [],
          recipeTitle: recipe.name ?? '',
          preparationTime: '${recipe.prepTimeMinutes} mins',
          cookingTime: '${recipe.cookTimeMinutes} mins',
          difficulty: recipe.difficulty ?? '',
          cuisine: recipe.cuisine ?? '',
          meals: recipe.mealType ?? [],
        );
      },
    );
  }
}
