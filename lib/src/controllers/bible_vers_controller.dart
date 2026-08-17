import 'package:how_is_your_faith/src/core/utils/exceptions/bible_api_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:how_is_your_faith/src/core/config/biblie_api_config.dart';

class BibleVersController {
  static Future<String> getBibleVerse(
    String book,
    int chapter,
    int verse,
  ) async {
    final url = Uri.parse(
      '${BiblieApiConfig.baseUrl}/nvi/$book/$chapter/$verse',
    );
    final response = await http.get(url, headers: BiblieApiConfig.hearders);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['text'].replaceAll('"', '') ??
          'Versículo não encontrado.';
    } else {
      throw BibleApiException('Falha ao carregar o versículo da Bíblia');
    }
  }

  static Future<Map<String, dynamic>> getTodayVerse() async {
    final url = Uri.parse('${BiblieApiConfig.baseUrl}/votd?language=pt-br');
    print('URL: $url');
    final response = await http.get(url, headers: BiblieApiConfig.hearders);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw BibleApiException('Falha ao carregar o versículo do dia da Bíblia');
    }
  }

  static Future<List<Map<String, dynamic>>> getBooks() async {
    final url = Uri.parse('${BiblieApiConfig.baseUrl}/books');
    final response = await http.get(url, headers: BiblieApiConfig.hearders);

    if (response.statusCode != 200) {
      throw BibleApiException('Falha ao carregar os livros da Bíblia');
    }

    final Map<String, dynamic> body = json.decode(response.body);
    final dynamic data = body['data'];

    if (data is! List) {
      throw BibleApiException('Formato inválido ao carregar livros da Bíblia');
    }

    return data
        .whereType<Map>()
        .map((book) => Map<String, dynamic>.from(book))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> getChapter(
    String book,
    int chapter,
  ) async {
    final url = Uri.parse('${BiblieApiConfig.baseUrl}/nvi/$book/$chapter');
    final response = await http.get(url, headers: BiblieApiConfig.hearders);

    if (response.statusCode != 200) {
      throw BibleApiException('Falha ao carregar os capítulos do livro $book');
    }

    final Map<String, dynamic> body = json.decode(response.body);
    final dynamic data = body['data'];

    if (data is! Map<String, dynamic>) {
      throw BibleApiException('Formato inválido ao carregar capítulo de $book');
    }

    final dynamic versesRaw = data['verses'];

    if (versesRaw is! List) {
      throw BibleApiException(
        'Versículos inválidos ao carregar capítulo de $book',
      );
    }

    return versesRaw.asMap().entries.map((entry) {
      final int verseNumber = entry.key + 1;
      final String text = entry.value?.toString() ?? '';

      return <String, dynamic>{'verse_number': verseNumber, 'text': text};
    }).toList();
  }

  //       .whereType<Map>()
  //       .map((verse) => Map<String, dynamic>.from(verse))
  //       .toList();
  // }
}
