import 'package:flutter/material.dart';
import 'package:flutter_tdd_boilerplate/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_route_path.dart';
import 'package:flutter_tdd_boilerplate/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/pages/product_home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tdd_boilerplate/splash_screen.dart';

class AppRouter{

static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: '/',
          path: AppRoutePath.root,
          builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),

      GoRoute(
        path: AppRoutePath.loginPage,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutePath.dashboard,
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardScreen();
        },
      ),

    ]
);



static GoRouter get router => _router;
}