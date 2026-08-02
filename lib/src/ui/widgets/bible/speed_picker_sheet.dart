import 'package:flutter/material.dart';

class SpeedPickerSheet extends StatelessWidget {
  const SpeedPickerSheet({
    super.key,
    required this.speedOptions,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<double> speedOptions;
  final int selectedIndex;
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
          'Velocidade de leitura',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(speedOptions.length, (i) {
              final selected = i == selectedIndex;
              return GestureDetector(
                onTap: () => onSelected(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF8B85E8)
                        : const Color(0xFFF0EFFD),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '${speedOptions[i].toStringAsFixed(2)}x',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : const Color(0xFF3A3A45),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
