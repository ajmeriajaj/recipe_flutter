

import 'package:flutter/material.dart';
import 'package:recipe/widgets/tags_widgets.dart';

class MealsListView extends StatefulWidget {
  final List<String> meals;
  const MealsListView({super.key, required this.meals});

  @override
  State<MealsListView> createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.meals.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: TagsWidgets(tagsName: widget.meals[index]),
          );
        }
    );
  }
}
