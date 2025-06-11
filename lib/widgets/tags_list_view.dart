import 'package:flutter/cupertino.dart';
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: widget.tags.length,
        itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: TagsWidgets(tagsName: widget.tags[index]),
        );
        }
    );
  }
}
