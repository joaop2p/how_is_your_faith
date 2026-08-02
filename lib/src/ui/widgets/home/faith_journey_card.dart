import 'package:flutter/material.dart';

class FaithJourneyCard extends StatelessWidget {
  final Map<String, Object> card;

  const FaithJourneyCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final color = card["accentColor"] as Color;

    return Container(
      width: 120,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withOpacity(.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              shape: BoxShape.circle,
            ),
            child: Icon(card["icon"] as IconData, color: color, size: 22),
          ),

          const SizedBox(height: 3),

          Text(
            card["title"] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6F7482),
              fontWeight: FontWeight.w500,
            ),
          ),

          // const SizedBox(height: 6),
          Text(
            card["value"] as String,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),

          // const SizedBox(height: 4),
          Text(
            card["subtitle"] as String,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              height: 1.35,
              color: Color(0xFF8D94A5),
            ),
          ),

          const Spacer(),

          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: card["progress"] as double,
              minHeight: 5,
              backgroundColor: color.withOpacity(.12),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
