import 'package:flutter/material.dart';
import 'package:news/providers/home_provider.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:news/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
      home: const HomeView(),
      theme: themeProvider.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
