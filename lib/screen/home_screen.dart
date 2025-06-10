import 'package:flutter/material.dart';
import 'package:recipe/widgets/all_recipe_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text(
          'All Recipe',
          style: TextStyle(
            color: Color.fromARGB(255, 252, 70, 83),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            AllRecipeGridView()
          ],
        ),
      ),
    );
  }
}
