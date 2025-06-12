import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe/database/api/api.dart';
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
      print(res);
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
      print(res);
    } else {
      Fluttertoast.showToast(msg: "Failed to add recipe");
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
          "Add Recipe",
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
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
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
                ),
              ),
            ),
            SizedBox(height: 0.04 * getHeight(context),),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
