import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org';

  static Future<Map<String, dynamic>> fetchNews() async {
    final headers = {
      'Authorization': 'Basic dad813f3c3214489b8b482c8dd6fe155',
    };
    final response = await http.get(
        Uri.parse('$_baseUrl/v2/top-headlines?country=us&category=health'),
        headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
