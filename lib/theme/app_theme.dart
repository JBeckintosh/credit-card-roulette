import 'package:flutter/material.dart';

/// Design tokens for the premium-minimal visual direction.
class AppTokens {
  static const Color accent = Color(0xFFE77E22);
  static const Color accentDark = Color(0xFFF29B4B);

  static const double radiusS = 12;
  static const double radiusM = 18;
  static const double radiusL = 24;

  static const double spaceS = 8;
  static const double spaceM = 16;
  static const double spaceL = 24;

  static const Duration motionFast = Duration(milliseconds: 160);
  static const Duration motionStandard = Duration(milliseconds: 220);
}

class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppTokens.accent,
      onPrimary: Color(0xFF1A120A),
      secondary: Color(0xFFDA8D43),
      onSecondary: Color(0xFF24160B),
      error: Color(0xFFB3261E),
      onError: Colors.white,
      surface: Color(0xFFFFFBF7),
      onSurface: Color(0xFF1E1B17),
      onSurfaceVariant: Color(0xFF625A50),
      outline: Color(0xFFD7CDC2),
      outlineVariant: Color(0xFFE8DDD2),
      shadow: Color(0x26000000),
      scrim: Color(0x52000000),
      inverseSurface: Color(0xFF33302B),
      onInverseSurface: Color(0xFFF7F1EA),
      inversePrimary: Color(0xFFF5B06F),
      surfaceTint: AppTokens.accent,
    );

    return _base(scheme);
  }

  static ThemeData dark() {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppTokens.accentDark,
      onPrimary: Color(0xFF221307),
      secondary: Color(0xFFE8A666),
      onSecondary: Color(0xFF28170A),
      error: Color(0xFFF2B8B5),
      onError: Color(0xFF601410),
      surface: Color(0xFF141311),
      onSurface: Color(0xFFE9E2DB),
      onSurfaceVariant: Color(0xFFCFC5BA),
      outline: Color(0xFF8F877D),
      outlineVariant: Color(0xFF4D4741),
      shadow: Colors.black,
      scrim: Color(0x7A000000),
      inverseSurface: Color(0xFFE9E2DB),
      onInverseSurface: Color(0xFF2F2A24),
      inversePrimary: AppTokens.accent,
      surfaceTint: AppTokens.accentDark,
    );

    return _base(scheme);
  }

  static ThemeData _base(ColorScheme scheme) {
    final base = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    );

    final textTheme = base.textTheme.copyWith(
      displayLarge: base.textTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: 0.2,
      ),
      headlineLarge: base.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      titleMedium: base.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.35),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.35),
    );

    final roundedM = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTokens.radiusM),
    );
    final roundedL = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppTokens.radiusL),
    );

    return base.copyWith(
      textTheme: textTheme,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        shape: roundedM,
        margin: const EdgeInsets.symmetric(
          horizontal: AppTokens.spaceM,
          vertical: 6,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.spaceM,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusM),
          borderSide: BorderSide(color: scheme.outline, width: 1.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusM),
          borderSide: BorderSide(color: scheme.outline, width: 1.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTokens.radiusM),
          borderSide: BorderSide(color: scheme.primary, width: 2.4),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: roundedL,
          textStyle: textTheme.titleMedium,
        ),
      ),
    );
  }
}
