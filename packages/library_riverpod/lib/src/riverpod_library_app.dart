import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_core/library_core.dart';
import 'package:library_riverpod/src/core/environment_provider.dart';
import 'package:library_ui/library_ui.dart';

class const RiverpodLibraryApp({
  super.key,
  required this.environment,
}) extends StatelessWidget {
  final Environment environment;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [environmentProvider.overrideWithValue(environment)],
      child: MaterialApp(
        title: 'Library (Riverpod)',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const HomeView(title: 'Riverpod'),
      ),
    );
  }
}
