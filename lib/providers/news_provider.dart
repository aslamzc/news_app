import 'package:flutter/material.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/news.dart';

class NewsProvider with ChangeNotifier {
  final NewsController _controller = NewsController();

  NewsProvider() {
    fetchNews();
  }

  List<News> _news = [];
  List<News> get news => _news;

  List<News> _allNews = [];
  List<News> get allNews => _allNews;

  List<News> _savedNews = [];
  List<News> get savedNews => _savedNews;

  String _order = 'DESC';
  String get order => _order;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _category;
  String? get category => _category;

  String? _sortBy;
  String? get sortBy => _sortBy;

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

  void setSortBy(String? newSortBy) {
    _sortBy = newSortBy;
    notifyListeners();
  }

  Future<void> fetchNews({bool preventLoading = true}) async {
    _isLoading = preventLoading;
    _error = null;
    notifyListeners();

    try {
      _news = await _controller.fetchNews(
        keyword: _keyword,
        category: _category,
        sortBy: _sortBy,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

    Future<void> fetchAllNews({bool preventLoading = true}) async {
    _isLoading = preventLoading;
    _error = null;
    notifyListeners();

    try {
      _allNews = await _controller.fetchAllNews(
        keyword: _keyword,
        category: _category,
        sortBy: _sortBy,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSavedNews() async {
    _savedNews = await _controller.fetchSavedNews(order: _order);
    notifyListeners();
  }

  Future<void> sortSavedNews() async {
    _order = _order == 'DESC' ? 'ASC' : 'DESC';
    _savedNews = await _controller.fetchSavedNews(order: _order);
    notifyListeners();
  }
}
