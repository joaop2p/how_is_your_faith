import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:how_is_your_faith/src/controllers/bible_vers_controller.dart';
import 'package:how_is_your_faith/src/ui/widgets/bible/chapter_picker_sheet.dart';
import 'package:how_is_your_faith/src/ui/widgets/bible/play_button.dart';
import 'package:how_is_your_faith/src/ui/widgets/bible/reading_settings_sheet.dart';
import 'package:how_is_your_faith/src/ui/widgets/bible/speed_badge.dart';

class BibleBookPage extends StatefulWidget {
  final int? chapterNumber;
  final Map<String, dynamic> bookMetadata;

  const BibleBookPage({
    super.key,
    required this.bookMetadata,
    this.chapterNumber,
  });

  @override
  State<BibleBookPage> createState() => _BibleBookPageState();
}

class _BibleBookPageState extends State<BibleBookPage> {
  static const _kAccent = Color(0xFF8B85E8);
  static const _kControlBg = Color(0xFFF8F5FF);
  static const List<double> _kSpeedOptions = [
    0.25,
    0.50,
    0.75,
    1.00,
    1.25,
    1.50,
    2.00,
  ];

  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;

  late int _currentChapter;
  late Future<List<Map<String, dynamic>>> _chapterFuture;

  bool _isAutoScrolling = false;
  int _speedIndex = 3; // padrão 1.00x
  int _fontSizeIndex = 1; // padrão médio

  // ── accessors ──────────────────────────────────────────────────────────────

  String get _bookTitle =>
      widget.bookMetadata['name']?['pt-br'] ??
      widget.bookMetadata['name']?['en'] ??
      'Livro';

  int get _totalChapters =>
      _asInt(widget.bookMetadata['chapters'], fallback: 1);

  String get _bookApiName =>
      widget.bookMetadata['name']?['en']?.toString() ?? '';

  double get _scrollSpeed => _kSpeedOptions[_speedIndex];

  bool get _hasNextChapter => _currentChapter < _totalChapters;

  // ── helpers ────────────────────────────────────────────────────────────────

  int _asInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  void _loadChapter(int chapter) {
    _stopAutoScroll();
    setState(() {
      _currentChapter = chapter;
      _chapterFuture = BibleVersController.getChapter(
        _bookApiName,
        _currentChapter,
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) _scrollController.jumpTo(0);
    });
  }

  // ── lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _currentChapter = widget.chapterNumber ?? 1;
    _chapterFuture = BibleVersController.getChapter(
      _bookApiName,
      _currentChapter,
    );
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _scrollController.dispose();
    super.dispose();
  }

  // ── auto-scroll ────────────────────────────────────────────────────────────

  void _toggleAutoScroll() =>
      _isAutoScrolling ? _stopAutoScroll() : _startAutoScroll();

  void _startAutoScroll() {
    if (!_scrollController.hasClients) return;
    setState(() => _isAutoScrolling = true);
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      if (!_scrollController.hasClients) return;
      final current = _scrollController.offset;
      final max = _scrollController.position.maxScrollExtent;
      final next = (current + 0.9 * _scrollSpeed).clamp(0.0, max);
      _scrollController.jumpTo(next);
      if (next >= max) _stopAutoScroll();
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
    if (_isAutoScrolling) setState(() => _isAutoScrolling = false);
  }

  // ── bottom sheets ──────────────────────────────────────────────────────────

  void _showChapterPicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => ChapterPickerSheet(
        totalChapters: _totalChapters,
        currentChapter: _currentChapter,
        onSelected: (ch) {
          Navigator.pop(context);
          _loadChapter(ch);
        },
      ),
    );
  }

  void _showReadingSettings() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => ReadingSettingsSheet(
        speedIndex: _speedIndex,
        fontSizeIndex: _fontSizeIndex,
        isAutoScrolling: _isAutoScrolling,
        onSpeedChanged: (i) => setState(() => _speedIndex = i),
        onFontSizeChanged: (i) => setState(() => _fontSizeIndex = i),
        onAutoScrollToggled: _toggleAutoScroll,
      ),
    );
  }

  // ── build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildControls(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _kControlBg,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0,
      title: GestureDetector(
        onTap: _showChapterPicker,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                '$_bookTitle $_currentChapter',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, size: 20),
          ],
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
        IconButton(icon: const Icon(Icons.draw_outlined), onPressed: () {}),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: _showReadingSettings,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _chapterFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao carregar o capitulo: ${snapshot.error}'),
          );
        }
        final verses = snapshot.data ?? [];
        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          itemCount: verses.length + 1,
          itemBuilder: (context, index) {
            if (index == verses.length) return _buildEndItem();
            return _buildVerseItem(verses[index]);
          },
        );
      },
    );
  }

  Widget _buildVerseItem(Map<String, dynamic> verse) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '${verse['verse_number'] ?? ''}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF525252),
              ),
            ),
          ),
          Expanded(
            child: Text(
              verse['text'] ?? '',
              style: GoogleFonts.lora(fontSize: kFontSizes[_fontSizeIndex]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 120),
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: _kAccent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: _hasNextChapter
            ? () => _loadChapter(_currentChapter + 1)
            : null,
        icon: Icon(
          _hasNextChapter ? Icons.arrow_forward : Icons.check_circle_outline,
        ),
        label: Text(
          _hasNextChapter ? 'Capitulo ${_currentChapter + 1}' : 'Fim do livro',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        decoration: BoxDecoration(
          color: _kControlBg,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _kAccent.withValues(alpha: 0.18),
              blurRadius: 24,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            PlayButton(isPlaying: _isAutoScrolling, onTap: _toggleAutoScroll),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_bookTitle $_currentChapter',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _isAutoScrolling
                        ? 'Auto rolagem ativa'
                        : 'Auto rolagem inativa',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF7D7D89),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // SpeedBadge(speed: _scrollSpeed, onTap: _showReadingSettings),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_up),
              onPressed: _showReadingSettings,
            ),
          ],
        ),
      ),
    );
  }
}
