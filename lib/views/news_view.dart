import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/news_repository.dart';

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
                Text(
                  "Author: ${news.author}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
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
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (savedButton) const SizedBox(height: 12),
                if (savedButton)
                  OutlinedButton.icon(
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
                    icon: const Icon(Icons.bookmark),
                    label: const Text('Save for later'),
                  ),
                if (deleteButton) const SizedBox(height: 12),
                if (deleteButton)
                  OutlinedButton.icon(
                    onPressed: () async {
                      await _newsRepository.deleteNews(news.id);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
