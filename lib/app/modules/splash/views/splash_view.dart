import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_logo.dart';
import '../controllers/splash_controller.dart';

/// Minimal premium splash: original logo asset only, smooth camera-like motion,
/// green progress line, full-screen exit zoom, brief white, then route.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  static const _kDuration = Duration(milliseconds: 3000);
  static const _kWhiteHold = Duration(milliseconds: 240);

  late final AnimationController _controller;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  bool _whiteHold = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _kDuration)
      ..addStatusListener(_onAnimStatus);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  void _onAnimStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    if (!mounted) return;
    setState(() => _whiteHold = true);
    Future<void>.delayed(_kWhiteHold, () {
      if (!mounted) return;
      if (Get.isRegistered<SplashController>()) {
        Get.find<SplashController>().completeToStart();
      }
    });
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onAnimStatus);
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurface : Colors.white;
    final overlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: bg,
      systemNavigationBarIconBrightness: isDark
          ? Brightness.light
          : Brightness.dark,
    );

    if (_whiteHold) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Scaffold(
          backgroundColor: bg,
          body: ColoredBox(color: bg),
        ),
      );
    }

    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final mediaSize = MediaQuery.sizeOf(context);
    final logoSize = mediaSize.shortestSide * 0.42;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: bg,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([_controller, _pulseController]),
                builder: (context, _) {
                  final t = _controller.value;
                  // Fade in and out
                  double opacity = 1.0;
                  if (t < 0.2) opacity = t / 0.2;
                  if (t > 0.8) opacity = (1.0 - t) / 0.2;

                  return Opacity(
                    opacity: opacity.clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: _pulseAnimation.value,
                      child: SizedBox(
                        width: logoSize,
                        height: logoSize,
                        child: Image.asset(
                          AppAssetPaths.logo,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.eco_rounded,
                            size: logoSize * 0.45,
                            color: TripMatesColors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 48 + bottomInset,
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = _controller.value;
                    double opacity = 1.0;
                    if (t < 0.2) opacity = t / 0.2;
                    if (t > 0.8) opacity = (1.0 - t) / 0.2;

                    return Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      child: SizedBox(
                        width: 200,
                        height: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: LinearProgressIndicator(
                            value: t,
                            backgroundColor: Colors.black.withValues(
                              alpha: 0.05,
                            ),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              TripMatesColors.green,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
