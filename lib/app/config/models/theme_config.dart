import 'dart:ui';

import 'package:flutter/material.dart';

/// Theme configuration model
class ThemeConfig {
  final String mode;
  final bool supportDarkMode;
  final ColorPalette colors;
  final GradientPalette gradients;
  final TypographyConfig typography;
  final BorderRadiusConfig borderRadius;
  final SpacingConfig spacing;

  const ThemeConfig({
    required this.mode,
    required this.supportDarkMode,
    required this.colors,
    required this.gradients,
    required this.typography,
    required this.borderRadius,
    required this.spacing,
  });

  factory ThemeConfig.fromJson(Map<String, dynamic> json) {
    return ThemeConfig(
      mode: json['mode'] ?? 'light',
      supportDarkMode: json['supportDarkMode'] ?? true,
      colors: ColorPalette.fromJson(json['colors'] ?? {}),
      gradients: GradientPalette.fromJson(json['gradients'] ?? {}),
      typography: TypographyConfig.fromJson(json['typography'] ?? {}),
      borderRadius: BorderRadiusConfig.fromJson(json['borderRadius'] ?? {}),
      spacing: SpacingConfig.fromJson(json['spacing'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'mode': mode,
    'supportDarkMode': supportDarkMode,
    'colors': colors.toJson(),
    'gradients': gradients.toJson(),
    'typography': typography.toJson(),
    'borderRadius': borderRadius.toJson(),
    'spacing': spacing.toJson(),
  };

  factory ThemeConfig.defaults() {
    return ThemeConfig(
      mode: 'light',
      supportDarkMode: true,
      colors: ColorPalette.defaults(),
      gradients: GradientPalette.defaults(),
      typography: TypographyConfig.defaults(),
      borderRadius: BorderRadiusConfig.defaults(),
      spacing: SpacingConfig.defaults(),
    );
  }

  bool get isDark => mode == 'dark';
  bool get isLight => mode == 'light';
}

/// Color palette configuration
class ColorPalette {
  final ColorSet primary;
  final ColorSet secondary;
  final ColorSet tertiary;
  final ColorSet accent;
  final ColorSet success;
  final ColorSet warning;
  final ColorSet error;
  final ColorSet info;
  final BackgroundColors background;
  final SurfaceColors surface;
  final TextColors text;
  final BorderColors border;
  final Color divider;
  final Color shadow;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.accent,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.background,
    required this.surface,
    required this.text,
    required this.border,
    required this.divider,
    required this.shadow,
  });

  factory ColorPalette.fromJson(Map<String, dynamic> json) {
    return ColorPalette(
      primary: ColorSet.fromJson(json['primary'] ?? {}),
      secondary: ColorSet.fromJson(json['secondary'] ?? {}),
      tertiary: ColorSet.fromJson(json['tertiary'] ?? {}),
      accent: ColorSet.fromJson(json['accent'] ?? {}),
      success: ColorSet.fromJson(json['success'] ?? {}),
      warning: ColorSet.fromJson(json['warning'] ?? {}),
      error: ColorSet.fromJson(json['error'] ?? {}),
      info: ColorSet.fromJson(json['info'] ?? {}),
      background: BackgroundColors.fromJson(json['background'] ?? {}),
      surface: SurfaceColors.fromJson(json['surface'] ?? {}),
      text: TextColors.fromJson(json['text'] ?? {}),
      border: BorderColors.fromJson(json['border'] ?? {}),
      divider: _parseColor(json['divider'] ?? '#EEEEEE'),
      shadow: _parseColor(json['shadow'] ?? '#00000014'),
    );
  }

  Map<String, dynamic> toJson() => {
    'primary': primary.toJson(),
    'secondary': secondary.toJson(),
    'tertiary': tertiary.toJson(),
    'accent': accent.toJson(),
    'success': success.toJson(),
    'warning': warning.toJson(),
    'error': error.toJson(),
    'info': info.toJson(),
    'background': background.toJson(),
    'surface': surface.toJson(),
    'text': text.toJson(),
    'border': border.toJson(),
    'divider': _colorToHex(divider),
    'shadow': _colorToHex(shadow),
  };

  factory ColorPalette.defaults() {
    return ColorPalette(
      primary: ColorSet.defaults(mainColor: const Color(0xFFFF9500)),
      secondary: ColorSet.defaults(mainColor: const Color(0xFF105F82)),
      tertiary: ColorSet.defaults(mainColor: const Color(0xFF6A6AF6)),
      accent: ColorSet.defaults(mainColor: const Color(0xFF1CBECA)),
      success: ColorSet.defaults(mainColor: const Color(0xFF00AF6C)),
      warning: ColorSet.defaults(mainColor: const Color(0xFFFAD204)),
      error: ColorSet.defaults(mainColor: const Color(0xFFFF3B30)),
      info: ColorSet.defaults(mainColor: const Color(0xFF2452F5)),
      background: BackgroundColors.defaults(),
      surface: SurfaceColors.defaults(),
      text: TextColors.defaults(),
      border: BorderColors.defaults(),
      divider: const Color(0xFFEEEEEE),
      shadow: const Color(0x14000000),
    );
  }
}

/// A color set with main, light, dark, and contrast variants
class ColorSet {
  final Color main;
  final Color light;
  final Color dark;
  final Color contrast;

