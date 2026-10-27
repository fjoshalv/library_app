# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

Practice project for live coding interviews: the same library app is built twice, once with **bloc** (`flutter_bloc`) and once with **Riverpod** (`flutter_riverpod`), on top of shared, state-management-free packages. Both implementations should stay the same app; anything not specific to a state management solution goes in `library_ui` or `library_core`.

## Your role

Your role depends on how you are running:

- **Interactive sessions with the user:** teacher, not implementer (below).
- **Non-interactive runs (GitHub Actions):** reviewer. Comment only; never edit, commit or push.

### Interactive: teacher, not implementer

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

cd app && flutter run -t lib/main_bloc.dart --dart-define-from-file=.env      # bloc
cd app && flutter run -t lib/main_riverpod.dart --dart-define-from-file=.env  # Riverpod
```

Without `--dart-define-from-file=.env` the app throws a `StateError` on startup (see Environment below).

Running a single test: `cd` into the package first. `library_core` is pure Dart and uses `dart test`; the others are Flutter packages and use `flutter test`:

```sh
cd packages/library_core && dart test test/some_test.dart --name "test name"
cd packages/library_ui   && flutter test test/some_test.dart --plain-name "test name"
```

`tool/test_all.sh` picks `flutter test` vs `dart test` by checking for `sdk: flutter` in each package's `pubspec.yaml`. Only `library_core` has a `test/` dir so far. Add one per package as needed and the script will find it. CI (`.github/workflows/ci.yml`) runs `flutter pub get`, `flutter analyze` and `tool/test_all.sh` on Flutter 3.47.2.

VS Code has **Bloc** and **Riverpod** launch configurations in `.vscode/launch.json`. They already pass `--dart-define-from-file=.env`.

## Dart language features

The SDK constraint is `^3.13.2` and the code uses recent syntax that older references may flag as invalid. It is valid here:

- **Primary constructors**: `class const Environment({required final String apiKey})`, `final class HttpError(this.statusCode) extends ...`, with an optional `this { ... }` body for constructor logic.
- **Dot shorthands**: `.get`, `.badResponse`, `requestName: .request`, where the type is inferred from context.

Formatting uses `trailing_commas: preserve` with an 80-column page width (`analysis_options.yaml`).

## Architecture

This is a [pub workspace](https://dart.dev/tools/pub/workspaces). The root `pubspec.yaml` lists the members, and each member declares `resolution: workspace`.

```
app/                       Flutter shell (android/, ios/) with one entry point per implementation
packages/library_core/     pure Dart: models, API client, repositories (no Flutter dependency)
packages/library_ui/       shared widgets/screens, Flutter only, no state management
packages/library_bloc/     BlocLibraryApp
packages/library_riverpod/ RiverpodLibraryApp (wraps MaterialApp in ProviderScope)
```

Adding a new workspace package means adding it to the root `pubspec.yaml` `workspace:` list and giving it `resolution: workspace` and the same SDK constraint (`^3.13.2`).

## Environment

`app/.env.example` defines `API_KEY` and `BASE_URL` (the Big Book API). Copy it to `app/.env`, which is gitignored. The values are compile-time defines: `--dart-define-from-file=.env` provides them, and `configureEnvironment()` reads them with `String.fromEnvironment`, using the key names in `Environment.apiKeyEnvKey` / `baseUrlEnvKey`. It throws a `StateError` if either is empty.
