import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class List extends StatefulWidget {
  final news;
  List({Key key, this.news}) : super(key: key);
  
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  _goToDetails(article){
    Navigator.pushNamed(context, '/details', arguments: article);
  }

  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final listWidth = MediaQuery.of(context).size.width;
    var listHeight = 0.0;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait){
      listHeight = deviceHeight - (deviceHeight * 0.25);
    } else {
      listHeight = deviceHeight - (deviceHeight * 0.4);
    }

    return 
    widget.news == null ?
    CircularProgressIndicator() :
    Container(
      width: listWidth,
      height: listHeight,
      child: ListView.builder(
        itemCount: widget.news.totalResults,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              onTap: () {_goToDetails(widget.news.articles[index]);},
              leading: CachedNetworkImage(
                imageUrl: widget.news.articles[index].urlToImage == null ? 'No image available' : widget.news.articles[index].urlToImage,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              title: Text(widget.news.articles[index].title == null ? 'No image available' : widget.news.articles[index].title),
              ),
            );
          }   
        ),
      );
    }
  }