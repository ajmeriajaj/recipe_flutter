import 'package:flutter/material.dart';

import '../responsive.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
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
    );
  }
}
