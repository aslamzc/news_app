import 'package:news/models/news.dart';
import 'package:news/services/api_service.dart';
import 'package:logger/logger.dart';

class NewsController {
  final Logger _logger = Logger();
  Future<List<News>> fetchNews({
    String? keyword,
    String? category,
    String? sortBy,
  }) async {
    try {
      final data = await ApiService.fetchNews(
        keyword: keyword,
        category: category,
        sortBy: sortBy,
      );

      return (data['articles'] as List)
          .map((article) => News.fromJson(article))
          .toList();
    } catch (e) {
      _logger.e('Error fetching news: $e');
      return [];
    }
  }
}
