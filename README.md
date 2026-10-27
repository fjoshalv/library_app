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

## Environment

The app talks to the Big Book API and needs two values, `API_KEY` and
`BASE_URL`. Copy the example file and fill them in:

```sh
cp app/.env.example app/.env           # app/.env is gitignored
```

They are compile-time defines (`--dart-define-from-file=.env`). Without them the
app throws a `StateError` on startup.

## Running

```sh
flutter pub get                        # once, at the repo root
cd app
flutter run -t lib/main_bloc.dart --dart-define-from-file=.env
flutter run -t lib/main_riverpod.dart --dart-define-from-file=.env
```

In VS Code, use the **Bloc** / **Riverpod** launch configurations. They already
pass `--dart-define-from-file=.env`.

## Checks

```sh
flutter analyze        # at the root, analyzes every package
tool/test_all.sh       # runs the tests of every package that has a test/ dir
```

CI runs the same checks on every PR into `develop` or `master` and on pushes to
them.

## Dart version

The SDK constraint is `^3.13.2`, and the code uses recent language features such
as primary constructors and dot shorthands (`.get`, `.badResponse`).

## Use of AI

I used Claude to discuss the monorepo structure and how to support both state
management solutions in one project. I proposed the possible approaches, and
Claude helped me weigh them and explained the parts I didn't know yet.

The code is written by hand, since the point of this project is practice. Claude
is only used to discuss things that are new to me, not to write the app.
