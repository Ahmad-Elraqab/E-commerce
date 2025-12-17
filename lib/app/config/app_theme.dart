import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/config/models/theme_config.dart';

/// Dynamic app theme that reads from JSON configuration
class AppTheme {
  final AppConfigService _configService;

  AppTheme({AppConfigService? configService}) : _configService = configService ?? AppConfigService.instance;

  /// Get the current theme configuration
  ThemeConfig get _themeConfig => _configService.config.theme;

  /// Get the color palette
  ColorPalette get colors => _themeConfig.colors;

  /// Get typography configuration
  TypographyConfig get typography => _themeConfig.typography;

  /// Get border radius configuration
  BorderRadiusConfig get borderRadius => _themeConfig.borderRadius;

  /// Get spacing configuration
  SpacingConfig get spacing => _themeConfig.spacing;

  /// Get gradient palette
  GradientPalette get gradients => _themeConfig.gradients;

  /// Build the light theme
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: colors.primary.main,
      scaffoldBackgroundColor: colors.background.defaultColor,
      fontFamily: typography.fontFamily,

      // Color scheme
      colorScheme: ColorScheme.light(
        primary: colors.primary.main,
        onPrimary: colors.primary.contrast,
        primaryContainer: colors.primary.light,
        secondary: colors.secondary.main,
        onSecondary: colors.secondary.contrast,
        secondaryContainer: colors.secondary.light,
        tertiary: colors.tertiary.main,
        onTertiary: colors.tertiary.contrast,
        surface: colors.surface.defaultColor,
        onSurface: colors.text.primary,
        error: colors.error.main,
        onError: colors.error.contrast,
      ),

      // App bar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: colors.text.primary,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontFamily: typography.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colors.text.primary,
        ),
        iconTheme: IconThemeData(color: colors.text.primary),
      ),

      // Bottom navigation theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface.defaultColor,
        selectedItemColor: colors.primary.main,
        unselectedItemColor: colors.text.disabled,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontFamily: typography.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: typography.fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: colors.surface.defaultColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius.largeRadius),
        shadowColor: colors.shadow,
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary.main,
          foregroundColor: colors.primary.contrast,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: borderRadius.mediumRadius),
          textStyle: TextStyle(fontFamily: typography.fontFamily, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary.main,
          textStyle: TextStyle(fontFamily: typography.fontFamily, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary.main,
          side: BorderSide(color: colors.primary.main, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: borderRadius.mediumRadius),
          textStyle: TextStyle(fontFamily: typography.fontFamily, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface.defaultColor,
        contentPadding: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.md),
        border: OutlineInputBorder(
          borderRadius: borderRadius.largeRadius,
          borderSide: BorderSide(color: colors.border.defaultColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius.largeRadius,
          borderSide: BorderSide(color: colors.border.defaultColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius.largeRadius,
          borderSide: BorderSide(color: colors.primary.main, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius.largeRadius,
          borderSide: BorderSide(color: colors.error.main),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius.largeRadius,
          borderSide: BorderSide(color: colors.error.main, width: 2),
        ),
        hintStyle: TextStyle(fontFamily: typography.fontFamily, color: colors.text.hint, fontSize: 14),
        labelStyle: TextStyle(fontFamily: typography.fontFamily, color: colors.text.secondary, fontSize: 14),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: colors.surface.variant,
        selectedColor: colors.primary.main,
        labelStyle: TextStyle(fontFamily: typography.fontFamily, fontSize: 12, color: colors.text.primary),
        secondaryLabelStyle: TextStyle(
          fontFamily: typography.fontFamily,
          fontSize: 12,
          color: colors.primary.contrast,
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius.smallRadius),
        padding: EdgeInsets.symmetric(horizontal: spacing.sm, vertical: spacing.xs),
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary.main,
        foregroundColor: colors.primary.contrast,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: borderRadius.largeRadius),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(color: colors.divider, thickness: 1, space: spacing.md),

      // Icon theme
      iconTheme: IconThemeData(color: colors.text.primary, size: 24),

      // Text theme
      textTheme: _buildTextTheme(),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surface.inverse,
        contentTextStyle: TextStyle(
          fontFamily: typography.fontFamily,
          color: colors.text.inverse,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius.smallRadius),
        behavior: SnackBarBehavior.floating,
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface.defaultColor,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: borderRadius.xlRadius),
        titleTextStyle: TextStyle(
          fontFamily: typography.fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colors.text.primary,
        ),
        contentTextStyle: TextStyle(
          fontFamily: typography.fontFamily,
          fontSize: 14,
          color: colors.text.secondary,
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface.defaultColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius.xxl)),
        ),
        modalBackgroundColor: colors.surface.defaultColor,
        modalElevation: 8,
      ),
    );
  }

  /// Build the dark theme
  ThemeData get darkTheme {
    // For dark theme, we would typically invert or adjust colors
    // This is a basic implementation that can be expanded
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.surface.inverse,
      colorScheme: ColorScheme.dark(
        primary: colors.primary.main,
        onPrimary: colors.primary.contrast,
        primaryContainer: colors.primary.dark,
        secondary: colors.secondary.main,
        onSecondary: colors.secondary.contrast,
        tertiary: colors.tertiary.main,
        surface: colors.surface.inverse,
        onSurface: colors.text.inverse,
        error: colors.error.main,
        onError: colors.error.contrast,
      ),
      appBarTheme: lightTheme.appBarTheme.copyWith(
        foregroundColor: colors.text.inverse,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }

  /// Build text theme based on configuration
  TextTheme _buildTextTheme() {
    final fontFamily = typography.fontFamily;
    final textColor = colors.text.primary;

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(57),
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(45),
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(36),
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(32),
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(28),
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(24),
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(22),
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(16),
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(14),
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(14),
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(12),
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(11),
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(16),
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(14),
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: typography.scale(12),
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.4,
      ),
    );
  }

  /// Get the current theme based on mode
  ThemeData get currentTheme => _themeConfig.isDark ? darkTheme : lightTheme;
}

/// Static instance for easy access
final appTheme = AppTheme();
