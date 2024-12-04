import 'package:news/models/news.dart';
import 'package:news/services/api_service.dart';

class HomeController {
  Future<List<News>> fetchUsers() async {
    try {
      final data = await ApiService.fetchUsers();
      return (data['articles'] as List)
          .map((article) => News.fromJson(article))
          .toList();
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }
}
