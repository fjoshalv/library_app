# library_app

Practice project for live coding interviews: the same library app built twice,
once with **bloc** and once with **Riverpod**, on top of a shared core.

## Layout

A [pub workspace](https://dart.dev/tools/pub/workspaces) with a single Flutter app
and one entry point per state management solution.

```
app/                        Flutter app shell (android/, ios/)
  lib/main_bloc.dart        runs BlocLibraryApp
  lib/main_riverpod.dart    runs RiverpodLibraryApp
packages/
  library_core/             pure Dart: models, API client, repositories
  library_ui/               shared widgets/screens, no state management
  library_bloc/             bloc implementation
  library_riverpod/         Riverpod implementation
```

Dependencies: `app → library_bloc, library_riverpod → library_ui → library_core`.
`library_bloc` and `library_riverpod` never depend on each other. Undeclared imports
fail `flutter analyze` (`depend_on_referenced_packages` is set to error).

## Running

```sh
flutter pub get                        # once, at the repo root
cd app
flutter run -t lib/main_bloc.dart      # or lib/main_riverpod.dart
```

In VS Code, use the **Bloc** / **Riverpod** launch configurations.

## Checks

```sh
flutter analyze        # at the root, analyzes every package
tool/test_all.sh       # runs the tests of every package
```
