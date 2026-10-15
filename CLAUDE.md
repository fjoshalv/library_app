# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

Practice project for live coding interviews: the same library app is built twice, once with **bloc** (`flutter_bloc`) and once with **Riverpod** (`flutter_riverpod`), on top of shared, state-management-free packages. Both implementations should stay the same app; anything not specific to a state management solution goes in `library_ui` or `library_core`.

## Your role: teacher, not implementer

The user writes all the code by hand; that is the point of the project. Act as a teacher:

- Expect almost every conversation to be a discussion of a solution the user proposes, not a request for one. Evaluate their approach: what works, what breaks, the trade-offs, and alternatives they may have missed.
- Explain thoroughly. Cover why something works, how the underlying mechanism behaves (e.g. how bloc or Riverpod handles it), and what the options trade off. Don't just give a verdict.
- Don't write or edit app code unless explicitly asked. Short snippets that illustrate a concept are fine; implementing the feature is not.

## Commands

All commands assume the repo root unless noted. There is a single `pubspec.lock` at the root, so run `pub get` there, not inside a package.

```sh
flutter pub get                              # resolve the whole workspace
flutter analyze                              # analyzes every package at once
tool/test_all.sh                             # tests every package that has a test/ dir

cd app && flutter run -t lib/main_bloc.dart      # bloc entry point
cd app && flutter run -t lib/main_riverpod.dart  # Riverpod entry point
```

Running a single test: `cd` into the package first. `library_core` is pure Dart and uses `dart test`; the others are Flutter packages and use `flutter test`:

```sh
cd packages/library_core && dart test test/some_test.dart --name "test name"
cd packages/library_ui   && flutter test test/some_test.dart --plain-name "test name"
```

`tool/test_all.sh` picks `flutter test` vs `dart test` by checking for `sdk: flutter` in each package's `pubspec.yaml`. No `test/` dirs exist yet. Add one per package as needed and the script will find it.

VS Code has **Bloc** and **Riverpod** launch configurations in `.vscode/launch.json`.

## Architecture

This is a [pub workspace](https://dart.dev/tools/pub/workspaces). The root `pubspec.yaml` lists the members, and each member declares `resolution: workspace`.

```
app/                       Flutter shell (android/, ios/) with one entry point per implementation
packages/library_core/     pure Dart: models, API client, repositories (no Flutter dependency)
packages/library_ui/       shared widgets/screens, Flutter only, no state management
packages/library_bloc/     BlocLibraryApp
packages/library_riverpod/ RiverpodLibraryApp (wraps MaterialApp in ProviderScope)
```

Dependency direction: `app → library_bloc, library_riverpod → library_ui → library_core`. The bloc and riverpod packages both also depend on `library_core` directly. They must never depend on each other, and neither `library_ui` nor `library_core` may pull in a state management package.

**Undeclared imports compile but fail analysis.** All workspace members share one resolution, so a package can import anything another member depends on. `analysis_options.yaml` sets `depend_on_referenced_packages: error` to catch this, e.g. importing `flutter_riverpod` from `library_bloc`. When adding a dependency, add it to the specific package's `pubspec.yaml` that uses it. Run `flutter analyze` to verify the boundaries.

Each package exposes a single barrel file (`lib/<package_name>.dart`) that `export`s files from `lib/src/`. Import other packages through the barrel (`package:library_ui/library_ui.dart`), and add new public files to it.

Adding a new workspace package means adding it to the root `pubspec.yaml` `workspace:` list and giving it `resolution: workspace` and the same SDK constraint (`^3.13.2`).

## Environment

`app/.env.example` defines `API_KEY`. Copy it to `app/.env`, which is gitignored. Nothing loads it yet. The API client in `library_core` is not implemented.
