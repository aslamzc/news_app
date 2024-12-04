import 'package:flutter/material.dart';
import 'package:news/providers/home_provider.dart';
import 'package:news/views/widgets/left_menu.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const LeftMenu(),
      body: homeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : homeProvider.error != null
              ? Center(child: Text('Error: ${homeProvider.error}'))
              : ListView.builder(
                  itemCount: homeProvider.news.length,
                  itemBuilder: (context, index) {
                    final news = homeProvider.news[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 news.author,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Description $index',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Published at ${DateTime.now().toString()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            homeProvider.fetchUsers(), // Fetch data without setState
        child: Icon(Icons.refresh),
      ),
    );
  }
}
