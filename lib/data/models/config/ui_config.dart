/// UI configuration model
class UIConfig {
  final SplashUIConfig splash;
  final AppBarUIConfig appBar;
  final BottomNavUIConfig bottomNav;
  final CardUIConfig cards;
  final ButtonUIConfig buttons;
  final InputUIConfig inputs;
  final ListUIConfig lists;
  final ImageUIConfig images;
  final AnimationConfig animations;

  const UIConfig({
    required this.splash,
    required this.appBar,
    required this.bottomNav,
    required this.cards,
    required this.buttons,
    required this.inputs,
    required this.lists,
    required this.images,
    required this.animations,
  });

  factory UIConfig.fromJson(Map<String, dynamic> json) {
    return UIConfig(
      splash: SplashUIConfig.fromJson(json['splash'] ?? {}),
      appBar: AppBarUIConfig.fromJson(json['appBar'] ?? {}),
      bottomNav: BottomNavUIConfig.fromJson(json['bottomNav'] ?? {}),
      cards: CardUIConfig.fromJson(json['cards'] ?? {}),
      buttons: ButtonUIConfig.fromJson(json['buttons'] ?? {}),
      inputs: InputUIConfig.fromJson(json['inputs'] ?? {}),
      lists: ListUIConfig.fromJson(json['lists'] ?? {}),
      images: ImageUIConfig.fromJson(json['images'] ?? {}),
      animations: AnimationConfig.fromJson(json['animations'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'splash': splash.toJson(),
    'appBar': appBar.toJson(),
    'bottomNav': bottomNav.toJson(),
    'cards': cards.toJson(),
    'buttons': buttons.toJson(),
    'inputs': inputs.toJson(),
    'lists': lists.toJson(),
    'images': images.toJson(),
    'animations': animations.toJson(),
  };

  factory UIConfig.defaults() {
    return UIConfig(
      splash: SplashUIConfig.defaults(),
      appBar: AppBarUIConfig.defaults(),
      bottomNav: BottomNavUIConfig.defaults(),
      cards: CardUIConfig.defaults(),
      buttons: ButtonUIConfig.defaults(),
      inputs: InputUIConfig.defaults(),
      lists: ListUIConfig.defaults(),
      images: ImageUIConfig.defaults(),
      animations: AnimationConfig.defaults(),
    );
  }
}

/// Splash screen UI configuration
class SplashUIConfig {
  final String backgroundColor;
  final bool useGradient;
  final bool showCircles;
  final String animationType;

  const SplashUIConfig({
    required this.backgroundColor,
    required this.useGradient,
    required this.showCircles,
    required this.animationType,
  });

  factory SplashUIConfig.fromJson(Map<String, dynamic> json) {
    return SplashUIConfig(
      backgroundColor: json['backgroundColor'] ?? 'primary',
      useGradient: json['useGradient'] ?? true,
      showCircles: json['showCircles'] ?? true,
      animationType: json['animationType'] ?? 'scale_fade',
    );
  }

  Map<String, dynamic> toJson() => {
    'backgroundColor': backgroundColor,
    'useGradient': useGradient,
    'showCircles': showCircles,
    'animationType': animationType,
  };

  factory SplashUIConfig.defaults() {
    return const SplashUIConfig(
      backgroundColor: 'primary',
      useGradient: true,
      showCircles: true,
      animationType: 'scale_fade',
    );
  }
}

/// App bar UI configuration
class AppBarUIConfig {
  final double height;
  final String backgroundColor;
  final String foregroundColor;
  final double elevation;
  final bool centerTitle;

  const AppBarUIConfig({
    required this.height,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.elevation,
    required this.centerTitle,
  });

  factory AppBarUIConfig.fromJson(Map<String, dynamic> json) {
    return AppBarUIConfig(
      height: (json['height'] ?? 56).toDouble(),
      backgroundColor: json['backgroundColor'] ?? 'transparent',
      foregroundColor: json['foregroundColor'] ?? 'text.primary',
      elevation: (json['elevation'] ?? 0).toDouble(),
      centerTitle: json['centerTitle'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
    'height': height,
    'backgroundColor': backgroundColor,
    'foregroundColor': foregroundColor,
    'elevation': elevation,
    'centerTitle': centerTitle,
  };

  factory AppBarUIConfig.defaults() {
    return const AppBarUIConfig(
      height: 56,
      backgroundColor: 'transparent',
      foregroundColor: 'text.primary',
      elevation: 0,
      centerTitle: true,
    );
  }
}

/// Bottom navigation UI configuration
class BottomNavUIConfig {
  final double height;
  final String backgroundColor;
  final String selectedItemColor;
  final String unselectedItemColor;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final String type;

  const BottomNavUIConfig({
    required this.height,
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    required this.type,
  });

  factory BottomNavUIConfig.fromJson(Map<String, dynamic> json) {
    return BottomNavUIConfig(
      height: (json['height'] ?? 80).toDouble(),
      backgroundColor: json['backgroundColor'] ?? 'surface.default',
      selectedItemColor: json['selectedItemColor'] ?? 'primary.main',
      unselectedItemColor: json['unselectedItemColor'] ?? 'text.disabled',
      showSelectedLabels: json['showSelectedLabels'] ?? true,
      showUnselectedLabels: json['showUnselectedLabels'] ?? false,
      type: json['type'] ?? 'shifting',
    );
  }

  Map<String, dynamic> toJson() => {
    'height': height,
    'backgroundColor': backgroundColor,
    'selectedItemColor': selectedItemColor,
    'unselectedItemColor': unselectedItemColor,
    'showSelectedLabels': showSelectedLabels,
    'showUnselectedLabels': showUnselectedLabels,
    'type': type,
  };

  factory BottomNavUIConfig.defaults() {
    return const BottomNavUIConfig(
      height: 80,
      backgroundColor: 'surface.default',
      selectedItemColor: 'primary.main',
      unselectedItemColor: 'text.disabled',
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: 'shifting',
    );
  }
}

/// Card UI configuration
class CardUIConfig {
  final double elevation;
  final String borderRadius;
  final String shadowColor;
  final String backgroundColor;

  const CardUIConfig({
    required this.elevation,
    required this.borderRadius,
    required this.shadowColor,
    required this.backgroundColor,
  });

  factory CardUIConfig.fromJson(Map<String, dynamic> json) {
    return CardUIConfig(
      elevation: (json['elevation'] ?? 0).toDouble(),
      borderRadius: json['borderRadius'] ?? 'large',
      shadowColor: json['shadowColor'] ?? 'shadow',
      backgroundColor: json['backgroundColor'] ?? 'surface.default',
    );
  }

  Map<String, dynamic> toJson() => {
    'elevation': elevation,
    'borderRadius': borderRadius,
    'shadowColor': shadowColor,
    'backgroundColor': backgroundColor,
  };

  factory CardUIConfig.defaults() {
    return const CardUIConfig(
      elevation: 0,
      borderRadius: 'large',
      shadowColor: 'shadow',
      backgroundColor: 'surface.default',
    );
  }
}

/// Button UI configuration
class ButtonUIConfig {
  final String borderRadius;
  final double height;
  final double elevation;

  const ButtonUIConfig({required this.borderRadius, required this.height, required this.elevation});

  factory ButtonUIConfig.fromJson(Map<String, dynamic> json) {
    return ButtonUIConfig(
      borderRadius: json['borderRadius'] ?? 'medium',
      height: (json['height'] ?? 48).toDouble(),
      elevation: (json['elevation'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'borderRadius': borderRadius, 'height': height, 'elevation': elevation};

  factory ButtonUIConfig.defaults() {
    return const ButtonUIConfig(borderRadius: 'medium', height: 48, elevation: 0);
  }
}

/// Input UI configuration
class InputUIConfig {
  final String borderRadius;
  final double height;
  final double borderWidth;
  final double focusBorderWidth;

  const InputUIConfig({
    required this.borderRadius,
    required this.height,
    required this.borderWidth,
    required this.focusBorderWidth,
  });

  factory InputUIConfig.fromJson(Map<String, dynamic> json) {
    return InputUIConfig(
      borderRadius: json['borderRadius'] ?? 'large',
      height: (json['height'] ?? 52).toDouble(),
      borderWidth: (json['borderWidth'] ?? 1).toDouble(),
      focusBorderWidth: (json['focusBorderWidth'] ?? 2).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'borderRadius': borderRadius,
    'height': height,
    'borderWidth': borderWidth,
    'focusBorderWidth': focusBorderWidth,
  };

  factory InputUIConfig.defaults() {
    return const InputUIConfig(borderRadius: 'large', height: 52, borderWidth: 1, focusBorderWidth: 2);
  }
}

/// List UI configuration
class ListUIConfig {
  final double itemSpacing;
  final double sectionSpacing;
  final bool showDividers;

  const ListUIConfig({required this.itemSpacing, required this.sectionSpacing, required this.showDividers});

  factory ListUIConfig.fromJson(Map<String, dynamic> json) {
    return ListUIConfig(
      itemSpacing: (json['itemSpacing'] ?? 12).toDouble(),
      sectionSpacing: (json['sectionSpacing'] ?? 24).toDouble(),
      showDividers: json['showDividers'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'itemSpacing': itemSpacing,
    'sectionSpacing': sectionSpacing,
    'showDividers': showDividers,
  };

  factory ListUIConfig.defaults() {
    return const ListUIConfig(itemSpacing: 12, sectionSpacing: 24, showDividers: false);
  }
}

/// Image UI configuration
class ImageUIConfig {
  final String placeholderColor;
  final String errorPlaceholder;
  final String loadingIndicator;
  final String borderRadius;

  const ImageUIConfig({
    required this.placeholderColor,
    required this.errorPlaceholder,
    required this.loadingIndicator,
    required this.borderRadius,
  });

  factory ImageUIConfig.fromJson(Map<String, dynamic> json) {
    return ImageUIConfig(
      placeholderColor: json['placeholderColor'] ?? 'background.disabled',
      errorPlaceholder: json['errorPlaceholder'] ?? 'assets/images/placeholder.png',
      loadingIndicator: json['loadingIndicator'] ?? 'shimmer',
      borderRadius: json['borderRadius'] ?? 'medium',
    );
  }

  Map<String, dynamic> toJson() => {
    'placeholderColor': placeholderColor,
    'errorPlaceholder': errorPlaceholder,
    'loadingIndicator': loadingIndicator,
    'borderRadius': borderRadius,
  };

  factory ImageUIConfig.defaults() {
    return const ImageUIConfig(
      placeholderColor: 'background.disabled',
      errorPlaceholder: 'assets/images/placeholder.png',
      loadingIndicator: 'shimmer',
      borderRadius: 'medium',
    );
  }
}

/// Animation configuration
class AnimationConfig {
  final bool enabled;
  final DurationConfig duration;
  final String curve;

  const AnimationConfig({required this.enabled, required this.duration, required this.curve});

  factory AnimationConfig.fromJson(Map<String, dynamic> json) {
    return AnimationConfig(
      enabled: json['enabled'] ?? true,
      duration: DurationConfig.fromJson(json['duration'] ?? {}),
      curve: json['curve'] ?? 'easeInOut',
    );
  }

  Map<String, dynamic> toJson() => {'enabled': enabled, 'duration': duration.toJson(), 'curve': curve};

  factory AnimationConfig.defaults() {
    return AnimationConfig(enabled: true, duration: DurationConfig.defaults(), curve: 'easeInOut');
  }
}

/// Duration configuration for animations
class DurationConfig {
  final int fast;
  final int normal;
  final int slow;

  const DurationConfig({required this.fast, required this.normal, required this.slow});

  factory DurationConfig.fromJson(Map<String, dynamic> json) {
    return DurationConfig(
      fast: json['fast'] ?? 150,
      normal: json['normal'] ?? 300,
      slow: json['slow'] ?? 500,
    );
  }

  Map<String, dynamic> toJson() => {'fast': fast, 'normal': normal, 'slow': slow};

  factory DurationConfig.defaults() {
    return const DurationConfig(fast: 150, normal: 300, slow: 500);
  }

  Duration get fastDuration => Duration(milliseconds: fast);
  Duration get normalDuration => Duration(milliseconds: normal);
  Duration get slowDuration => Duration(milliseconds: slow);
}
