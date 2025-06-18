import 'package:flutter/material.dart';
import 'package:recipe/responsive.dart';
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
  final List<String> meals;


  const AllRecipeWidgets({
    super.key,
    required this.recipeImage,
    required this.tags,
    required this.recipeTitle,
    required this.preparationTime,
    required this.cookingTime,
    required this.difficulty,
    required this.cuisine,
    required this.meals,
  });

  @override
  State<AllRecipeWidgets> createState() => _AllRecipeWidgetsState();
}

class _AllRecipeWidgetsState extends State<AllRecipeWidgets> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                padding: EdgeInsets.all(6.0 * getResponsive(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.recipeTitle,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 0.007 * getHeight(context)),
                    SizedBox(
                        height: 0.040 * getHeight(context),
                        child: TagsListView(
                            tags: widget.tags
                        )
                    ),
                    SizedBox(height: 0.007 * getHeight(context)),
                    DetailTextWidgets(
                      detailHeading: 'Preparation Time',
                      mainDetail: widget.preparationTime,
                    ),
                    SizedBox(height: 0.007 * getHeight(context),),
                    DetailTextWidgets(
                        detailHeading: 'Cooking Time',
                        mainDetail: widget.cookingTime
                    ),
                    SizedBox(height: 0.007 * getHeight(context),),
                    DetailTextWidgets(
                        detailHeading: 'Difficulty',
                        mainDetail: widget.difficulty
                    ),
                    SizedBox(height: 0.007 * getHeight(context),),
                    DetailTextWidgets(
                        detailHeading: 'Cuisine',
                        mainDetail: widget.cuisine
                    ),
                    SizedBox(height: 0.007 * getHeight(context),),
                    Text(
                      'Meal Types : ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 0.007 * getHeight(context),),
                    SizedBox(
                        height: 0.040 * getHeight(context),
                        child: TagsListView(
                            tags: widget.meals
                        )
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
