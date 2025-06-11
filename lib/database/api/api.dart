import 'dart:convert';

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
 }