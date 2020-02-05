import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/models/articles.dart';

void main () {
  final NewsController _instance = NewsController.getInstance();

  group('Favorites Storage', (){
    test('Instance DB', () {
      expect(_instance.db, isNotNull);
    });

    test('Save Data', () {
      Articles article = new Articles(
        title: 'Test',
        content: 'Content of the article',
        description: 'Description available',
        urlToImage: 'http://www.google.com'
      );
      var response = _instance.save(article);
      expect(response, isNotNull);
    });

    test('Read Data', () {
      expect(_instance.getAll(), isNotNull);
    });

    test('Delete Data', () {
      var response = _instance.delete('Test');
      expect(response, isNotNull);
    });
  });
}