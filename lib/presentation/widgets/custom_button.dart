import 'package:flutter/material.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_text.dart';
import 'package:githubexplore/app/utils/constants/pallets.dart';

class CustonButton extends StatelessWidget {
  final CustomText text;
  final VoidCallback onPressed;

  const CustonButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: text,
    );
  }
}
