import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme.dart';
import 'assistant_intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const AssetImage _mascotImage = AssetImage('assets/icon/app_icon.png');

  late final AnimationController _introController;
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    _runAnimationSequence();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_mascotImage, context);
  }

  Future<void> _runAnimationSequence() async {
    try {
      await _introController.forward();
      if (!mounted) {
        return;
      }

      _floatController.repeat(reverse: true);
      await Future<void>.delayed(const Duration(milliseconds: 1800));
      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          transitionDuration: const Duration(milliseconds: 700),
          reverseTransitionDuration: const Duration(milliseconds: 450),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AssistantIntroScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            final slide = Tween<Offset>(
              begin: const Offset(0.0, 0.035),
              end: Offset.zero,
            ).animate(fade);
            return FadeTransition(
              opacity: fade,
              child: SlideTransition(
                position: slide,
                child: child,
              ),
            );
          },
        ),
      );
    } on TickerCanceled {
      // Animation was disposed while a sequence step was in flight.
    }
  }

  @override
  void dispose() {
    _introController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.95, -1.0),
              end: Alignment(1.0, 1.0),
              colors: [
                AppPalette.background,
                AppPalette.surfaceSoft,
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.0, -0.1),
                    radius: 1.0,
                    colors: [
                      Color(0x22E8665D),
                      Color(0x00FFFFFF),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = constraints.maxHeight;
                    final mascotSize = math
                        .min(width * 0.68, height * 0.40)
                        .clamp(
                          220.0,
                          320.0,
                        )
                        .toDouble();
                    final titleSize =
                        (width * 0.108).clamp(36.0, 52.0).toDouble();
                    final subtitleSize =
                        (width * 0.045).clamp(16.0, 20.0).toDouble();

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.20),
                          _AnimatedFox(
                            size: mascotSize,
                            introController: _introController,
                            floatController: _floatController,
                            imageProvider: _mascotImage,
                          ),
                          SizedBox(height: height * 0.03),
                          Text(
                            'Study Abroad',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.w800,
                              height: 0.98,
                              color: AppPalette.textPrimary,
                              letterSpacing: -0.6,
                            ),
                          ),
                          SizedBox(height: height * 0.022),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: width * 0.78),
                            child: Text(
                              'Your AI Study Abroad Companion',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: subtitleSize,
                                fontWeight: FontWeight.w500,
                                color: AppPalette.textSecondary
                                    .withValues(alpha: 0.96),
                                letterSpacing: -0.15,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(height: height * 0.05),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedFox extends StatelessWidget {
  const _AnimatedFox({
    required this.size,
    required this.introController,
    required this.floatController,
    required this.imageProvider,
  });

  final double size;
  final AnimationController introController;
  final AnimationController floatController;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        introController,
        floatController,
      ]),
      builder: (context, child) {
        final intro = Curves.easeOutCubic.transform(introController.value);
        final floating =
            math.sin(floatController.value * math.pi * 2) * size * 0.018;
        final opacity = intro;
        final scale = lerpDouble(0.88, 1.0, intro)!;
        final introOffset = lerpDouble(size * 0.10, 0.0, intro)!;

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0.0, introOffset + floating),
            child: Transform.scale(
              scale: scale,
              child: SizedBox(
                width: size * 1.30,
                height: size * 1.18,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: size * 0.33,
                      right: size * 0.33,
                      bottom: size * 0.01,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size),
                          boxShadow: [
                            BoxShadow(
                              color: AppPalette.shadow.withValues(alpha: 0.10),
                              blurRadius: size * 0.07,
                              spreadRadius: size * 0.01,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: size * 0.045,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Image(
                        image: imageProvider,
                        width: size,
                        height: size,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
