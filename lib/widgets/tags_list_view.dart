import 'package:flutter/cupertino.dart';
import 'package:recipe/responsive.dart';
import 'package:recipe/responsiveManager.dart';
import 'package:recipe/widgets/tags_widgets.dart';

class TagsListView extends StatefulWidget {
  final List<String> tags;
  const TagsListView({super.key, required this.tags});

  @override
  State<TagsListView> createState() => _TagsListViewState();
}

class _TagsListViewState extends State<TagsListView> {

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveManager.size(context, 6.0);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
        itemCount: widget.tags.length,
        itemBuilder: (context, index) {
        return TagsWidgets(tagsName: widget.tags[index]);
        },
      separatorBuilder: (context, index) => SizedBox(width: spacing,),
    );
  }
}
