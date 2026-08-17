import 'package:flutter/material.dart';
import 'package:how_is_your_faith/src/core/utils/interfaces/themes.dart';

class LastActivityCard extends StatelessWidget {
  final String status;
  final String title;
  final Themes theme;
  final double progress;
  final int step;
  final int totalSteps;

  const LastActivityCard({
    Key? key,
    required this.status,
    required this.title,
    required this.theme,
    required this.progress,
    required this.step,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Continue de onde parou",
          //   style: TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.w700,
          //     color: Color(0xFF1C1C1C),
          //   ),
          // ),

          // const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              // color: theme.light,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // spacing: 16,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: theme.dark.withAlpha(25),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: theme.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    // spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          // letterSpacing: 1,
                          color: theme.primary,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 42, 42, 42),
                        ),
                      ),
                      Text(
                        "Dia $step de $totalSteps • ${(progress * 100).toStringAsFixed(0)}% concluído",
                        style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 42, 42, 42)),
                      ),
                      SizedBox(
                        height: 8,
                        // width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: theme.light,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                SizedBox(
                  child: IconButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_rounded, color: theme.dark),
                  ),
                ),
              ],
            ),
          ),

          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}
