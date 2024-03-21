import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  const TitleTextWidget({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
