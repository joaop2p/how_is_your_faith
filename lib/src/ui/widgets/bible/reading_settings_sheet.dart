import 'package:flutter/material.dart';

const List<double> kSpeedOptions = [0.25, 0.50, 0.75, 1.00, 1.25, 1.50, 2.00];

const List<String> _speedLabels = [
  'Muito Lenta',
  'Lenta',
  'Moderada',
  'Média',
  'Rápida',
  'Muito Rápida',
  'Máxima',
];

const List<double> kFontSizes = [15.0, 18.0, 22.0];
const List<String> kFontSizeLabels = ['Pequeno', 'Médio', 'Grande'];

class ReadingSettingsSheet extends StatefulWidget {
  const ReadingSettingsSheet({
    super.key,
    required this.speedIndex,
    required this.fontSizeIndex,
    required this.isAutoScrolling,
    required this.onSpeedChanged,
    required this.onFontSizeChanged,
    required this.onAutoScrollToggled,
  });

  final int speedIndex;
  final int fontSizeIndex;
  final bool isAutoScrolling;
  final ValueChanged<int> onSpeedChanged;
  final ValueChanged<int> onFontSizeChanged;
  final VoidCallback onAutoScrollToggled;

  @override
  State<ReadingSettingsSheet> createState() => _ReadingSettingsSheetState();
}

class _ReadingSettingsSheetState extends State<ReadingSettingsSheet> {
  static const _accent = Color(0xFF8B85E8);

  late double _sliderValue;
  late int _fontSizeIndex;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.speedIndex.toDouble();
    _fontSizeIndex = widget.fontSizeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
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
          const SizedBox(height: 20),
          _buildSection(
            title: 'Auto rolagem',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.directions_walk,
                      size: 22,
                      color: Color(0xFF9EA3AE),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: _accent,
                          inactiveTrackColor: const Color(0xFFE3E0FA),
                          thumbColor: _accent,
                          overlayColor: _accent.withValues(alpha: 0.12),
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 10,
                          ),
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: _sliderValue,
                          min: 0,
                          max: (kSpeedOptions.length - 1).toDouble(),
                          divisions: kSpeedOptions.length - 1,
                          onChanged: (v) {
                            setState(() => _sliderValue = v);
                            widget.onSpeedChanged(v.round());
                          },
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.directions_run,
                      size: 22,
                      color: Color(0xFF9EA3AE),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    'Velocidade: ${_speedLabels[_sliderValue.round()]}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7D7D89),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          const _Divider(),
          _buildSection(
            title: 'Aparência',
            child: Column(
              children: [
                _SettingsRow(
                  icon: Icons.font_download_outlined,
                  label: 'Fonte',
                  trailing: const Row(
                    children: [
                      Text(
                        'Lora',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9EA3AE),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Color(0xFF9EA3AE),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 4),
                _SettingsRow(
                  icon: Icons.format_size,
                  label: 'Tamanho',
                  trailing: Row(
                    children: [
                      _FontSizeButton(
                        label: 'A⁻',
                        enabled: _fontSizeIndex > 0,
                        onTap: () {
                          if (_fontSizeIndex <= 0) return;
                          setState(() => _fontSizeIndex--);
                          widget.onFontSizeChanged(_fontSizeIndex);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          kFontSizeLabels[_fontSizeIndex],
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7D7D89),
                          ),
                        ),
                      ),
                      _FontSizeButton(
                        label: 'A⁺',
                        enabled: _fontSizeIndex < kFontSizes.length - 1,
                        onTap: () {
                          if (_fontSizeIndex >= kFontSizes.length - 1) return;
                          setState(() => _fontSizeIndex++);
                          widget.onFontSizeChanged(_fontSizeIndex);
                        },
                      ),
                    ],
                  ),
                  onTap: null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(color: Color(0xFFE3E0FA)),
                ),
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A5A6A),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2A2A35),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: Colors.grey.shade100),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF9EA3AE)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, color: Color(0xFF3A3A45)),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _FontSizeButton extends StatelessWidget {
  const _FontSizeButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFF0EFFD) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: enabled ? const Color(0xFF8B85E8) : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
