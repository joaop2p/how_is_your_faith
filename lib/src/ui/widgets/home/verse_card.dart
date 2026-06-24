import 'dart:math' as math;

import 'package:flutter/material.dart';

class VerseCard extends StatelessWidget {
  final String verse;
  final String reference;

  const VerseCard({required this.verse, required this.reference, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255).withAlpha(50),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/verse_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white.withValues(alpha: 0.5),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 0.8, 1.0],
                ),
              ),
            ),
          ),
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(58, 214, 174, 108),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu_book_sharp,
                        color: Color(0xFFD6AE6C),
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Versículo do dia',
                        style: TextStyle(
                          color: Color(0xFFD6AE6C),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Icon(
                    Icons.format_quote,
                    color: Color(0xFFD6AE6C),
                    size: 30,
                  ),
                ),
                // SizedBox(height: 5),
                Text(
                  verse,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  reference,
                  style: TextStyle(fontSize: 14, color: Color(0xFFD6AE6C)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