  const ColorSet({required this.main, required this.light, required this.dark, required this.contrast});

  factory ColorSet.fromJson(Map<String, dynamic> json) {
    final mainColor = _parseColor(json['main'] ?? '#000000');
    return ColorSet(
      main: mainColor,
      light: _parseColor(json['light'] ?? _lighten(mainColor)),
      dark: _parseColor(json['dark'] ?? _darken(mainColor)),
      contrast: _parseColor(json['contrast'] ?? '#FFFFFF'),
    );
  }

  Map<String, dynamic> toJson() => {
    'main': _colorToHex(main),
    'light': _colorToHex(light),
    'dark': _colorToHex(dark),
    'contrast': _colorToHex(contrast),
  };

  factory ColorSet.defaults({required Color mainColor}) {
    return ColorSet(
      main: mainColor,
      light: _computeLightColor(mainColor),
      dark: _computeDarkColor(mainColor),
      contrast: Colors.white,
    );
  }

  static Color _computeLightColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0)).toColor();
  }

  static Color _computeDarkColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).toColor();
  }
}

/// Background colors
class BackgroundColors {
  final Color defaultColor;
  final Color paper;
  final Color elevated;
  final Color disabled;

  const BackgroundColors({
    required this.defaultColor,
    required this.paper,
    required this.elevated,
    required this.disabled,
  });

  factory BackgroundColors.fromJson(Map<String, dynamic> json) {
    return BackgroundColors(
      defaultColor: _parseColor(json['default'] ?? '#F9F9F9'),
      paper: _parseColor(json['paper'] ?? '#FFFFFF'),
      elevated: _parseColor(json['elevated'] ?? '#FFFFFF'),
      disabled: _parseColor(json['disabled'] ?? '#EBEBEB'),
    );
  }

  Map<String, dynamic> toJson() => {
    'default': _colorToHex(defaultColor),
    'paper': _colorToHex(paper),
    'elevated': _colorToHex(elevated),
    'disabled': _colorToHex(disabled),
  };

  factory BackgroundColors.defaults() {
    return const BackgroundColors(
      defaultColor: Color(0xFFF9F9F9),
      paper: Color(0xFFFFFFFF),
      elevated: Color(0xFFFFFFFF),
      disabled: Color(0xFFEBEBEB),
    );
  }
}

/// Surface colors
class SurfaceColors {
  final Color defaultColor;
  final Color variant;
  final Color inverse;

  const SurfaceColors({required this.defaultColor, required this.variant, required this.inverse});

  factory SurfaceColors.fromJson(Map<String, dynamic> json) {
    return SurfaceColors(
      defaultColor: _parseColor(json['default'] ?? '#FFFFFF'),
      variant: _parseColor(json['variant'] ?? '#FAFAFA'),
      inverse: _parseColor(json['inverse'] ?? '#1C1F26'),
    );
  }

  Map<String, dynamic> toJson() => {
    'default': _colorToHex(defaultColor),
    'variant': _colorToHex(variant),
    'inverse': _colorToHex(inverse),
  };

  factory SurfaceColors.defaults() {
    return const SurfaceColors(
      defaultColor: Color(0xFFFFFFFF),
      variant: Color(0xFFFAFAFA),
      inverse: Color(0xFF1C1F26),
    );
  }
}

/// Text colors
class TextColors {
  final Color primary;
  final Color secondary;
  final Color disabled;
  final Color hint;
  final Color inverse;

  const TextColors({
    required this.primary,
    required this.secondary,
    required this.disabled,
    required this.hint,
    required this.inverse,
  });

  factory TextColors.fromJson(Map<String, dynamic> json) {
    return TextColors(
      primary: _parseColor(json['primary'] ?? '#252525'),
      secondary: _parseColor(json['secondary'] ?? '#666666'),
      disabled: _parseColor(json['disabled'] ?? '#9C9C9C'),
      hint: _parseColor(json['hint'] ?? '#A5A5A5'),
      inverse: _parseColor(json['inverse'] ?? '#FFFFFF'),
    );
  }

