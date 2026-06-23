import 'package:how_is_your_faith/src/exceptions/bible_api_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:how_is_your_faith/src/config/biblie_api_config.dart';

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
}
