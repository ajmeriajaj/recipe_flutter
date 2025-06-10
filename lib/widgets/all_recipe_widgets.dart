import 'package:flutter/material.dart';
import 'package:recipe/widgets/tags_list_view.dart';
import 'detail_text_widgets.dart';

class AllRecipeWidgets extends StatefulWidget {
  final String recipeImage;
  final List<String> tags;
  final String recipeTitle;
  final String preparationTime;
  final String cookingTime;
  final String difficulty;
  final String cuisine;


  const AllRecipeWidgets({
    super.key,
    required this.recipeImage,
    required this.tags,
    required this.recipeTitle,
    required this.preparationTime,
    required this.cookingTime,
    required this.difficulty,
    required this.cuisine,
  });

  @override
  State<AllRecipeWidgets> createState() => _AllRecipeWidgetsState();
}

class _AllRecipeWidgetsState extends State<AllRecipeWidgets> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10,
        child: SizedBox(
          height: 500,
          width: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(17),
                ),
                child: Image.network(
                  widget.recipeImage,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipeTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    SizedBox(
                      height: 30,
                        child: TagsListView(
                            tags: widget.tags
                        )
                    ),
                    SizedBox(height: 6),
                    DetailTextWidgets(
                      detailHeading: 'Preparation Time',
                      mainDetail: widget.preparationTime,
                    ),
                    SizedBox(height: 6,),
                    DetailTextWidgets(
                        detailHeading: 'Cooking Time',
                        mainDetail: widget.cookingTime
                    ),
                    SizedBox(height: 6,),
                    DetailTextWidgets(
                        detailHeading: 'Difficulty',
                        mainDetail: widget.difficulty
                    ),
                    SizedBox(height: 6,),
                    DetailTextWidgets(
                        detailHeading: 'Cuisine',
                        mainDetail: widget.cuisine
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
