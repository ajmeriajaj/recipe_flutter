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
  final int _limit = 10;
  int _skip = 0;
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();


  final List<Map<String, String>> sortOption = [
    {
      'label': 'Name (A-Z)',
      'sortBy': 'name',
      'order': 'asc'
    },
    {
      'label': 'Name (Z-A)',
      'sortBy': 'name',
      'order': 'desc'
    },
    {
      'label': 'Difficulty (Easy to Hard)',
      'sortBy': 'difficulty',
      'order': 'asc'
    },
    {
      'label': 'Difficulty (Hard to Easy)',
      'sortBy': 'difficulty',
      'order': 'desc'
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchPaginationRecipes();
    getAllTags();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels
          >= _scrollController.position.maxScrollExtent
          && !_isLoading && _hasMore) {
        fetchPaginationRecipes();
      }
    });
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
      _skip = 0;
      recipeList.clear();
      fetchPaginationRecipes();
      return;
    }
    final api = API();
    final response = await api.searchRecipe(query);
    final getAllRecipe = GetAllRecipe.fromJson(response);
    setState(() {
      recipeList = getAllRecipe.recipes ?? [];
      _hasMore = false;
    });
  }

  void getAllTags() async {
    final api = API();
    final response = await api.getAllTags();
    setState(() {
      filterList = List<String>.from(response);
    });
  }

  void fetchPaginationRecipes() async {
    setState(() {
      _isLoading = true;
    });

    final api = API();
    final response = await api.getPagination(_limit, _skip);
    final getAllRecipe = GetAllRecipe.fromJson(response);
    final newRecipe = getAllRecipe.recipes ?? [];

    setState(() {
      _skip += _limit;
      recipeList.addAll(newRecipe);
      _isLoading = false;
      _hasMore = newRecipe.length == _limit;
    });
  }
  
  void fetchSortedRecipe(String sortBy, String order) async {
    final api = API();
    final response = await api.getAscOrDescSort(sortBy, order);
    final getAllRecipe = GetAllRecipe.fromJson(response);
    
    setState(() {
      _skip = 0;
      recipeList = getAllRecipe.recipes ?? [];
      _hasMore = false;
    });
  }

  void getRecipeByTags(String tag) async{
    final api =API();
    final response = await api.getRecipeByTags(tag);
    final getAllRecipe = GetAllRecipe.fromJson(response);

    setState(() {
      _skip = 0;
      recipeList = getAllRecipe.recipes ?? [];
      _hasMore = false;
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
              _skip = 0;
              recipeList.clear();
              _hasMore = false;
              getRecipeByTags(value);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SearchBar(
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
                ),
                SizedBox(width: 13,),
                PopupMenuButton<Map<String, String>>(
                  icon: Icon(
                    Icons.filter_alt,
                    color: Color.fromARGB(255, 252, 70, 83),
                  ),
                    onSelected: (value) {
                    final sortBy = value['sortBy']!;
                    final order = value['order']!;
                    fetchSortedRecipe(sortBy, order);
                    },
                    itemBuilder: (BuildContext context) {
                    return sortOption.map((option) {
                      return PopupMenuItem<Map<String, String>>(
                        value: {
                          'sortBy': option['sortBy']!,
                          'order': option['order']!,
                        },
                          child: Text(option['label']!)
                      );
                    }).toList();
                    }
                )
              ],
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
                      : AllRecipeGridView(
                      recipeList: recipeList,
                    controller: _scrollController,
                  ),
            ),
            if(_isLoading)
              Padding(
                  padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}
