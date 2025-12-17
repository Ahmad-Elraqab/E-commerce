import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/config/dynamic_colors.dart';
import 'package:taxi_client_app/app/config/models/feature_config.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late SplashFeatureConfig _splashConfig;
  late DynamicColors _colors;

  @override
  void initState() {
    super.initState();

    // Get configuration
    _splashConfig = AppConfigService.instance.getSplashConfig();
    _colors = DynamicColors.instance;

    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Navigate after splash animation using configured duration
    Future.delayed(_splashConfig.durationValue, () {
      if (mounted) {
        // Check if user is logged in (you can add your auth check here)
        context.router.replace(const MainView());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appInfo = AppConfigService.instance.appInfo;
    final branding = AppConfigService.instance.branding;
    final uiConfig = AppConfigService.instance.ui.splash;
    final gradients = AppConfigService.instance.config.theme.gradients;
    final typography = AppConfigService.instance.config.theme.typography;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: uiConfig.useGradient ? gradients.getSplashGradient() : null,
          color: !uiConfig.useGradient ? _colors.primary : null,
        ),
        child: Stack(
          children: [
            // Background decoration circles (configurable)
            if (uiConfig.showCircles) ...[
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
                ),
              ),
              Positioned(
                bottom: -150,
                left: -100,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1)),
                ),
              ),
            ],
            // Main content
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo (configurable)
                          if (_splashConfig.showLogo) _buildLogo(branding),
                          const SizedBox(height: 24),
                          // App Name
                          Text(
                            appInfo.name,
                            style: TextStyle(
                              fontFamily: typography.fontFamily,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          // Tagline (configurable)
                          if (_splashConfig.showTagline) ...[
                            const SizedBox(height: 8),
                            Text(
                              appInfo.tagline,
                              style: TextStyle(
                                fontFamily: typography.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Loading indicator at bottom (configurable)
            if (_splashConfig.showLoading)
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontFamily: typography.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(dynamic branding) {
    final logoConfig = branding.logo;

    // Determine logo type and render accordingly
    if (logoConfig.isImage) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 15)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            logoConfig.splash,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to icon if image fails to load
              return Icon(Icons.shopping_bag, size: 60, color: _colors.primary);
            },
          ),
        ),
      );
    } else if (logoConfig.isIcon) {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 15)),
          ],
        ),
        child: Icon(Icons.shopping_bag, size: 60, color: _colors.primary),
      );
    } else {
      // Default fallback
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 15)),
          ],
        ),
        child: Icon(Icons.shopping_bag, size: 60, color: _colors.primary),
      );
    }
  }
}
