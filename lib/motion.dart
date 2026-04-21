import 'dart:math' as math;

import 'package:flutter/material.dart';

class FoxAssistantAvatar extends StatefulWidget {
  const FoxAssistantAvatar({
    super.key,
    required this.size,
    this.speaking = true,
  });

  final double size;
  final bool speaking;

  @override
  State<FoxAssistantAvatar> createState() => _FoxAssistantAvatarState();
}

class _FoxAssistantAvatarState extends State<FoxAssistantAvatar>
    with SingleTickerProviderStateMixin {
  static final _precacheAssets = <AssetImage>[
    const AssetImage(_FoxAssets.body),
    const AssetImage(_FoxAssets.head),
  ];

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final asset in _precacheAssets) {
      precacheImage(asset, context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _pulse(double t, double center, double width) {
    final distance = (t - center).abs();
    if (distance >= width) {
      return 0;
    }

    final normalized = 1 - (distance / width);
    return Curves.easeInOutCubic.transform(normalized);
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = _FoxRig.viewport.width / _FoxRig.viewport.height;

    return SizedBox(
      width: widget.size * aspectRatio,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value;
          final breathe = math.sin(t * math.pi * 2);
          final sway = math.sin((t * math.pi * 2 * 0.74) + 0.35);
          final nod = math.cos((t * math.pi * 2 * 0.92) - 0.18);
          final blink = math.max(
            math.max(_pulse(t, 0.16, 0.055), _pulse(t, 0.21, 0.036)),
            _pulse(t, 0.72, 0.060),
          );
          final talk = widget.speaking
              ? math.max(
                  math.max(_pulse(t, 0.08, 0.036), _pulse(t, 0.14, 0.030)),
                  math.max(_pulse(t, 0.54, 0.042), _pulse(t, 0.62, 0.032)),
                )
              : 0.0;

          final rootLift = (breathe * 10) + (sway * 4);
          final shadowScaleX = 1 + (breathe * 0.05);
          final shadowScaleY = 1 + (breathe * 0.02);
          final bodyScaleX = 1 - (breathe * 0.006);
          final bodyScaleY = 1 + (breathe * 0.012);
          final headOffset = Offset(
            sway * 9,
            -14 + (nod * 5) + (breathe * 3) - (talk * 2.5),
          );
          final headAngle = (sway * 0.018) + (nod * 0.006) + (talk * 0.005);
          final blinkEase =
              Curves.easeInOutCubic.transform(blink.clamp(0.0, 1.0));

          return ClipRect(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _FoxRig.viewport.width,
                height: _FoxRig.viewport.height,
                child: Transform.translate(
                  offset: Offset(
                    -_FoxRig.viewport.left,
                    -_FoxRig.viewport.top,
                  ),
                  child: SizedBox(
                    width: _FoxRig.canvasWidth,
                    height: _FoxRig.canvasHeight,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        _GroundShadow(
                          scaleX: shadowScaleX,
                          scaleY: shadowScaleY,
                        ),
                        Transform.translate(
                          offset: Offset(0, rootLift),
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              _CanvasLayer(
                                asset: _FoxAssets.body,
                                scaleX: bodyScaleX,
                                scaleY: bodyScaleY,
                                alignment: const Alignment(0.0, 0.94),
                              ),
                              Transform.translate(
                                offset: headOffset,
                                child: Transform.rotate(
                                  angle: headAngle,
                                  alignment:
                                      _FoxRig.alignmentFor(_FoxRig.headPivot),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    clipBehavior: Clip.none,
                                    children: [
                                      const _CanvasLayer(
                                        asset: _FoxAssets.head,
                                      ),
                                      CustomPaint(
                                        painter: _FoxBlinkPainter(
                                          blink: blinkEase,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CanvasLayer extends StatelessWidget {
  const _CanvasLayer({
    required this.asset,
    this.scaleX = 1,
    this.scaleY = 1,
    this.alignment = Alignment.center,
  });

  final String asset;
  final double scaleX;
  final double scaleY;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform(
        alignment: alignment,
        transform: Matrix4.identity()..scale(scaleX, scaleY),
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

class _GroundShadow extends StatelessWidget {
  const _GroundShadow({
    required this.scaleX,
    required this.scaleY,
  });

  final double scaleX;
  final double scaleY;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _FoxRig.shadowRect.left,
      top: _FoxRig.shadowRect.top,
      child: Transform.scale(
        scaleX: scaleX,
        scaleY: scaleY,
        child: IgnorePointer(
          child: SizedBox(
            width: _FoxRig.shadowRect.width,
            height: _FoxRig.shadowRect.height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: const RadialGradient(
                  colors: [
                    Color(0x4D5A1A00),
                    Color(0x005A1A00),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33461600),
                    blurRadius: 18,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FoxBlinkPainter extends CustomPainter {
  const _FoxBlinkPainter({
    required this.blink,
  });

  final double blink;

  @override
  void paint(Canvas canvas, Size size) {
    if (blink <= 0) {
      return;
    }

    final topPaint = Paint()
      ..color = Color.lerp(
        const Color(0xFFFFA229),
        const Color(0xFFE96B00),
        blink * 0.55,
      )!;
    final bottomPaint = Paint()
      ..color = Color.lerp(
        const Color(0xFFFFF7ED),
        const Color(0xFFF6E8D7),
        blink * 0.35,
      )!;
    final lashPaint = Paint()
      ..color = const Color(0xFF5A1E14).withOpacity(0.10 + (blink * 0.42))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7;

    void paintEye({
      required Offset center,
      required double width,
      required double height,
    }) {
      final rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      final topHeight = rect.height * (0.05 + (blink * 0.50));
      final bottomHeight = rect.height * (0.03 + (blink * 0.34));

      final topRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          rect.left - 8,
          rect.top - 10,
          rect.width + 16,
          topHeight,
        ),
        const Radius.circular(160),
      );
      final bottomRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          rect.left - 6,
          rect.bottom - bottomHeight + 10,
          rect.width + 12,
          bottomHeight,
        ),
        const Radius.circular(160),
      );

      canvas.drawRRect(topRect, topPaint);
      canvas.drawRRect(bottomRect, bottomPaint);

      if (blink > 0.6) {
        final y = rect.center.dy + (blink * 5);
        canvas.drawLine(
          Offset(rect.left + 26, y),
          Offset(rect.right - 26, y - 2),
          lashPaint,
        );
      }
    }

    paintEye(
      center: _FoxRig.leftEyeCenter,
      width: 330,
      height: 310,
    );
    paintEye(
      center: _FoxRig.rightEyeCenter,
      width: 330,
      height: 310,
    );
  }

  @override
  bool shouldRepaint(covariant _FoxBlinkPainter oldDelegate) {
    return oldDelegate.blink != blink;
  }
}

class _FoxRig {
  static const double canvasWidth = 2048;
  static const double canvasHeight = 2048;

  static const Rect viewport = Rect.fromLTWH(280, 170, 1490, 1630);
  static const Rect shadowRect = Rect.fromLTWH(690, 1732, 660, 108);

  static const Offset headPivot = Offset(1024, 1060);
  static const Offset leftEyeCenter = Offset(720, 822);
  static const Offset rightEyeCenter = Offset(1328, 822);

  static Alignment alignmentFor(Offset pivot) {
    return Alignment(
      (pivot.dx / canvasWidth) * 2 - 1,
      (pivot.dy / canvasHeight) * 2 - 1,
    );
  }
}

class _FoxAssets {
  const _FoxAssets();

  static const String body = 'assets/Fox/body_base.png';
  static const String head = 'assets/Fox/head.png';
}
