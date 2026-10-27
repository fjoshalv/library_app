# Package boundaries

Dependency direction: `app → library_bloc, library_riverpod → library_ui → library_core`. The bloc and riverpod packages both also depend on `library_core` directly. They must never depend on each other, and neither `library_ui` nor `library_core` may pull in a state management package.

**Undeclared imports compile but fail analysis.** All workspace members share one resolution, so a package can import anything another member depends on. `analysis_options.yaml` sets `depend_on_referenced_packages: error` to catch this, e.g. importing `flutter_riverpod` from `library_bloc`. When adding a dependency, add it to the specific package's `pubspec.yaml` that uses it. Run `flutter analyze` to verify the boundaries.

Each package exposes a single barrel file (`lib/<package_name>.dart`) that `export`s files from `lib/src/`. Import other packages through the barrel (`package:library_ui/library_ui.dart`), and add new public files to it.
