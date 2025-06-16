import 'package:flutter/material.dart';
import '../responsive_manager.dart';

class TagsWidgets extends StatefulWidget {
  final String tagsName;
  const TagsWidgets({super.key, required this.tagsName});

  @override
  State<TagsWidgets> createState() => _TagsWidgetsState();
}

class _TagsWidgetsState extends State<TagsWidgets> {
  @override
  Widget build(BuildContext context) {

    final width = ResponsiveManager.screenWidth(context);
    final responsive = ResponsiveManager.size(context, 1.0);

    double? fontSize;
    double? minWidth;

    if (width >= 1400) {
      fontSize = 16 * responsive;
      minWidth = 120;
    } else if (width >= 1000) {
      fontSize = 14 * responsive;
      minWidth = 100;
    } else {
      fontSize = 12 * responsive;
      minWidth = 80;
    }

    return Container(
      height: 28 * responsive,
      constraints: BoxConstraints(minWidth: minWidth),
      padding: EdgeInsets.symmetric(horizontal: 8.0 * responsive),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8 * responsive),
        color: Colors.amber,
      ),
      alignment: Alignment.center,
      child: Text(
        widget.tagsName,
        style: TextStyle(
            fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
