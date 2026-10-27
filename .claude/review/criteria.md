# Review criteria
<!-- Used by the CI reviewer (Step 4) and the pre-pr-review skill (Step 7).
     Kept outside .claude/rules/ on purpose, so it never loads in coding sessions. -->

## Report
- **Design tokens:** library_ui widgets using literal colors, sizes, radii,
  durations or text styles instead of AppColors / AppSpacing / AppTextTheme. The only place where 
  literal values are allowed is in lib/src/theme/, which is where the classes mentioned before
  are declared.
  <!-- keep in sync with .claude/rules/library_ui.md -->
- **Parity:** behaviour added to only one of library_bloc / library_riverpod,
  or behaving differently in each.
  <!-- keep in sync with .claude/rules/state-management.md -->
- **Misplaced shared logic:** code in library_bloc or library_riverpod that
  doesn't use bloc or Riverpod, so it belongs in library_ui or library_core.

## Skip
- Anything `flutter analyze` reports, including package boundary imports.
- Formatting and naming preferences.

## Severity
<!-- Step 4: define each level with one short Dart example. -->
