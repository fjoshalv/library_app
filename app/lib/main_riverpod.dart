import 'package:flutter/material.dart';
import 'package:library_app/configure_environment.dart';
import 'package:library_riverpod/library_riverpod.dart';

void main() {
  final environment = configureEnvironment();
  runApp(
    RiverpodLibraryApp(
      environment: environment,
    ),
  );
}
