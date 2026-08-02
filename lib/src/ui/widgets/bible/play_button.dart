import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.isPlaying, required this.onTap});

  final bool isPlaying;
  final VoidCallback onTap;

  static const _accent = Color(0xFF8B85E8);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: _accent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _accent.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
