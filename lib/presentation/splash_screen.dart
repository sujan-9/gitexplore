import 'package:flutter/material.dart';
import 'package:githubexplore/app/config/routes/path_root.dart';
import 'package:githubexplore/app/utils/common_widgets/custom_loader.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.go(Paths.homePageScreenRoute.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomCircularProgressIndicator(),
      ),
    );
  }
}
