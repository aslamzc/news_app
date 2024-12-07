import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/news.dart';

class DiscoverNewsProvider with ChangeNotifier {
  final Logger _logger = Logger();
  final NewsController _controller = NewsController();

  List<News> _allNews = [];
  List<News> get allNews => _allNews;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _sortBy;
  String? get sortBy => _sortBy;

  String? _keyword;
  String? get keyword => _keyword;

  void setKeyword(String? newKeyword) {
    _keyword = newKeyword;
    notifyListeners();
  }

  void setSortBy(String? newSortBy) {
    _sortBy = newSortBy;
    notifyListeners();
  }

  Future<void> fetchAllNews({bool preventLoading = true}) async {
    try {
      _isLoading = preventLoading;
      _error = null;
      notifyListeners();
      _allNews = await _controller.fetchAllNews(
        keyword: _keyword,
        sortBy: _sortBy,
      );
    } catch (e) {
      _logger.e(e);
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
