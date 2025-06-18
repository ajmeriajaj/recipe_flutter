import 'package:flutter/cupertino.dart';
import 'package:recipe/database/api/api.dart';

import '../models/get_all_recipe.dart';

class RecipeProvider extends ChangeNotifier {
  final api = API();

  final int _limit = 10;
  int _skip = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  List<Recipes> _recipeList = [];
  List<Recipes> get recipeList => _recipeList;

  List<String> _filterList = [];
  List<String> get filterList => _filterList;

  final ScrollController scrollController = ScrollController();

  RecipeProvider() {
    scrollController.addListener(scrollListener);
    fetchPaginationRecipe();
    getAllTags();
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent &&
        !_isLoading && _hasMore
    ) {
      fetchPaginationRecipe();
    }
  }

  Future<void> fetchAllRecipe() async {
    _isLoading = true;
    notifyListeners();

    resetPagination(); // reset values
    final response = await api.getPagination(_limit, _skip);
    final data = GetAllRecipe.fromJson(response);
    _recipeList = data.recipes ?? [];
    _skip += _limit;
    _hasMore = _recipeList.length == _limit;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    resetPagination();
    await fetchAllRecipe();
  }

  Future<void> fetchPaginationRecipe() async {
    _isLoading = true;
    notifyListeners();

    final response = await api.getPagination(_limit, _skip);
    final data = GetAllRecipe.fromJson(response);
    final newRecipe = data.recipes ?? [];

    _skip += _limit;
    _recipeList.addAll(newRecipe);
    _hasMore = newRecipe.length == _limit;
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) async {
    if (query.trim().isEmpty) {
      resetPagination();
      fetchPaginationRecipe();
      return;
    }

    final response = await api.searchRecipe(query);
    final getAllRecipe = GetAllRecipe.fromJson(response);

    _recipeList = getAllRecipe.recipes ?? [];
    _hasMore = false;
    notifyListeners();
  }

  void fetchSortedRecipe(String sortBy, String order) async {
    final response = await api.getAscOrDescSort(sortBy, order);
    final getAllRecipe = GetAllRecipe.fromJson(response);

    _recipeList = getAllRecipe.recipes ?? [];
    _hasMore = false;
    notifyListeners();
  }

  void getAllTags() async {
    final response = await api.getAllTags();
    _filterList = List<String>.from(response);
    notifyListeners();
  }

  void getRecipeByTags(String tag) async {
    final response = await api.getRecipeByTags(tag);
    final getAllRecipe = GetAllRecipe.fromJson(response);

    _recipeList = getAllRecipe.recipes ?? [];
    _hasMore = false;
    notifyListeners();
  }

  void getRecipeByMeals(String type) async {
    final response = await api.getRecipeByMealsType(type);
    final getAllRecipe = GetAllRecipe.fromJson(response);

    _recipeList = getAllRecipe.recipes ?? [];
    _hasMore = false;
    notifyListeners();
  }

  void resetPagination() {
    _skip = 0;
    _hasMore = true;
    _recipeList.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}