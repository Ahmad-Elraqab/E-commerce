/// Branding configuration model
class BrandingConfig {
  final LogoConfig logo;
  final AppIconConfig appIcon;

  const BrandingConfig({required this.logo, required this.appIcon});

  factory BrandingConfig.fromJson(Map<String, dynamic> json) {
    return BrandingConfig(
      logo: LogoConfig.fromJson(json['logo'] ?? {}),
      appIcon: AppIconConfig.fromJson(json['appIcon'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {'logo': logo.toJson(), 'appIcon': appIcon.toJson()};

  factory BrandingConfig.defaults() {
    return BrandingConfig(logo: LogoConfig.defaults(), appIcon: AppIconConfig.defaults());
  }
}

/// Logo configuration
class LogoConfig {
  final String small;
  final String medium;
  final String large;
  final String splash;
  final bool showLogoOnSplash;
  final bool showLogoOnAppBar;
  final String logoType; // 'image', 'svg', 'text', 'icon'

  const LogoConfig({
    required this.small,
    required this.medium,
    required this.large,
    required this.splash,
    required this.showLogoOnSplash,
    required this.showLogoOnAppBar,
    required this.logoType,
  });

  factory LogoConfig.fromJson(Map<String, dynamic> json) {
    return LogoConfig(
      small: json['small'] ?? 'assets/images/logo-small.png',
      medium: json['medium'] ?? 'assets/images/logo-large.png',
      large: json['large'] ?? 'assets/images/logo-extra-large.png',
      splash: json['splash'] ?? 'assets/images/logo-large.png',
      showLogoOnSplash: json['showLogoOnSplash'] ?? true,
      showLogoOnAppBar: json['showLogoOnAppBar'] ?? false,
      logoType: json['logoType'] ?? 'image',
    );
  }

  Map<String, dynamic> toJson() => {
    'small': small,
    'medium': medium,
    'large': large,
    'splash': splash,
    'showLogoOnSplash': showLogoOnSplash,
    'showLogoOnAppBar': showLogoOnAppBar,
    'logoType': logoType,
  };

  factory LogoConfig.defaults() {
    return const LogoConfig(
      small: 'assets/images/logo-small.png',
      medium: 'assets/images/logo-large.png',
      large: 'assets/images/logo-extra-large.png',
      splash: 'assets/images/logo-large.png',
      showLogoOnSplash: true,
      showLogoOnAppBar: false,
      logoType: 'image',
    );
  }

  bool get isImage => logoType == 'image';
  bool get isSvg => logoType == 'svg';
  bool get isText => logoType == 'text';
  bool get isIcon => logoType == 'icon';
}

/// App icon configuration
class AppIconConfig {
  final String foreground;
  final String background;

  const AppIconConfig({required this.foreground, required this.background});

  factory AppIconConfig.fromJson(Map<String, dynamic> json) {
    return AppIconConfig(
      foreground: json['foreground'] ?? 'assets/images/logo-small.png',
      background: json['background'] ?? '#FF9500',
    );
  }

  Map<String, dynamic> toJson() => {'foreground': foreground, 'background': background};

  factory AppIconConfig.defaults() {
    return const AppIconConfig(foreground: 'assets/images/logo-small.png', background: '#FF9500');
  }
}
