import 'package:flutter/material.dart';
import 'package:news/providers/home_provider.dart';
import 'package:news/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return MaterialApp(
      home: const HomeView(),
      theme: provider.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
