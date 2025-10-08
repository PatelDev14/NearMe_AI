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

  final int numIcons = 36; // number of floating icons
  final List<_FloatingIcon> _icons = [];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat();

      final List<IconData> possibleIcons = [
      Icons.location_pin,
      Icons.coffee,
      Icons.nightlife,
      Icons.fastfood,
      Icons.explore,
      Icons.shopping_bag,
      Icons.local_hospital,
      Icons.park,
      Icons.attractions,
      Icons.local_mall,
      Icons.movie,
      Icons.sports_soccer,
      Icons.local_cafe,
      Icons.local_bar,
      Icons.local_dining,
      Icons.local_florist,
      Icons.local_gas_station,
      Icons.local_hotel,
      Icons.local_library,
      Icons.local_pharmacy,
      Icons.local_pizza,
      Icons.local_taxi,
      Icons.local_see,
      Icons.local_shipping,
      Icons.local_play,
      Icons.local_convenience_store,
      Icons.local_fire_department,
      Icons.local_police,
      Icons.local_post_office,
      Icons.local_drink,
    ];

    // 2. Use the list to select a random icon for each instance
    for (int i = 0; i < numIcons; i++) {
      // Select a random index from the list
      final int randomIndex = _rand.nextInt(possibleIcons.length);
      
      _icons.add(_FloatingIcon(
        // Use the random icon from the list
        icon: possibleIcons[randomIndex], 
        x: _rand.nextDouble(),
        y: _rand.nextDouble(),
        size: 20 + _rand.nextDouble() * 20,
        speed: 0.4 + _rand.nextDouble() * 0.3,
        opacity: 0.4 + _rand.nextDouble() * 0.3,
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
                    colors: [Color.fromARGB(255, 117, 182, 179), Color.fromARGB(255, 186, 216, 104)],
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
                      color: const Color.fromARGB(255, 163, 144, 144).withOpacity(0.7),
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
