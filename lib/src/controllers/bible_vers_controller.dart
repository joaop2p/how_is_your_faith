import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:how_is_your_faith/src/config/biblie_api_config.dart';

class BibleVersController {
  static Future<String> getBibleVerse(
    String book,
    int chapter,
    int verse,
  ) async {
    final url = Uri.parse('${BiblieApiConfig.baseUrl}/$book/$chapter/$verse');
    print('URL: $url');
    final response = await http.get(url, headers: BiblieApiConfig.hearders);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['text'].replaceAll('"', '') ??
          'Versículo não encontrado.';
    } else {
      throw Exception('Falha ao carregar o versículo da Bíblia');
    }
  }
}
