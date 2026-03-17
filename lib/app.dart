import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes.dart';
import 'theme/theme.dart';

class HireIQApp extends ConsumerWidget {
  const HireIQApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'HireIQ',
      theme: HireIQTheme.light(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
