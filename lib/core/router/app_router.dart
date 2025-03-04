import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/login_page.dart';
import 'auth_service.dart';

final authService = AuthService();

final goRouter = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) {
    final isLoggedIn = authService.isAuthenticated;
    final isInitialized = authService.initialized;
    final isLoggingIn = state.matchedLocation == '/login';

    // If not initialized, don't redirect
    if (!isInitialized) return null;

    // If not logged in and not on login page, redirect to login
    if (!isLoggedIn && !isLoggingIn) return '/login';

    // If logged in and on login page, redirect to home
    if (isLoggedIn && isLoggingIn) return '/home';

    // No redirect needed
    return null;
  },
  refreshListenable: authService,
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
); 