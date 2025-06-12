import 'package:flutter/material.dart';

class OnTapWidgets extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  const OnTapWidgets({super.key, required this.onTap, required this.icon});

  @override
  State<OnTapWidgets> createState() => _OnTapWidgetsState();
}

class _OnTapWidgetsState extends State<OnTapWidgets> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 23,
        color:Color.fromARGB(255, 252, 70, 83),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(widget.icon, color: Colors.white,),
        ),
      ),
    );

  }
}
