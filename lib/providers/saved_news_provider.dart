import 'package:flutter/material.dart';
import 'package:news/models/news.dart';

class SavedNewsProvider with ChangeNotifier {


  String _news = "fdfdfdfdfdf";
  String get news => _news;

  void setNews(String news) {
    _news = news;
    notifyListeners();
  }
}
