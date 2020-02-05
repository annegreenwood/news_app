import 'package:http/http.dart' as http;
import 'package:newsapp/helpers/database_helper.dart';
import 'package:newsapp/models/articles.dart';
import 'dart:core';

class NewsController extends HelperBase<Articles>{
  
  static final NewsController _instance = NewsController.getInstance();

  factory NewsController() => _instance;
  NewsController.getInstance();

  @override
  Future<int> delete(String title) {
    return db.then((database) async {
      return await database
          .delete('Articles', where: "title = ?", whereArgs: [title]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
    List listMap = await database.rawQuery("SELECT * FROM Articles");
    List<Articles> lista = List();
    for (Map m in listMap) {
      lista.add(Articles.fromMap(m));
    }
    return lista;
  });

   @override
  Future<Articles> getFirst(String title) async => db.then((database) async {
    List<Map> maps = await database.query('Articles',
        columns: [
          'title',
          'urlToImage',
          'description',
          'content',
        ],
        where: "title = ?",
        whereArgs: [title]);

    if (maps.length > 0) {
      return Articles.fromMap(maps.first);
    } else {
      return null;
    }
  });

  @override
  Future<Articles> save(Articles article) async {
    db.then((database) async {
      await database.insert('Articles', article.toMap());
    });
    return article;
  }
  
  static Future fetchNews() {
    String apiKey = 'f49c3471cdee47308559978ea6fe74de';
    final response = http.get('https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey');
    return response;
  }  
}