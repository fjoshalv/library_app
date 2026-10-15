import 'package:flutter/material.dart';
import 'package:library_core/library_core.dart';
import 'package:library_ui/library_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const BlocLibraryApp({
  super.key,
  required this.environment,
}) extends StatelessWidget {
  final Environment environment;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: environment),
      ],
      child: MaterialApp(
        title: 'Library (Bloc)',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const HomeView(title: 'Bloc'),
      ),
    );
  }
}
