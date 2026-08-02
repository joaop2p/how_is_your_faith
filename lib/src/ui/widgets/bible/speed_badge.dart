import 'package:flutter/material.dart';

class SpeedBadge extends StatelessWidget {
  const SpeedBadge({super.key, required this.speed, required this.onTap});

  final double speed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF8B85E8).withOpacity(0.3)),
        ),
        child: Text(
          '${speed.toStringAsFixed(2)}x',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B85E8),
          ),
        ),
      ),
    );
  }
}
