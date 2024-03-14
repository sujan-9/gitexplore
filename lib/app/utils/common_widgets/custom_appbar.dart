import 'package:flutter/material.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_text.dart';
import 'package:githubexplore/app/utils/constants/pallets.dart';
import 'package:githubexplore/app/utils/constants/sizes.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {super.key,
      required this.title,
      this.icon,
      this.suffixIcon,
      this.isBack = false});

  final String title;
  final IconButton? icon;
  final IconButton? suffixIcon;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: redColor,
      leading: isBack
          ? IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ))
          : const SizedBox.shrink(),
      toolbarHeight: 80,
      titleSpacing: 0,
      title: CustomText.large(
        title,
        color: whiteColor,
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Sizes.p80);
}
