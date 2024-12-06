import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/repositories/news_repository.dart';
import 'package:provider/provider.dart';

class NewsView extends StatelessWidget {
  final News news;
  final bool savedButton;
  final bool deleteButton;
  NewsView(
      {required this.news,
      this.savedButton = true,
      this.deleteButton = true,
      super.key});

  final NewsRepository _newsRepository = NewsRepository.instance;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (news.urlToImage != null)
              Image.network(
                news.urlToImage!,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 12),
            Text(
              news.title,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
            if (news.content != "") const SizedBox(height: 12),
            if (news.content != "")
              Text(
                news.content,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                ),
              ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (news.author != "")
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Author: ${news.author}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Published At: ${DateFormat('dd-MM-yyyy').format(news.publishedAt!)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (savedButton) const SizedBox(height: 12),
                if (savedButton)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: themeProvider.isDarkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    onPressed: () async {
                      await _newsRepository.addNews({
                        "title": news.title,
                        "description": news.description,
                        "content": news.content,
                        "author": news.author,
                        "published_at": news.publishedAt.toString(),
                        "urlToImage": news.urlToImage,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('News saved for later'),
                        ),
                      );
                    },
                    icon: Icon(Icons.bookmark,
                        color: themeProvider.isDarkTheme
                            ? Colors.white
                            : Colors.black),
                    label: Text('Save for later',
                        style: TextStyle(
                            color: themeProvider.isDarkTheme
                                ? Colors.white
                                : Colors.black)),
                  ),
                if (deleteButton) const SizedBox(height: 12),
                if (deleteButton)
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: themeProvider.isDarkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    onPressed: () async {
                      await _newsRepository.deleteNews(news.id);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete,
                        color: themeProvider.isDarkTheme
                            ? Colors.white
                            : Colors.black),
                    label: Text('Delete',
                        style: TextStyle(
                            color: themeProvider.isDarkTheme
                                ? Colors.white
                                : Colors.black)),
                  ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: themeProvider.isDarkTheme
                            ? Colors.white
                            : Colors.black),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back,
                      color: themeProvider.isDarkTheme
                          ? Colors.white
                          : Colors.black),
                  label: Text('Back',
                      style: TextStyle(
                          color: themeProvider.isDarkTheme
                              ? Colors.white
                              : Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
