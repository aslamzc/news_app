import 'package:flutter/material.dart';
import 'package:news/providers/saved_news_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/views/news_view.dart';
import 'package:news/views/widgets/left_menu.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<SavedNewsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsProvider.fetchSavedNews();
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Saved News',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        drawer: const LeftMenu(),
        body: RefreshIndicator(
          onRefresh: () async {
            await newsProvider.fetchSavedNews();
          },
          child: newsProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : newsProvider.error != null
                  ? Center(child: Text('Error: ${newsProvider.error}'))
                  : newsProvider.savedNews.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper,
                              size: 100,
                              color: themeProvider.isDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0),
                                child: Text(
                                  'No saved news found',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        ))
                      : ListView.builder(
                          itemCount: newsProvider.savedNews.length,
                          itemBuilder: (context, index) {
                            final news = newsProvider.savedNews[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              child: Card(
                                margin: const EdgeInsets.all(0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (news.urlToImage != null)
                                        Stack(
                                          children: [
                                            Image.network(
                                              news.urlToImage!,
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black
                                                          .withOpacity(0.7),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 12),
                                      Text(
                                        news.title,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        news.description,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Published At: ${DateFormat('dd MMM yyyy').format(news.publishedAt!)}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Roboto',
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsView(
                                                    news: news,
                                                    savedButton: false,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.visibility,
                                                  color:
                                                      themeProvider.isDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  'View',
                                                  style: TextStyle(
                                                    color: themeProvider
                                                            .isDarkTheme
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await newsProvider.sortSavedNews();
          },
          backgroundColor: themeProvider.isDarkTheme
              ? const Color(0xFF212121)
              : const Color(0xFFE5E5E5),
          child: Icon(Icons.sort,
              color: themeProvider.isDarkTheme ? Colors.white : Colors.black),
        ));
  }
}
