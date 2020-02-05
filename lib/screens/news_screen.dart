import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/screens/favorites_screen.dart';
import 'package:newsapp/widgets/top_headlines.dart';

class NewsScreen extends StatefulWidget {
  final news;
  NewsScreen({Key key, this.news}) : super(key: key);
  
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  News _news;
  String _title;

  _goToFavorites() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => FavoritesScreen()
        )
      );
  }

  _fetchData() async {
    var response = await NewsController.fetchNews();
    var jsonResponse = json.decode(response.body);
    setState(() {
      this._news = new News.fromJson(jsonResponse);
      this._title = this._news.articles[0].source.name;  
    });
  }

  void initState(){
    super.initState();
    _fetchData();
  }

  Widget build(BuildContext context){
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final rowHeight = 40.0;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(this._title == null ? 'Loading...' : this._title),
        ),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: rowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Top Headlines'),
                  OutlineButton(
                    child: Text('Go to favorites'),
                    onPressed: () {_goToFavorites();}
                    )
                  ],
                ),
              ),
              List(news: this._news)
            ],
          ),
        ),
      );
    }
  }