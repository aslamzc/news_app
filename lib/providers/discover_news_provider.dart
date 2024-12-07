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

  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  void setKeyword(String? newKeyword) {
    _keyword = newKeyword;
    notifyListeners();
  }

  void setSortBy(String? newSortBy) {
    _sortBy = newSortBy;
    notifyListeners();
  }

  void resetPagination() {
    _currentPage = 1;
    _hasMore = true;
    _allNews = [];
  }

  Future<void> fetchAllNews({bool preventLoading = true}) async {
    if (_isLoading || !_hasMore) return;
    try {
      _isLoading = preventLoading;
      _error = null;
      notifyListeners();
      final List<News> fetchedNews = await _controller.fetchAllNews(
          keyword: _keyword, sortBy: _sortBy, page: _currentPage);

      if (fetchedNews.isEmpty) {
        _hasMore = false;
      } else {
        _allNews.addAll(fetchedNews);
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
