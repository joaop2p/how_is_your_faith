import 'package:flutter/material.dart';

class ChapterPickerSheet extends StatelessWidget {
  const ChapterPickerSheet({
    super.key,
    required this.totalChapters,
    required this.currentChapter,
    required this.onSelected,
  });

  final int totalChapters;
  final int currentChapter;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Escolher capítulo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: totalChapters,
            itemBuilder: (_, i) {
              final ch = i + 1;
              final selected = ch == currentChapter;
              return GestureDetector(
                onTap: () => onSelected(ch),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF8B85E8)
                        : const Color(0xFFF0EFFD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$ch',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : const Color(0xFF3A3A45),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
