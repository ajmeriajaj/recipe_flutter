import 'package:flutter/material.dart';

class CustomDropDownWidgets<T> extends StatefulWidget {
  final IconData iconData;
  final List<T> item;
  final String Function(T) getLabel;
  final void Function(T) onSelect;

  const CustomDropDownWidgets({
    super.key,
    required this.iconData,
    required this.item,
    required this.getLabel,
    required this.onSelect
  });

  @override
  State<CustomDropDownWidgets<T>> createState() => _CustomDropDownWidgetsState<T>();
}

class _CustomDropDownWidgetsState<T> extends State<CustomDropDownWidgets<T>> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
        icon: Icon(
          widget.iconData,
            color: Color.fromARGB(255, 252, 70, 83)
        ),
        onSelected: widget.onSelect,
        itemBuilder: (context) {
          return widget.item.map((item) {
            return PopupMenuItem<T>(
                value: item,
                child: Text(widget.getLabel(item))
            );
          } ,).toList();
        }
    );
  }
}
