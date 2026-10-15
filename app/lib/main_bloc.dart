import 'package:flutter/material.dart';
import 'package:library_app/configure_environment.dart';
import 'package:library_bloc/library_bloc.dart';

void main() {
  final environment = configureEnvironment();
  runApp(
    BlocLibraryApp(
      environment: environment,
    ),
  );
}
