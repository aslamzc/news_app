import 'package:flutter/material.dart';
import 'package:news/providers/home_provider.dart';
import 'package:provider/provider.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

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
            provider.toggleTheme();
            Navigator.pop(context);
          },
        ),
        const ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
        ),
        const ListTile(
          leading: Icon(Icons.archive),
          title: Text('Archive'),
        ),
      ]),
    );
  }
}
