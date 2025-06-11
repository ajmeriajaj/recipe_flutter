import 'package:flutter/material.dart';
import 'package:recipe/widgets/all_recipe_grid_view.dart';

import '../database/api/api.dart';
import '../models/get_all_recipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  List<Recipes> recipeList = [];


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
            SearchBar(
              controller: _searchController,
              hintText: "Search you're looking for",
              leading: Icon(Icons.search),
            ),
            SizedBox(height: 13,),
            Expanded(child: AllRecipeGridView(recipeList: recipeList))
          ],
        ),
      ),
    );
  }
}
