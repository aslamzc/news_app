import 'package:news/models/news.dart';
import 'package:news/repositories/news_repository.dart';
import 'package:news/services/api_service.dart';
import 'package:logger/logger.dart';

class NewsController {
  final Logger _logger = Logger();
  Future<List<News>> fetchNews({
    String? keyword,
    String? category,
    String? sortBy,
    int page = 1,
  }) async {
    try {
      final data = await ApiService.fetchNews(
        keyword: keyword,
        category: category,
        sortBy: sortBy,
        page: page,
      );

      return (data['articles'] as List)
          .map((article) => News.fromJson(article))
          .toList();
    } catch (e) {
      _logger.e(e);
      return [];
    }
  }

  Future<List<News>> fetchAllNews({
    String? keyword,
    String? category,
    String? sortBy,
    int page = 1,
  }) async {
    try {
      final data = await ApiService.fetchAllNews(
        keyword: keyword,
        category: category,
        sortBy: sortBy,
        page: page,
      );

      return (data['articles'] as List)
          .map((article) => News.fromJson(article))
          .toList();
    } catch (e) {
      _logger.e(e);
      return [];
    }
  }

  Future<List<News>> fetchSavedNews({String order = 'DESC'}) async {
    try {
      final NewsRepository newsRepository = NewsRepository.instance;
      final savedNews = await newsRepository.getSavedNews(order: order);
      return savedNews;
    } catch (e) {
      _logger.e(e);
      return [];
    }
  }
}