  Map<String, dynamic> toJson() => {
    'primary': _colorToHex(primary),
    'secondary': _colorToHex(secondary),
    'disabled': _colorToHex(disabled),
    'hint': _colorToHex(hint),
    'inverse': _colorToHex(inverse),
  };

  factory TextColors.defaults() {
    return const TextColors(
      primary: Color(0xFF252525),
      secondary: Color(0xFF666666),
      disabled: Color(0xFF9C9C9C),
      hint: Color(0xFFA5A5A5),
      inverse: Color(0xFFFFFFFF),
    );
  }
}

/// Border colors
class BorderColors {
  final Color defaultColor;
  final Color light;
  final Color dark;

  const BorderColors({required this.defaultColor, required this.light, required this.dark});

  factory BorderColors.fromJson(Map<String, dynamic> json) {
    return BorderColors(
      defaultColor: _parseColor(json['default'] ?? '#D7D7D7'),
      light: _parseColor(json['light'] ?? '#EBEBEB'),
      dark: _parseColor(json['dark'] ?? '#C3C3C3'),
    );
  }

  Map<String, dynamic> toJson() => {
    'default': _colorToHex(defaultColor),
    'light': _colorToHex(light),
    'dark': _colorToHex(dark),
  };

  factory BorderColors.defaults() {
    return const BorderColors(
      defaultColor: Color(0xFFD7D7D7),
      light: Color(0xFFEBEBEB),
      dark: Color(0xFFC3C3C3),
    );
  }
}

/// Gradient palette configuration
class GradientPalette {
  final List<Color> primary;
  final List<Color> splash;
  final List<Color> card;
  final List<Color> banner1;
  final List<Color> banner2;
  final List<Color> banner3;

  const GradientPalette({
    required this.primary,
    required this.splash,
    required this.card,
    required this.banner1,
    required this.banner2,
    required this.banner3,
  });

  factory GradientPalette.fromJson(Map<String, dynamic> json) {
    return GradientPalette(
      primary: _parseColorList(json['primary'] ?? ['#FF9500', '#FFB347']),
      splash: _parseColorList(json['splash'] ?? ['#FF9500', '#E68600']),
      card: _parseColorList(json['card'] ?? ['#FFFFFF', '#FAFAFA']),
      banner1: _parseColorList(json['banner1'] ?? ['#FF6B6B', '#FF8E53']),
      banner2: _parseColorList(json['banner2'] ?? ['#4ECDC4', '#44A08D']),
      banner3: _parseColorList(json['banner3'] ?? ['#667EEA', '#764BA2']),
    );
  }

  Map<String, dynamic> toJson() => {
    'primary': primary.map((c) => _colorToHex(c)).toList(),
    'splash': splash.map((c) => _colorToHex(c)).toList(),
    'card': card.map((c) => _colorToHex(c)).toList(),
    'banner1': banner1.map((c) => _colorToHex(c)).toList(),
    'banner2': banner2.map((c) => _colorToHex(c)).toList(),
    'banner3': banner3.map((c) => _colorToHex(c)).toList(),
  };

  factory GradientPalette.defaults() {
    return const GradientPalette(
      primary: [Color(0xFFFF9500), Color(0xFFFFB347)],
      splash: [Color(0xFFFF9500), Color(0xFFE68600)],
      card: [Color(0xFFFFFFFF), Color(0xFFFAFAFA)],
      banner1: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
      banner2: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
      banner3: [Color(0xFF667EEA), Color(0xFF764BA2)],
    );
  }

  LinearGradient getPrimaryGradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(colors: primary, begin: begin, end: end);
  }

  LinearGradient getSplashGradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(colors: splash, begin: begin, end: end);
  }

  List<LinearGradient> getBannerGradients() {
    return [
      LinearGradient(colors: banner1, begin: Alignment.topLeft, end: Alignment.bottomRight),
      LinearGradient(colors: banner2, begin: Alignment.topLeft, end: Alignment.bottomRight),
      LinearGradient(colors: banner3, begin: Alignment.topLeft, end: Alignment.bottomRight),
    ];
  }
}

/// Typography configuration
class TypographyConfig {
  final String fontFamily;
  final String fontFamilySecondary;
  final double baseFontSize;
  final double scaleFactor;

  const TypographyConfig({
    required this.fontFamily,
    required this.fontFamilySecondary,
    required this.baseFontSize,
    required this.scaleFactor,
  });

