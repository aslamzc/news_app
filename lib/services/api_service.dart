import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static const String _baseUrl = 'https://newsapi.org';
  static final String _apiKey = dotenv.env['NEWS_API_KEY'] ?? '';


  static Future<Map<String, dynamic>> fetchNews({
    String? keyword,
    String? category,
    String? sortBy,
  }) async {
    final headers = {
      'Authorization': 'Basic $_apiKey',
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
      throw Exception(json.decode(response.body)['message']);
    }
  }
}
