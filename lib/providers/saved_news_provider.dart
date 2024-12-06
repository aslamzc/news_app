import 'package:flutter/material.dart';

class SavedNewsProvider with ChangeNotifier {
  String _news = "test";
  String get news => _news;

  void setNews(String news) {
    _news = news;
    notifyListeners();
  }
}
