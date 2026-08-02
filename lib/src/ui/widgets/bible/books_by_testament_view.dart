import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:how_is_your_faith/src/controllers/bible_vers_controller.dart';

class BooksByTestamentView extends StatefulWidget {
  const BooksByTestamentView({super.key, required this.testament});

  final String testament;

  @override
  State<BooksByTestamentView> createState() => _BooksByTestamentViewState();
}

class _BooksByTestamentViewState extends State<BooksByTestamentView> {
  final Map<int, int> _selectedChapterByBook = <int, int>{};

  int _asInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: BibleVersController.getBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro ao carregar livros',
              style: TextStyle(color: Colors.red.shade400),
            ),
          );
        }

        final List<Map<String, dynamic>> books =
            (snapshot.data ?? <Map<String, dynamic>>[])
                .where((book) => book['testament'] == widget.testament)
                .toList();

        if (books.isEmpty) {
          return const Center(child: Text('Nenhum livro encontrado.'));
        }

        return ListView.separated(
          // physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: books.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final Map<String, dynamic> book = books[index];
            final int bookId = _asInt(book['id'], fallback: index);
            final int chapters = _asInt(book['chapters']);
            final Map<String, dynamic> names = Map<String, dynamic>.from(
              book['name'] as Map? ?? <String, dynamic>{},
            );
            final String title = (names['pt-br'] ?? names['en'] ?? 'Livro')
                .toString();

            return Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                key: ValueKey<int>(bookId),
                tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  '$chapters capítulos',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9EA3AE),
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xFF9EA3AE),
                ),
                children: [
                  GridView.builder(
                    key: ValueKey<String>('chapters-$bookId'),
                    controller: ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chapters,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.0,
                        ),
                    itemBuilder: (context, chapterIndex) {
                      final int chapterNumber = chapterIndex + 1;
                      final bool selected =
                          _selectedChapterByBook[bookId] == chapterNumber;

                      return InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          setState(() {
                            _selectedChapterByBook[bookId] = chapterNumber;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF8B85E8)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF8B85E8)
                                  : const Color(0xFFE3E6EC),
                            ),
                          ),
                          child: Text(
                            '$chapterNumber',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : const Color(0xFF3A3A45),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
