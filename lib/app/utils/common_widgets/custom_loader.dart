import 'package:flutter/material.dart';
import 'package:githubexplore/app/utils/constants/pallets.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeWidth;

  const CustomCircularProgressIndicator({
    this.color = redColor, // Default color
    this.size = 48, // Default size
    this.strokeWidth = 4, // Default stroke width
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
