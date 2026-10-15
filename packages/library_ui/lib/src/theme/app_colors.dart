import 'package:flutter/material.dart';

@immutable
final class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.star,
    required this.favorite,
    required this.skeleton,
    required this.warningBackground,
    required this.warningBorder,
    required this.warningInk,
    required this.covers,
  });

  final Color star;
  final Color favorite;
  final Color skeleton;
  final Color warningBackground;
  final Color warningBorder;
  final Color warningInk;
  final List<Color> covers;

  static const lightBackground = Color(0xFFF5F6F4);
  static const darkBackground = Color(0xFF121513);

  static const lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0E6B63),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE3F0EE),
    onPrimaryContainer: Color(0xFF0A4F49),
    secondary: Color(0xFF0E6B63),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFB3261E),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF16191F),
    onSurfaceVariant: Color(0xFF5A616C),
    surfaceContainerHighest: Color(0xFFEAECE8),
    outline: Color(0xFFD5D9D4),
    outlineVariant: Color(0xFFE2E4E0),
    inverseSurface: Color(0xFF16191F),
    onInverseSurface: Color(0xFFFFFFFF),
    inversePrimary: Color(0xFF8FD6CC),
    scrim: Color(0x9916191F),
  );

  static const darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF4FB8AC),
    onPrimary: Color(0xFF0B1F1D),
    primaryContainer: Color(0xFF183532),
    onPrimaryContainer: Color(0xFF79CFC4),
    secondary: Color(0xFF4FB8AC),
    onSecondary: Color(0xFF0B1F1D),
    error: Color(0xFFF2867D),
    onError: Color(0xFF16191F),
    surface: Color(0xFF1B1F1D),
    onSurface: Color(0xFFECEEEA),
    onSurfaceVariant: Color(0xFFA3AAB2),
    surfaceContainerHighest: Color(0xFF252A27),
    outline: Color(0xFF3A413D),
    outlineVariant: Color(0xFF2E3431),
    inverseSurface: Color(0xFFECEEEA),
    onInverseSurface: Color(0xFF16191F),
    inversePrimary: Color(0xFF0E6B63),
    scrim: Color(0x99000000),
  );

  static const _covers = [
    Color(0xFF2F4858),
    Color(0xFF8E3B46),
    Color(0xFF33658A),
    Color(0xFF3E7C59),
    Color(0xFF6B4E71),
    Color(0xFF9A5B1E),
    Color(0xFF4A4E69),
  ];

  static const light = AppColors(
    star: Color(0xFFA85F00),
    favorite: Color(0xFFB3261E),
    skeleton: Color(0xFFE1E3DF),
    warningBackground: Color(0xFFFDF1E3),
    warningBorder: Color(0xFFEBCB9F),
    warningInk: Color(0xFF6B3D00),
    covers: _covers,
  );

  static const dark = AppColors(
    star: Color(0xFFE0A040),
    favorite: Color(0xFFF2867D),
    skeleton: Color(0xFF2A302D),
    warningBackground: Color(0xFF33260F),
    warningBorder: Color(0xFF6B4E22),
    warningInk: Color(0xFFF2C987),
    covers: _covers,
  );

  Color coverFor(int bookId) => covers[bookId % covers.length];

  @override
  AppColors copyWith({
    Color? star,
    Color? favorite,
    Color? skeleton,
    Color? warningBackground,
    Color? warningBorder,
    Color? warningInk,
    List<Color>? covers,
  }) {
    return AppColors(
      star: star ?? this.star,
      favorite: favorite ?? this.favorite,
      skeleton: skeleton ?? this.skeleton,
      warningBackground: warningBackground ?? this.warningBackground,
      warningBorder: warningBorder ?? this.warningBorder,
      warningInk: warningInk ?? this.warningInk,
      covers: covers ?? this.covers,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      star: Color.lerp(star, other.star, t)!,
      favorite: Color.lerp(favorite, other.favorite, t)!,
      skeleton: Color.lerp(skeleton, other.skeleton, t)!,
      warningBackground: Color.lerp(
        warningBackground,
        other.warningBackground,
        t,
      )!,
      warningBorder: Color.lerp(warningBorder, other.warningBorder, t)!,
      warningInk: Color.lerp(warningInk, other.warningInk, t)!,
      covers: [
        for (var i = 0; i < covers.length; i++)
          Color.lerp(covers[i], other.covers[i], t)!,
      ],
    );
  }
}

extension AppThemeX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
