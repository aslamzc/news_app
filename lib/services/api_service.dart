import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org';

  static Future<Map<String, dynamic>> fetchNews({
    String? keyword,
    String? category,
    String? sortBy,
  }) async {
    final headers = {
      'Authorization': 'Basic dad813f3c3214489b8b482c8dd6fe155',
    };

    final queryParameters = {
      'country': 'us',
      if (category != null) 'category': category,
      if (keyword != null) 'q': keyword,
      if (sortBy != null) 'sortBy': sortBy,
    };

    final uri = Uri.parse('$_baseUrl/v2/top-headlines')
        .replace(queryParameters: queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
