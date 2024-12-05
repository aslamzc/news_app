import 'package:flutter/material.dart';
import 'package:news/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: ListView(children: [
        const ListTile(
          title: Text(
            'News App',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SwitchListTile(
          title: const Text('Dark Theme'),
          value: Theme.of(context).brightness == Brightness.dark,
          activeColor: const Color.fromRGBO(166, 174, 191, 1),
          onChanged: (value) {
            themeProvider.toggleTheme();
            Navigator.pop(context);
          },
        ),
        const ListTile(
          leading: Icon(Icons.newspaper),
          title: Text(
            'Top Headlines',
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.newspaper),
          title: Text(
            'All news',
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.bookmark),
          title: Text(
            'Saved News',
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ]),
    );
  }
}
