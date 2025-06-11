import 'package:flutter/material.dart';
import 'package:recipe/responsive.dart';

class TagsWidgets extends StatefulWidget {
  final String tagsName;
  const TagsWidgets({super.key, required this.tagsName});

  @override
  State<TagsWidgets> createState() => _TagsWidgetsState();
}

class _TagsWidgetsState extends State<TagsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.023 * getHeight(context),
      constraints: BoxConstraints(minWidth: 0.23 * getWidth(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.amber,
      ),
      alignment: Alignment.center,
      child: Text(
        widget.tagsName,
        style: TextStyle(
            fontWeight: FontWeight.bold,
          fontSize: 14 * getResponsive(context)
        ),
      ),
    );
  }
}
