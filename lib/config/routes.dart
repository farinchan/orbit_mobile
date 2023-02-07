import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keanggotaan_orbit/views/pages/auth/auto_login.dart';
import 'package:keanggotaan_orbit/views/pages/auth/login_page.dart';
import 'package:keanggotaan_orbit/views/pages/auth/register_page.dart';
import 'package:keanggotaan_orbit/views/pages/home_page.dart';
import 'package:keanggotaan_orbit/views/pages/onboarding_page.dart';

final GoRouter routes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/autoLogin',
      name: 'auto_login',
      builder: (BuildContext context, GoRouterState state) {
        return AutoLogin();
      },
    ),
    GoRoute(
      path: '/onboarding',
      name: "onboarding",
      builder: (BuildContext context, GoRouterState state) {
        return onboardingPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: 'register',
          name: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return RegisterPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/',
      name: "home_page",
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
    ),
  ],
  initialLocation: "/autoLogin",
  debugLogDiagnostics: true,
  routerNeglect: true,
);
