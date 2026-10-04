import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_ui/library_ui.dart';

class RiverpodLibraryApp extends StatelessWidget {
  const RiverpodLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        title: 'Library (Riverpod)',
        home: HomeView(title: 'Riverpod'),
      ),
    );
  }
}