  factory TypographyConfig.fromJson(Map<String, dynamic> json) {
    return TypographyConfig(
      fontFamily: json['fontFamily'] ?? 'Poppins',
      fontFamilySecondary: json['fontFamilySecondary'] ?? 'Poppins',
      baseFontSize: (json['baseFontSize'] ?? 14).toDouble(),
      scaleFactor: (json['scaleFactor'] ?? 1.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'fontFamily': fontFamily,
    'fontFamilySecondary': fontFamilySecondary,
    'baseFontSize': baseFontSize,
    'scaleFactor': scaleFactor,
  };

  factory TypographyConfig.defaults() {
    return const TypographyConfig(
      fontFamily: 'Poppins',
      fontFamilySecondary: 'Poppins',
      baseFontSize: 14,
      scaleFactor: 1.0,
    );
  }

  double scale(double size) => size * scaleFactor;
}

/// Border radius configuration
class BorderRadiusConfig {
  final double none;
  final double small;
  final double medium;
  final double large;
  final double xl;
  final double xxl;
  final double full;

  const BorderRadiusConfig({
    required this.none,
    required this.small,
    required this.medium,
    required this.large,
    required this.xl,
    required this.xxl,
    required this.full,
  });

  factory BorderRadiusConfig.fromJson(Map<String, dynamic> json) {
    return BorderRadiusConfig(
      none: (json['none'] ?? 0).toDouble(),
      small: (json['small'] ?? 8).toDouble(),
      medium: (json['medium'] ?? 12).toDouble(),
      large: (json['large'] ?? 16).toDouble(),
      xl: (json['xl'] ?? 20).toDouble(),
      xxl: (json['xxl'] ?? 24).toDouble(),
      full: (json['full'] ?? 9999).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'none': none,
    'small': small,
    'medium': medium,
    'large': large,
    'xl': xl,
    'xxl': xxl,
    'full': full,
  };

  factory BorderRadiusConfig.defaults() {
    return const BorderRadiusConfig(none: 0, small: 8, medium: 12, large: 16, xl: 20, xxl: 24, full: 9999);
  }

  BorderRadius get noneRadius => BorderRadius.circular(none);
  BorderRadius get smallRadius => BorderRadius.circular(small);
  BorderRadius get mediumRadius => BorderRadius.circular(medium);
  BorderRadius get largeRadius => BorderRadius.circular(large);
  BorderRadius get xlRadius => BorderRadius.circular(xl);
  BorderRadius get xxlRadius => BorderRadius.circular(xxl);
  BorderRadius get fullRadius => BorderRadius.circular(full);
}

/// Spacing configuration
class SpacingConfig {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  const SpacingConfig({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  factory SpacingConfig.fromJson(Map<String, dynamic> json) {
    return SpacingConfig(
      xs: (json['xs'] ?? 4).toDouble(),
      sm: (json['sm'] ?? 8).toDouble(),
      md: (json['md'] ?? 16).toDouble(),
      lg: (json['lg'] ?? 24).toDouble(),
      xl: (json['xl'] ?? 32).toDouble(),
      xxl: (json['xxl'] ?? 48).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'xs': xs, 'sm': sm, 'md': md, 'lg': lg, 'xl': xl, 'xxl': xxl};

  factory SpacingConfig.defaults() {
    return const SpacingConfig(xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48);
  }

  EdgeInsets all(double value) => EdgeInsets.all(value);
  EdgeInsets horizontal(double value) => EdgeInsets.symmetric(horizontal: value);
  EdgeInsets vertical(double value) => EdgeInsets.symmetric(vertical: value);
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/// Parses a hex color string to a Color
Color _parseColor(String hexString) {
  try {
    String hex = hexString.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Add alpha if not present
    } else if (hex.length == 8) {
      // RGBA format to ARGB
      // Already in correct format
    }
    return Color(int.parse(hex, radix: 16));
  } catch (e) {
    return Colors.black;
  }
}

/// Converts a Color to hex string
String _colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}

/// Parses a list of hex color strings to a list of Colors
List<Color> _parseColorList(List<dynamic> hexStrings) {
  return hexStrings.map((hex) => _parseColor(hex.toString())).toList();
}

/// Lightens a color
String _lighten(Color color) {
  final hsl = HSLColor.fromColor(color);
  final lightened = hsl.withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0));
  return _colorToHex(lightened.toColor());
}

/// Darkens a color
String _darken(Color color) {
  final hsl = HSLColor.fromColor(color);
  final darkened = hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0));
  return _colorToHex(darkened.toColor());
}
