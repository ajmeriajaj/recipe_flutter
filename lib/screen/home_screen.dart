import 'package:flutter/material.dart';
import 'package:recipe/responsive.dart';
import 'package:recipe/widgets/all_recipe_grid_view.dart';
import 'package:recipe/widgets/custom_drop_down_widgets.dart';
import '../data/data.dart';
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

  Future<void> fetchPaginationRecipes() async {
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

  void getRecipeByMealsType(String type) async {
    final api = API();
    final response = await api.getRecipeByMealsType(type);
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
            fontSize: 27 * getResponsive(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CustomDropDownWidgets(
              iconData: Icons.fastfood,
              item: mealType,
              getLabel: (type) => type[0].toUpperCase() + type.substring(1),
              onSelect: (type) {
                getRecipeByMealsType(type);
              },
          ),
          CustomDropDownWidgets(
              iconData: Icons.filter_list,
              item: filterList,
              getLabel: (tags) => tags,
              onSelect: (tags) {
                _skip = 0;
                recipeList.clear();
                _hasMore = false;
                getRecipeByTags(tags);
              },
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Color.fromARGB(255, 252, 70, 83),
        onRefresh: () async {
          _skip = 0;
          recipeList.clear();
          _hasMore = true;
          await fetchPaginationRecipes();
        },
        child: Padding(
          padding: EdgeInsets.all(14.0 * getResponsive(context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SearchBar(
                      controller: _searchController,
                      hintText: "Search you're looking for",
                      leading: Icon(
                         color: Color.fromARGB(255, 252, 70, 83),
                          Icons.search
                      ),
                      onSubmitted: search,
                      onChanged: (value) {
                        if (value.trim().isEmpty) {
                          fetchAllRecipe();
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 0.013 * getWidth(context),),
                  CustomDropDownWidgets<Map<String, String>>(
                      iconData: Icons.filter_alt,
                      item: sortOption,
                      getLabel: (option) => option['label']!,
                      onSelect: (selectedOption) {
                        final sortBy = selectedOption['sortBy']!;
                        final order = selectedOption['order']!;
                        fetchSortedRecipe(sortBy, order);
                      },
                  ),
                ],
              ),
              SizedBox(height: 0.013 * getHeight(context)),
              Expanded(
                child:
                    recipeList.isEmpty
                        ? Center(
                          child: Text(
                            "RECIPE NOT FOUND",
                            style: TextStyle(
                              color: Color.fromARGB(255, 252, 70, 83),
                              fontSize: 23 * getResponsive(context),
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
                    padding: EdgeInsets.all(8.0 * getResponsive(context)),
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 252, 70, 83),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
