import 'package:flutter/material.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/providers/saved_news_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/utils/locator.dart';
import 'package:news/views/home_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => SavedNewsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      home: HomeView(),
      theme: themeProvider.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
