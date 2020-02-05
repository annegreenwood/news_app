import 'package:flutter/material.dart';
import 'package:newsapp/screens/details_screen.dart';
import 'package:newsapp/screens/favorites_screen.dart';
import 'package:newsapp/screens/fingerprint_authorization_screen.dart';
import 'package:newsapp/screens/news_screen.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
        routes: {
            '/': (context) => FingerprintScreen(),
            '/newsscreen': (context) => NewsScreen(),
            '/favorites': (context) => FavoritesScreen(),
            '/details': (context) => DetailsScreen(),
        },
    );
  }
}