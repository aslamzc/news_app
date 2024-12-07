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

  void setKeyword(String? newKeyword) {
    _keyword = newKeyword;
    notifyListeners();
  }

  void setCategory(String? newCategory) {
    _category = newCategory;
    notifyListeners();
  }

  Future<void> fetchNews({bool preventLoading = true}) async {
    try {
      _isLoading = preventLoading;
      _error = null;
      notifyListeners();
      _news =
          await _controller.fetchNews(keyword: _keyword, category: _category);
    } catch (e) {
      _logger.e(e);
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
