import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/news.dart';

class NewsProvider with ChangeNotifier {
  final Logger _logger = Logger();
  final NewsController _controller = NewsController();

  NewsProvider() {
    fetchNews();
  }

  List<News> _news = [];
  List<News> get news => _news;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _category;
  String? get category => _category;

  String? _keyword;
  String? get keyword => _keyword;

  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  void setKeyword(String? newKeyword) {
    _keyword = newKeyword;
    notifyListeners();
  }

  void setCategory(String? newCategory) {
    _category = newCategory;
    notifyListeners();
  }

  void resetPagination() {
    _currentPage = 1;
    _hasMore = true;
    _news = [];
  }

  Future<void> fetchNews({bool preventLoading = true}) async {
    if (_isLoading || !_hasMore) return;
    try {
      _isLoading = preventLoading;
      _error = null;
      notifyListeners();
      final List<News> fetchedNews = await _controller.fetchNews(
          keyword: _keyword, category: _category, page: _currentPage);

      if (fetchedNews.isEmpty) {
        _hasMore = false;
      } else {
        _news.addAll(fetchedNews);
        _currentPage++;
      }
    } catch (e) {
      _logger.e(e);
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
