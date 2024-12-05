import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news.dart';

class NewsView extends StatelessWidget {
  final News news;
  const NewsView({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
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
            const SizedBox(height: 12),
            // if (news.content != null)
            Text(
              news.content,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Author: ${news.author}",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                Text(
                  "Published At: ${DateFormat('dd-MM-yyyy').format(news.publishedAt)}",
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
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('News saved for later'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bookmark),
                  label: const Text('Save for later'),
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
