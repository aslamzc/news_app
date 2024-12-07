import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/repositories/news_repository.dart';
import 'package:news/views/news_view.dart';
import 'package:news/views/widgets/left_menu.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AllNewsView extends StatelessWidget {
  AllNewsView({super.key});
  final NewsRepository _newsRepository = NewsRepository.instance;
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News Discovery ',
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
          await newsProvider.fetchAllNews(preventLoading: false);
        },
        child: newsProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : newsProvider.error != null
                ? Center(child: Text('Error: ${newsProvider.error}'))
                : newsProvider.allNews.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 100,
                            color: themeProvider.isDarkTheme
                                ? Colors.white
                                : Colors.black,
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0),
                              child: Text(
                                  'Search through millions of articles from over 150,000 large and small news sources and blogs.',
                                  textAlign: TextAlign.center)),
                        ],
                      ))
                    : ListView.builder(
                        itemCount: newsProvider.allNews.length,
                        itemBuilder: (context, index) {
                          final news = newsProvider.allNews[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: Card(
                              margin: const EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    const SizedBox(height: 12),
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
                                            const SizedBox(width: 4),
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
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            await _newsRepository.addNews({
                                              "title": news.title,
                                              "description": news.description,
                                              "content": news.content,
                                              "author": news.author,
                                              "published_at":
                                                  news.publishedAt.toString(),
                                              "urlToImage": news.urlToImage,
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'News saved for later'),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.bookmark,
                                                color: themeProvider.isDarkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Save',
                                                style: TextStyle(
                                                  color:
                                                      themeProvider.isDarkTheme
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => NewsView(
                                                    news: news,
                                                    deleteButton: false),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: themeProvider.isDarkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'View',
                                                style: TextStyle(
                                                  color:
                                                      themeProvider.isDarkTheme
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
        backgroundColor: themeProvider.isDarkTheme
            ? const Color(0xFF212121)
            : const Color(0xFFE5E5E5),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              final TextEditingController _controller =
                  TextEditingController(text: newsProvider.keyword);
              return Consumer<NewsProvider>(
                builder: (context, newsProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      height: 450,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _controller,
                            onChanged: (value) {
                              newsProvider.setKeyword(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _controller.clear();
                                  newsProvider.setKeyword('');
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Sort By',
                                prefixIcon: Icon(Icons.sort),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    newsProvider.setCategory(null);
                                  },
                                ),
                              ),
                              value: newsProvider.sortBy,
                              style: TextStyle(
                                  color: themeProvider.isDarkTheme
                                      ? Colors.white
                                      : Colors.black),
                              onChanged: (String? newValue) {
                                newsProvider.setSortBy(newValue);
                              },
                              items: <String>[
                                'popularity',
                                'relevancy',
                                'publishedAt',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                newsProvider.fetchAllNews();
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  width: 1.0,
                                  color: themeProvider.isDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: themeProvider.isDarkTheme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.close_rounded,
                                color: themeProvider.isDarkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
