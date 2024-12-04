import 'package:news/models/news.dart';
import 'package:news/services/api_service.dart';
import 'package:logger/logger.dart';

class HomeController {
  final Logger _logger = Logger();
  Future<List<News>> fetchNews() async {
    try {
      final data = await ApiService.fetchNews();
      return (data['articles'] as List)
          .map((article) => News.fromJson(article))
          .toList();
    } catch (e) {
       _logger.e('Error fetching news: $e');
      return [];
    }
  }
}
