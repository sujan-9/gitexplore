import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:githubexplore/app/config/routes/path_root.dart';
import 'package:githubexplore/app/utils/common_widgets/error_screen.dart';
import 'package:githubexplore/model/github_repo_model.dart';
import 'package:githubexplore/presentation/detail_screen.dart';
import 'package:githubexplore/presentation/homepage_screen.dart';
import 'package:githubexplore/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final key = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: Paths.splashRoute.path,
    navigatorKey: key,
    debugLogDiagnostics: kReleaseMode ? false : true,
    routes: [
      GoRoute(
        path: Paths.splashRoute.path,
        name: Paths.splashRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
          path: Paths.homePageScreenRoute.path,
          name: Paths.homePageScreenRoute.routeName,
          pageBuilder: (context, state) => FadeTransitionPage(
                key: state.pageKey,
                child: const HomePageScreen(),
              ),
          routes: [
            GoRoute(
                path: Paths.detailPageScreenRoute.path,
                name: Paths.detailPageScreenRoute.routeName,
                pageBuilder: (context, state) {
                  GithubRepoModel data = state.extra as GithubRepoModel;

                  return FadeTransitionPage(
                    key: state.pageKey,
                    child: DetailScreen(data: data),
                  );
                }),
          ]),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
    redirect: (BuildContext context, GoRouterState state) async {
      return null;
    },
  );
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
            child: child,
          ),
        );
}
