import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          backgroundColor: Color(0xFF1A2B4A),
          body: Center(
            child: Text(
              'HireIQ',
              style: TextStyle(
                color: Color(0xFF0D9488),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
});
