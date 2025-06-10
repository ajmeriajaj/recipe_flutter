import 'dart:convert';

import 'package:recipe/database/injection/injection.dart';

class API {
  getAllRecipe() async {
    var res = await restClient.getAllRecipe();
    return jsonDecode(res);
  }
}