import 'package:flutter/material.dart';
import 'package:githubexplore/app/utils/constants/sizes.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  // Private constructor
  const CustomText._({
    required this.text,
    required this.textStyle,
  });

  // Factory constructor for large text
  factory CustomText.large(String text, {Color? color}) {
    return CustomText._(
      text: text,
      textStyle: TextStyle(
        fontSize: Sizes.p26,
        //fontWeight: FontWeight.bold,
        fontFamily: 'Lato',
        color: color ?? Colors.black,
      ),
    );
  }

  // Factory constructor for medium text
  factory CustomText.medium(String text, {Color? color}) {
    return CustomText._(
      text: text,
      textStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: color ?? Colors.black,
      ),
    );
  }

  // Factory constructor for small text
  factory CustomText.small(String text, {Color? color}) {
    return CustomText._(
      text: text,
      textStyle: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.normal,
        color: color ?? Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
