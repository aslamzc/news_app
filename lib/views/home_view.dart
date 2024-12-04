import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/views/widgets/left_menu.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Headlines',
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
          await newsProvider.fetchNews(preventLoading: false);
        },
        child: newsProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : newsProvider.error != null
                ? Center(child: Text('Error: ${newsProvider.error}'))
                : ListView.builder(
                    itemCount: newsProvider.news.length,
                    itemBuilder: (context, index) {
                      final news = newsProvider.news[index];
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
                                                Colors.black.withOpacity(0.7),
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
                                    Text(
                                      DateFormat('dd MMM yyyy')
                                          .format(news.publishedAt),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'View',
                                        style: TextStyle(
                                          color: themeProvider.isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              final TextEditingController _controller = TextEditingController();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            prefixIcon: Icon(Icons.category),
                          ),
                          value: 'General',
                          style: TextStyle(
                              color: themeProvider.isDarkTheme
                                  ? Colors.white
                                  : Colors.black),
                          onChanged: (String? newValue) {},
                          items: <String>['Health', 'Sports', 'General']
                              .map<DropdownMenuItem<String>>((String value) {
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
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Sort By',
                            prefixIcon: Icon(Icons.sort),
                          ),
                          value: 'Popularity',
                          style: TextStyle(
                              color: themeProvider.isDarkTheme
                                  ? Colors.white
                                  : Colors.black),
                          onChanged: (String? newValue) {},
                          items: <String>[
                            'Health',
                            'Sports',
                            'General',
                            'Popularity'
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
                          onPressed: () {},
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
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
