import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe/database/api/api.dart';
import 'package:recipe/widgets/card_widgets.dart';
import 'package:recipe/widgets/on_tap_widgets.dart';
import 'package:recipe/widgets/text_field_widget.dart';
import '../responsive.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _addRecipe = TextEditingController();
  final _idController = TextEditingController();
  final _newNameController = TextEditingController();
  final _idControllerForDelete = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void addPost(String recipeName) async {
    final recipeName = _addRecipe.text.trim();

    if(recipeName.trim().isEmpty) {
      Fluttertoast.showToast(msg: "first add recipe Name");
      return;
    }

    final res = await API().addRecipe(recipeName);

    if(res != null) {
      Fluttertoast.showToast(msg: "Recipe Added Successfully!");
      log(res);
      _addRecipe.clear();
    } else {
      Fluttertoast.showToast(msg: "Failed to add recipe");
    }
  }

  void updateRecipe() async{
    final idText = _idController.text.trim();
    final newName = _newNameController.text.trim();

    final id = int.tryParse(idText);

    if(idText.isEmpty) {
      Fluttertoast.showToast(msg: 'enter id');
    } else if(id == null) {
      Fluttertoast.showToast(msg: "Invalid id");
    } else if (newName.isEmpty) {
      Fluttertoast.showToast(msg: "enter name");
    }

    final res = await API().updateRecipe(id!, newName);

    if(res != null) {
      Fluttertoast.showToast(msg: "Recipe update Successfully!");
      log(res);
      _idController.clear();
      _newNameController.clear();
    } else {
      Fluttertoast.showToast(msg: "Failed to update recipe");
    }
  }

  void deleteRecipe() async {
    final idText = _idControllerForDelete.text.trim();
    final id = int.tryParse(idText);

    if(idText.isEmpty) {
      Fluttertoast.showToast(msg: 'enter id');
    } else if (id == null) {
      Fluttertoast.showToast(msg: "Invalid id");
    }

    final res = await API().deleteRecipe(id!);

    if(res != null) {
      Fluttertoast.showToast(msg: "Recipe Delete Successfully!");
      log(res);
      _idControllerForDelete.clear();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete recipe");
    }
  }

  @override
  void dispose() {
    _addRecipe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customized Recipes",
          style: TextStyle(
            color: Color.fromARGB(255, 252, 70, 83),
            fontSize: 27 * getResponsive(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(13.0 * getResponsive(context)),
        child: Column(
          children: [
            CardWidgets(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextFieldWidget(
                          controller: _addRecipe,
                          hint: "add recipe name",
                        )
                    ),
                    SizedBox(width: 0.023 * getWidth(context),),
                    OnTapWidgets(
                      onTap: () => addPost(_addRecipe.text.toString()),
                      icon: Icons.post_add,
                    ),
                  ],
                )
            ),
            SizedBox(height: 0.04 * getHeight(context),),
            CardWidgets(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextFieldWidget(
                            controller: _idController,
                            hint: 'enter id',
                          ),
                          SizedBox(height: 0.013 * getHeight(context),),
                          TextFieldWidget(
                            controller: _newNameController,
                            hint: 'enter recipe name',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 0.023 * getWidth(context),),
                    OnTapWidgets(
                      onTap: () => updateRecipe(),
                      icon: Icons.change_circle,
                    ),
                  ],
                ),
            ),
            SizedBox(height: 0.04 * getHeight(context),),
            CardWidgets(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextFieldWidget(
                          controller: _idControllerForDelete,
                          hint: "enter id for delete recipe",
                        )
                    ),
                    SizedBox(width: 0.023 * getWidth(context),),
                    OnTapWidgets(
                      onTap: () => deleteRecipe(),
                      icon: Icons.delete,
                    ),
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
