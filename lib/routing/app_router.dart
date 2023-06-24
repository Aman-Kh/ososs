import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ososs/common_widgets/error_widget.dart';
import 'package:ososs/views/not_found_view.dart';

import '../views/home_view.dart';

class AppRouter {
  // all the route paths. So that we can access them easily  across the app
  static String get HOME_VIEW => '/HomeView';
  static String get Not_FOUND_VIEW => '/NotFoundView';

  /// The route configuration.
  /// use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: HOME_VIEW,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: Not_FOUND_VIEW,
        builder: (BuildContext context, GoRouterState state) {
          return const NotFoundView();
        },
      ),
    ],
    errorBuilder: errorWidget,
  );

  // to call it in views
  static GoRouter get router => _router;
}
