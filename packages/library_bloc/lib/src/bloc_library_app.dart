import 'package:flutter/material.dart';
import 'package:library_ui/library_ui.dart';

class BlocLibraryApp extends StatelessWidget {
  const BlocLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Library (Bloc)',
      home: HomeView(title: 'Bloc'),
    );
  }
}
