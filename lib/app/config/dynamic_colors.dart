import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/config/models/theme_config.dart';

/// Dynamic colors that read from JSON configuration
///
/// This class provides a way to access colors from the configuration
/// while maintaining backwards compatibility with the existing AppColor class.
///
/// Usage:
/// ```dart
/// final colors = DynamicColors.instance;
/// Container(color: colors.primary);
/// ```
class DynamicColors {
  static DynamicColors? _instance;
  static DynamicColors get instance => _instance ??= DynamicColors._();

  DynamicColors._();

  /// Force refresh the instance (call after config changes)
  static void refresh() {
    _instance = DynamicColors._();
  }

  ColorPalette get _colors => AppConfigService.instance.config.theme.colors;
  GradientPalette get _gradients => AppConfigService.instance.config.theme.gradients;

  // ===========================================================================
  // PRIMARY COLORS
  // ===========================================================================

  Color get primary => _colors.primary.main;
  Color get primaryLight => _colors.primary.light;
  Color get primaryDark => _colors.primary.dark;
  Color get primaryContrast => _colors.primary.contrast;

  // ===========================================================================
  // SECONDARY COLORS
  // ===========================================================================

  Color get secondary => _colors.secondary.main;
  Color get secondaryLight => _colors.secondary.light;
  Color get secondaryDark => _colors.secondary.dark;
  Color get secondaryContrast => _colors.secondary.contrast;

  // ===========================================================================
  // TERTIARY COLORS
  // ===========================================================================

  Color get tertiary => _colors.tertiary.main;
  Color get tertiaryLight => _colors.tertiary.light;
  Color get tertiaryDark => _colors.tertiary.dark;
  Color get tertiaryContrast => _colors.tertiary.contrast;

  // ===========================================================================
  // ACCENT COLORS
  // ===========================================================================

  Color get accent => _colors.accent.main;
  Color get accentLight => _colors.accent.light;
  Color get accentDark => _colors.accent.dark;
  Color get accentContrast => _colors.accent.contrast;

  // ===========================================================================
  // SEMANTIC COLORS
  // ===========================================================================

  Color get success => _colors.success.main;
  Color get successLight => _colors.success.light;
  Color get successDark => _colors.success.dark;

  Color get warning => _colors.warning.main;
  Color get warningLight => _colors.warning.light;
  Color get warningDark => _colors.warning.dark;

  Color get error => _colors.error.main;
  Color get errorLight => _colors.error.light;
  Color get errorDark => _colors.error.dark;

  Color get info => _colors.info.main;
  Color get infoLight => _colors.info.light;
  Color get infoDark => _colors.info.dark;

  // ===========================================================================
  // BACKGROUND COLORS
  // ===========================================================================

  Color get background => _colors.background.defaultColor;
  Color get backgroundPaper => _colors.background.paper;
  Color get backgroundElevated => _colors.background.elevated;
  Color get backgroundDisabled => _colors.background.disabled;

  // ===========================================================================
  // SURFACE COLORS
  // ===========================================================================

  Color get surface => _colors.surface.defaultColor;
  Color get surfaceVariant => _colors.surface.variant;
  Color get surfaceInverse => _colors.surface.inverse;

  // ===========================================================================
  // TEXT COLORS
  // ===========================================================================

  Color get textPrimary => _colors.text.primary;
  Color get textSecondary => _colors.text.secondary;
  Color get textDisabled => _colors.text.disabled;
  Color get textHint => _colors.text.hint;
  Color get textInverse => _colors.text.inverse;

  // ===========================================================================
  // BORDER COLORS
  // ===========================================================================

  Color get border => _colors.border.defaultColor;
  Color get borderLight => _colors.border.light;
  Color get borderDark => _colors.border.dark;

  // ===========================================================================
  // OTHER COLORS
  // ===========================================================================

  Color get divider => _colors.divider;
  Color get shadow => _colors.shadow;
  Color get transparent => Colors.transparent;
  Color get white => Colors.white;
  Color get black => Colors.black;

  // ===========================================================================
  // GRADIENTS
  // ===========================================================================

  LinearGradient get primaryGradient => _gradients.getPrimaryGradient();
  LinearGradient get splashGradient => _gradients.getSplashGradient();

  List<Color> get primaryGradientColors => _gradients.primary;
  List<Color> get splashGradientColors => _gradients.splash;
  List<Color> get banner1Colors => _gradients.banner1;
  List<Color> get banner2Colors => _gradients.banner2;
  List<Color> get banner3Colors => _gradients.banner3;

  // ===========================================================================
  // HELPER METHODS
  // ===========================================================================

  /// Get color with opacity
  Color withOpacity(Color color, double opacity) => color.withOpacity(opacity);

  /// Get primary color with opacity
  Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);

  /// Get surface color with elevation effect
  Color surfaceWithElevation(double elevation) {
    return Color.alphaBlend(Colors.white.withOpacity(elevation * 0.05), surface);
  }

  /// Create a box shadow with theme colors
  BoxShadow getBoxShadow({
    double blurRadius = 10,
    Offset offset = const Offset(0, 4),
    double opacity = 0.05,
  }) {
    return BoxShadow(color: shadow.withOpacity(opacity), blurRadius: blurRadius, offset: offset);
  }

  /// Create a list of box shadows for elevated components
  List<BoxShadow> getElevatedShadows({double elevation = 1}) {
    return [
      BoxShadow(
        color: shadow.withOpacity(0.05 * elevation),
        blurRadius: 10 * elevation,
        offset: Offset(0, 4 * elevation),
      ),
    ];
  }
}

/// Global instance for easy access
final dynamicColors = DynamicColors.instance;

/// Extension for using dynamic colors in widgets
extension DynamicColorsExtension on BuildContext {
  DynamicColors get colors => DynamicColors.instance;
}
