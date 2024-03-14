import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:githubexplore/app/utils/constants/app_strings.dart';
import 'package:githubexplore/app/utils/constants/pallets.dart';
import 'package:githubexplore/app/utils/constants/sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final WidgetRef ref;
  const CustomTextField(
      {super.key, required this.controller, required this.ref});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ]),
      child: TextField(
        controller: controller,
        style: TextStyle(
            fontSize: Sizes.p16,
            color: Colors.black.withOpacity(0.8),
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: AppStrings.hintText,
          hintStyle: const TextStyle(
              fontSize: Sizes.p18,
              color: Colors.grey,
              fontWeight: FontWeight.w400),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            color: redColor,
            fontSize: Sizes.p18,
          ),
          prefixIcon: const Icon(Icons.search_rounded),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 220, 220, 243),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(217, 29, 170, 55),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(204, 39, 152, 17),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 226, 226, 249),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(204, 200, 30, 30),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(204, 200, 30, 30),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
