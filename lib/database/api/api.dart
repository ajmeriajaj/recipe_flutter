import 'dart:convert';
import 'dart:developer';

import 'package:recipe/database/injection/injection.dart';

class API {
  getAllRecipe() async {
    var res = await restClient.getAllRecipe();
    return jsonDecode(res);
  }

  searchRecipe(String query) async {
    var res = await restClient.searchRecipe(query);
    return jsonDecode(res);
  }

  getAllTags() async {
    var res = await restClient.getAllTags();
    return jsonDecode(res);
  }

  getPagination(int limit, int skip) async {
    var res = await restClient.getPagination(limit, skip);
    return jsonDecode(res);
  }

  getAscOrDescSort(String sortBy, String order) async {
    var res = await restClient.getSort(sortBy, order);
    return jsonDecode(res);
  }

  getRecipeByTags(String tag) async {
    var res = await restClient.getRecipeByTags(tag);
    return jsonDecode(res);
  }

  getRecipeByMealsType(String type) async {
    var res = await restClient.getMeals(type);
    return jsonDecode(res);
  }

  addRecipe(String name) async {
    try {
      Map<String, dynamic> body = {
        'method': 'POST',
        'name': name
      };

      final res = await restClient.addPost(body);
      log("API Response: $res");

      return jsonDecode(res);
    } catch (error, stackTrace) {
      log("API Error: $error");
      log("Stack Trace: $stackTrace");
      return null;
    }
  }

  updateRecipe(int id, String newName) async {
    try {
      Map<String, dynamic> body = {
        'name': newName
      };

      final res = await restClient.updateRecipe(id, body);
      log("Updated Response $res");
      return jsonDecode(res);
    } catch (error, stackTrace) {
      log("API Error: $error");
      log("Stack Trace: $stackTrace");
    }
  }
}