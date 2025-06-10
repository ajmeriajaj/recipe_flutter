import 'package:flutter/material.dart';

class DetailTextWidgets extends StatefulWidget {
  final String detailHeading;
  final String mainDetail;

  const DetailTextWidgets({
    super.key,
    required this.detailHeading,
    required this.mainDetail
  });

  @override
  State<DetailTextWidgets> createState() => _DetailTextWidgetsState();
}

class _DetailTextWidgetsState extends State<DetailTextWidgets> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "${widget.detailHeading} : ",
        style: TextStyle(
          color: Colors.grey.shade500,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: widget.mainDetail,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            // ..onTap = {
            //
            // }
          ),
        ],
      ),
    );
  }
}
