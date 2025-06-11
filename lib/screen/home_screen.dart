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
  List<String> filterList = [];

  @override
  void initState() {
    super.initState();
    fetchAllRecipe();
    getAllTags();
  }

  void fetchAllRecipe() async {
    final api = API();
    final response = await api.getAllRecipe();
    final getAllRecipe = GetAllRecipe.fromJson(response);
    setState(() {
      recipeList = getAllRecipe.recipes ?? [];
    });
  }

  void search(String query) async {
    if (query.trim().isEmpty) {
      fetchAllRecipe();
      return;
    }
    final api = API();
    final response = await api.searchRecipe(query);
    final getAllRecipe = GetAllRecipe.fromJson(response);
    setState(() {
      recipeList = getAllRecipe.recipes ?? [];
    });
  }

  void getAllTags() async {
    final api = API();
    final response = await api.getAllTags();
    setState(() {
      filterList = List<String>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.menu),
        title: Text(
          'All Recipe',
          style: TextStyle(
            color: Color.fromARGB(255, 252, 70, 83),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.filter_list,
              color: Color.fromARGB(255, 252, 70, 83),
            ),
            onSelected: (value) {
              search(value);
            },
            itemBuilder: (BuildContext context) {
              return filterList.map((filter) {
                return PopupMenuItem(value: filter, child: Text(filter));
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SearchBar(
              controller: _searchController,
              hintText: "Search you're looking for",
              leading: Icon(Icons.search),
              onSubmitted: search,
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  fetchAllRecipe();
                }
              },
            ),
            SizedBox(height: 13),
            Expanded(
              child:
                  recipeList.isEmpty
                      ? Center(
                        child: Text(
                          "RECIPE NOT FOUND",
                          style: TextStyle(
                            color: Color.fromARGB(255, 252, 70, 83),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      : AllRecipeGridView(recipeList: recipeList),
            ),
          ],
        ),
      ),
    );
  }
}
