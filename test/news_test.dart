import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/models/news.dart';

void main(){
  group('News Screen', (){
    test("fetch news", () async {
      final apiKey = 'f49c3471cdee47308559978ea6fe74de';
      final url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey';
      final response = http.get(url);
      
      expect(response, isNotNull);
    });

    test("json decode", () async {
      var response = await NewsController.fetchNews();
      var jsonResponse = json.decode(response.body);
      final news = News.fromJson(jsonResponse);
      final title = news.articles[0].source.name;

      expect(title, 'BBC News');
      expect(news, isNotNull);
      expect(response, isNotNull);
    });
  });
}