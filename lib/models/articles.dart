import 'package:newsapp/models/source.dart';

class Articles {
  int id;
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles(
      {
      this.id,
      this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromMap(Map map){
    id = map['id'];
    author = map['author'];
    title = map['title'];
    description = map['description'];
    urlToImage = map['urlToImage'];
    content = map['content'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'content': content,
      'description': description,
      'urlToImage': urlToImage,
    };

    if(id != null){
      map['id'] = id;
    }
    return map;
  }

  Articles.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

