import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/provider/customized_recipe_provider.dart';
import 'package:recipe/provider/recipe_provider.dart';
import 'package:recipe/screen/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CustomizedRecipeProvider(),),
          ChangeNotifierProvider(create: (_) => RecipeProvider(),),
        ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 252, 70, 83)),
        ),
        home: HomeScreen()
    );
  }
}