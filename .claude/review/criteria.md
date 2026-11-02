# Review criteria
<!-- Used by the CI reviewer (Step 4) and the pre-pr-review skill (Step 7).
     Kept outside .claude/rules/ on purpose, so it never loads in coding sessions.
     How to apply these (scope, confidence, caps) lives in ground_rules.md. -->

Every finding has a **category** (what kind of problem, from Report) and a
**severity** (how bad, from Severities). Start each comment with both:
`🔴 Blocker (parity): ...`, `🟠 Warning (tests): ...`, `🔵 Note (readability): ...`

## Report
The categories worth a comment. Anything outside them is not reported.
<!-- These names become the `category` enum in Step 5's schema, and Step 9
     counts false positives per category. Add "other" there, not here. -->
- **correctness**: bugs, crashes, wrong data, race conditions, leaks.
- **security**: secrets or environment values exposed in code or commits.
- **parity**: `library_bloc` and `library_riverpod` behaving differently, or
  differing without reason.
- **architecture**: code in the wrong package or layer, missing barrel exports,
  unused dependencies.
- **design-tokens**: hardcoded design values outside `lib/src/theme/`.
- **tests**: missing, weakened or ineffective tests.
- **error-handling**: errors swallowed or not exposed in state; screens without
  loading, error or empty states.
- **performance**: unnecessary rebuilds or expensive work in `build()`.
- **accessibility**: UI that is hard to use with assistive technology.
- **readability**: names, structure, comments, PR size.

## Skip
Never report these, at any severity:
- Anything `flutter analyze` reports, including package boundary imports.
- Formatting (whitespace, line breaks, trailing commas).
  <!-- Nothing in CI enforces formatting yet. Either keep this line or add
       `dart format --set-exit-if-changed .` to ci.yml (deterministic, F1.5). -->
- Code the PR did not change (see ground_rules.md, Scope).

## Severities

### 🔴 Blocker
Breaks, or is likely to break, behaviour. Must be resolved before merge. A
change is a blocker when it:
- (correctness) Introduces a bug with a concrete failing scenario, such as a
  crash, wrong data or an unhandled error (e.g. `!` on a nullable API field).
- (correctness) Lets a `DioException` or any other non-`NetworkException`
  escape `library_core`.
  <!-- keep in sync with .claude/rules/library_core.md -->
- (correctness) Introduces a race condition, such as a stale response
  overwriting a newer one.
- (correctness) Opens a stream, controller or subscription without closing or
  disposing it.
- (security) Exposes a secret, such as a hardcoded API key, or a committed `.env`.
- (parity) Adds behaviour to only one of `library_bloc` / `library_riverpod`, or
  makes them behave differently.
  <!-- keep in sync with .claude/rules/state-management.md -->

Example:
```dart
// packages/library_bloc/lib/src/books/books_bloc.dart
emit(state.copyWith(books: [...books]..sort((a, b) => a.title.compareTo(b.title))));

// packages/library_riverpod/lib/src/books/books_notifier.dart
state = AsyncData(books);
// 🔴 Blocker (parity): bloc sorts books by title, Riverpod keeps API order,
// so the two apps show the same list in a different order.
```

### 🟠 Warning
Doesn't break behaviour today, but makes the code harder to trust, test or
maintain. The author fixes it, accepts it or justifies it before merge. A
change is a warning when it:
- (design-tokens) Hardcodes a color, size, radius, duration or text style
  outside `lib/src/theme/` instead of using AppColors / AppSpacing /
  AppTextTheme.
  <!-- keep in sync with .claude/rules/library_ui.md -->
- (tests) Adds logic with no test at the mirrored path: `packages/<pkg>/lib/src/<path>.dart`
  → `packages/<pkg>/test/src/<path>_test.dart`. Exempt: barrel files,
  `lib/src/theme/`, `app/lib/main_*.dart`, and classes with no logic (only
  fields and a constructor).
- (tests) Removes, skips or weakens an existing test.
- (tests) Adds a test that can't fail, such as one with no `expect` or an
  assertion that is always true.
- (architecture) Puts code in `library_bloc` or `library_riverpod` that doesn't
  use bloc or Riverpod, so it belongs in `library_ui` or `library_core`.
- (architecture) Re-implements something `library_core` or `library_ui` already
  provides.
- (architecture) Calls a repository or `NetworkManager` from a widget, instead
  of going through a bloc or provider.
- (architecture) Adds a public file to a package without exporting it from the
  package barrel (`lib/<package_name>.dart`).
- (architecture) Adds a dependency to a `pubspec.yaml` that the package doesn't use.
- (error-handling) Swallows an error, such as `catch (_) {}`, or turns a failure
  into an empty result without exposing it in the state.
- (error-handling) Adds a screen that handles only the success state, with no
  loading, error or empty state.
- (performance) Does expensive work in `build()` (sorting, filtering, parsing,
  creating controllers), or builds a long or unbounded list with
  `ListView(children: ...)` instead of `ListView.builder`.
- (performance) Uses state classes without value equality, or watches a whole
  object in Riverpod where `select` would do.
- (readability) Adds a `build()` method longer than about 80 lines.
- (accessibility) Adds an interactive element without a `Semantics` label, or
  a tap target smaller than 48x48.
- (readability) Leaves dead or unreachable code, including commented-out code
  and leftover debug code such as `print`.
<!-- Removed: "Has a better solution" (matches any line), "merits an integration
     test" and "merits a controller/bloc" (replaced by the concrete widget →
     repository rule above), "missing const" (check whether flutter_lints
     reports it; if it does, it's Skip). -->

Example, including a case that is **not** a finding:
```dart
// packages/library_ui/lib/src/book_card.dart
padding: const EdgeInsets.all(16),
// 🟠 Warning (design-tokens): use AppSpacing.s4.

// packages/library_ui/lib/src/theme/app_spacing.dart
static const double s4 = 16;
// Not a finding: lib/src/theme/ is where tokens are defined.
```

### 🔵 Note
An optional suggestion the author may ignore. At most 5 per PR (see
ground_rules.md). A change is a note when it:
- (readability) Uses a name that doesn't say what a class, function or variable
  is for or holds.
- (readability) Has a function or widget with a cohesive part worth extracting
  (not a trivial wrapper, such as a `TitleWidget` that only holds a `Text`).
- (readability) Uses a non-design literal that should be a named constant
  (design values are a warning).
- (readability) Duplicates code that already exists in the PR.
- (readability) Has a comment that says what the code does instead of why, or a
  public API with no doc comment.
- (readability) Bundles unrelated changes that would be easier to review as
  separate PRs.
- (tests) Adds tests that check structure instead of behaviour, such as a widget
  test that only finds widgets, or tests whose names don't say what they check.
- (parity) Differs in naming or file layout between `library_bloc` and
  `library_riverpod` with no reason, although the behaviour is the same.

Example:
```dart
final list2 = books.where((b) => b.isFavorite).toList();
// 🔵 Note (readability): `list2` doesn't say what it holds; `favoriteBooks` does.
```
