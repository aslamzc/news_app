// import 'dart:convert';
// import 'package:http/http.dart' as http;

class ApiService {
  // static const String _baseUrl = 'https://api.example.com';

  static Future<List<dynamic>> fetchUsers() async {
    // final response = await http.get(Uri.parse('$_baseUrl/users'));

    return [
      {"id": 1, "name": "John Doe", "email": "john@example.comg"},
      {"id": 2, "name": "Jane Doe", "email": "jane@example.com"},
    ];
  }
}
