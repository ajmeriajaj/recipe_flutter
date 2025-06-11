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
}