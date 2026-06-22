import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class Cards extends StatelessWidget {
  final String label;
  final String img;
  final String subtitle;
  final Color textColor;
  final Color foregroundColor;

  const Cards({
    super.key,
    required this.label,
    required this.img,
    required this.subtitle,
    required this.textColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: foregroundColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CircleAvatar(
            backgroundColor: foregroundColor.withValues(alpha: 0.1),
            child: img.isNotEmpty
                ? SvgPicture.asset(
                    img,
                    fit: BoxFit.contain,
                  )
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.8),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
