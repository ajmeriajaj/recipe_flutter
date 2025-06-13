import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe/models/get_all_recipe.dart';
import 'package:recipe/responsiveManager.dart';
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
  ResponsiveManager responsiveManager = ResponsiveManager();

  int getCrossAxisCount(BuildContext context) {
    final width = ResponsiveManager.screenWidth(context);

    if(ResponsiveManager.isDesktop(context)) return 5;
    if(ResponsiveManager.isTablet(context)) return 3;

    if (kIsWeb) {
      if(width >= 1400) return 6;
      if(width >= 1200) return 5;
      if(width >= 1000) return 4;
      if(width >= 950) return 4;
      if(width >= 900) return 4;
      if(width >= 850) return 4;
      if (width >= 800) return 3;
      if (width >= 600) return 2;
    }

    if (ResponsiveManager.isDesktop(context)) return 5;
    if (ResponsiveManager.isTablet(context)) return 3;

    return 2;
  }

  double getChildAspectRatio(BuildContext context) {
    double width = ResponsiveManager.screenWidth(context);

    if(ResponsiveManager.isDesktop(context)) return width / (width * 1.9);
    if(ResponsiveManager.isTablet(context)) return width / (width * 2.2);

    if(kIsWeb) {
      if (width >= 1600) return 0.58;
      if (width >= 1400) return 0.52;
      if (width >= 1200) return 0.48;
      if (width >= 1000) return 0.45;
      if (width >= 900) return 0.43;
      if(width >= 850) return 0.50;
      if(width >= 800) return 0.48;
      if(width >= 750) return 0.42;
      if (width >= 700) return 0.30;
      if (width >= 600) return 0.45;
      if (width >= 550) return 0.55;
      if (width >= 500) return 0.50;
      if (width >= 400) return 0.42;
      if (width >= 350) return 0.40;
      if (width >= 300) return 0.34;
      if (width >= 250) return 0.32;

      return width / (width * 2.9);
    }

    return width / (width * 2.4);
  }


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: widget.controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: getChildAspectRatio(context),
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
