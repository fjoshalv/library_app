---
paths:
  - "packages/library_ui/**"
---

# library_ui

Shared widgets and screens used by both apps. Flutter only.

## No state management
- Never import flutter_bloc, flutter_riverpod or any other state management package.
- Widgets take data and callbacks through constructor parameters. Each app
  (library_bloc, library_riverpod) wires its own state into them.

## Design tokens
Widgets never hardcode design values. Use:
- Colors: `Theme.of(context).colorScheme` for Material roles, and
  `Theme.of(context).extension<AppColors>()!` for star, favorite, skeleton,
  warning and cover colors.
- Spacing, radii and fixed sizes: `AppSpacing` (`s1`–`s8`, `radiusMd`, `buttonHeight`, ...).
- Text: `Theme.of(context).textTheme`, built from `AppTextTheme`.

```dart
// Wrong
Padding(padding: const EdgeInsets.all(16), child: Text('Title',
  style: TextStyle(color: Color(0xFF2E7D32), fontSize: 18)))

// Right
Padding(padding: const EdgeInsets.all(AppSpacing.s4), child: Text('Title',
  style: Theme.of(context).textTheme.titleMedium))
```

Exception: files in `lib/src/theme/` define the tokens, so literals belong there.
If a value you need doesn't exist, add a token there instead of hardcoding it.