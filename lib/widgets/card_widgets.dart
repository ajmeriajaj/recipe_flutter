import 'package:flutter/material.dart';

class CardWidgets extends StatefulWidget {
  final Widget child;
  const CardWidgets({super.key, required this.child});

  @override
  State<CardWidgets> createState() => _CardWidgetsState();
}

class _CardWidgetsState extends State<CardWidgets> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
        child: widget.child,
      ),
    );
  }
}
