// import 'package:flutter/material.dart';

// class AnimatedBackground extends StatefulWidget {
//   const AnimatedBackground({super.key});

//   @override
//   State<AnimatedBackground> createState() => _AnimatedBackgroundState();
// }

// class _AnimatedBackgroundState extends State<AnimatedBackground>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _ctrl;
//   static const _duration = Duration(seconds: 8);

//   final List<List<Color>> _gradients = [
//     [Color(0xFF0F2027), Color(0xFF2C5364)],
//     [Color(0xFF3A1C71), Color(0xFFD76D77)],
//     [Color(0xFF00C9FF), Color(0xFF92FE9D)],
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(vsync: this, duration: _duration)..repeat();
//   }

//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned.fill(
//       child: AnimatedBuilder(
//         animation: _ctrl,
//         builder: (context, child) {
//           // compute indices & local t between them
//           final t = _ctrl.value * (_gradients.length);
//           final index = t.floor() % _gradients.length;
//           final next = (index + 1) % _gradients.length;
//           final localT = t - t.floor();

//           final c1 = Color.lerp(_gradients[index][0], _gradients[next][0], localT)!;
//           final c2 = Color.lerp(_gradients[index][1], _gradients[next][1], localT)!;

//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [c1, c2],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             // subtle overlay to keep content readable
//             child: Container(
//               color: Colors.black.withOpacity(0.08),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';

class ThemedAnimatedBackground extends StatefulWidget {
  const ThemedAnimatedBackground({super.key});

  @override
  State<ThemedAnimatedBackground> createState() => _ThemedAnimatedBackgroundState();
}

class _ThemedAnimatedBackgroundState extends State<ThemedAnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final Random _rand = Random();

  final int numIcons = 12; // number of floating icons
  final List<_FloatingIcon> _icons = [];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat();

    // Initialize floating icons with random properties
    for (int i = 0; i < numIcons; i++) {
      _icons.add(_FloatingIcon(
        icon: _rand.nextBool() ? Icons.location_pin : Icons.coffee,
        x: _rand.nextDouble(),
        y: _rand.nextDouble(),
        size: 20 + _rand.nextDouble() * 20,
        speed: 0.2 + _rand.nextDouble() * 0.3,
        opacity: 0.1 + _rand.nextDouble() * 0.3,
      ));
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Stack(
            children: [
              // Base gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Floating icons
              ..._icons.map((f) {
                final newY = (f.y + _ctrl.value * f.speed) % 1.0;
                return Positioned(
                  left: f.x * MediaQuery.of(context).size.width,
                  top: newY * MediaQuery.of(context).size.height,
                  child: Opacity(
                    opacity: f.opacity,
                    child: Icon(
                      f.icon,
                      size: f.size,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}

class _FloatingIcon {
  final IconData icon;
  final double x, y;
  final double size;
  final double speed;
  final double opacity;

  _FloatingIcon({
    required this.icon,
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}
