import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe/database/api/api.dart';

class CustomizedRecipeProvider extends ChangeNotifier {
  final api = API();

  final TextEditingController addController = TextEditingController();
  final TextEditingController updateIdController = TextEditingController();
  final TextEditingController updateNameController = TextEditingController();
  final TextEditingController deleteIdController = TextEditingController();

  void addRecipe() async {
    final name = addController.text.trim();

    if(name.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter recipe name");
      return;
    }

    final res = await api.addRecipe(name);

    if(res != null) {
      Fluttertoast.showToast(msg: "Recipe Added Successfully");
      log("ADDED: $res");
      addController.clear();
    } else {
      Fluttertoast.showToast(msg: "Failed to add recipe");
    }

  }

  void updateRecipe() async {
    final id = int.tryParse(updateIdController.text.trim());
    final name = updateNameController.text.trim();

    if(id == null) {
      Fluttertoast.showToast(msg: "enter valid id");
    } else if(name.isEmpty){
      Fluttertoast.showToast(msg: "enter name");
    }

    final res = await api.updateRecipe(id!, name);

    if(res != null) {
      Fluttertoast.showToast(msg: "Recipe Updated");
      log("Updated: $res");
      updateIdController.clear();
      updateNameController.clear();
    } else {
      Fluttertoast.showToast(msg: "Failed to update recipe");
    }

  }

  void deleteRecipe() async {
    final id = int.tryParse(deleteIdController.text.trim());

    if (id == null) {
      Fluttertoast.showToast(msg: "Enter valid ID");
      return;
    }

    final res = await api.deleteRecipe(id);

    if (res != null) {
      Fluttertoast.showToast(msg: "Recipe Deleted");
      log("Deleted: $res");
      deleteIdController.clear();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete recipe");
    }

  }

  @override
  void dispose() {
    addController.dispose();
    updateIdController.dispose();
    updateNameController.dispose();
    deleteIdController.dispose();
    super.dispose();
  }
}