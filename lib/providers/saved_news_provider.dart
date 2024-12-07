import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/news.dart';

class SavedNewsProvider with ChangeNotifier {
  final Logger _logger = Logger();
  final NewsController _controller = NewsController();

  List<News> _savedNews = [];
  List<News> get savedNews => _savedNews;

  String _order = 'DESC';
  String get order => _order;

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchSavedNews() async {
    try {
      _savedNews = await _controller.fetchSavedNews(order: _order);
    } catch (e) {
      _logger.e(e);
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> sortSavedNews() async {
    try {
      _order = _order == 'DESC' ? 'ASC' : 'DESC';
      _savedNews = await _controller.fetchSavedNews(order: _order);
    } catch (e) {
      _logger.e(e);
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
