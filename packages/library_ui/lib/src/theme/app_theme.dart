import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_theme.dart';

abstract final class AppTheme {
  static final ThemeData light = _build(
    AppColors.lightScheme,
    AppColors.light,
    AppColors.lightBackground,
  );

  static final ThemeData dark = _build(
    AppColors.darkScheme,
    AppColors.dark,
    AppColors.darkBackground,
  );

  static ThemeData _build(
    ColorScheme scheme,
    AppColors colors,
    Color background,
  ) {
    const textTheme = AppTextTheme.textTheme;
    final radiusLg = BorderRadius.circular(AppSpacing.radiusLg);
    final buttonShape = RoundedRectangleBorder(borderRadius: radiusLg);
    final chipLabel = textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w500,
    );

    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: AppTextTheme.figtree,
      package: AppTextTheme.package,
      textTheme: textTheme,
      extensions: [colors],
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ).copyWith(backgroundColor: _whenActive(scheme.onPrimaryContainer)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
              shape: buttonShape,
              textStyle: textTheme.labelLarge,
              backgroundColor: scheme.surface,
            ).copyWith(
              foregroundColor: _whenActive(scheme.onPrimaryContainer),
              side: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(
                    color: scheme.onSurface.withValues(alpha: 0.12),
                  );
                }
                if (_isActive(states)) {
                  return BorderSide(color: scheme.onPrimaryContainer);
                }
                return BorderSide(color: scheme.primary);
              }),
            ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(AppSpacing.touchMin, AppSpacing.touchMin),
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ).copyWith(foregroundColor: _whenActive(scheme.onPrimaryContainer)),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: scheme.surface,
        hintStyle: textTheme.bodyLarge!.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        border: OutlineInputBorder(
          borderRadius: radiusLg,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radiusLg,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radiusLg,
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.outline,
          ),
        ),
        backgroundColor: scheme.surface,
        selectedColor: scheme.primary,
        showCheckmark: false,
        labelStyle: chipLabel.copyWith(
          color: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? scheme.onPrimary
                : scheme.onSurface,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        height: AppSpacing.navHeight,
        elevation: 0,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? textTheme.labelSmall!.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                )
              : textTheme.labelSmall!.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusSheet),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static bool _isActive(Set<WidgetState> states) =>
      states.contains(WidgetState.pressed) ||
      states.contains(WidgetState.hovered);

  static WidgetStateProperty<Color?> _whenActive(Color color) =>
      WidgetStateProperty.resolveWith(
        (states) => _isActive(states) ? color : null,
      );
}
