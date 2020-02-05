import 'package:flutter/material.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List _articles;
  NewsController newsController;
  bool _loading;

  _goToDetails(article){
    Navigator.pushNamed(context, '/details', arguments: article);
  }

  _goBack(){
    Navigator.pop(context);
  }

  _fetchData() async {
    _articles = await NewsController.getInstance().getAll();

    setState(() {
     _loading = false; 
    });
  }

  void initState(){
    super.initState();
    _loading = true;
  }
  
  Widget build(BuildContext context){    
    this._fetchData();

    final deviceWidth = MediaQuery.of(context).size.width - 25;
    final deviceHeight = MediaQuery.of(context).size.height - 50;
    final listWidth = MediaQuery.of(context).size.width;
    var listHeight = 0.0;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait){
      listHeight = deviceHeight - (deviceHeight * 0.25);
    } else {
      listHeight = deviceHeight - (deviceHeight * 0.4);
    }

    return Scaffold(
      backgroundColor: Colors.black45,
        body: new Container(
          margin: EdgeInsets.only(top: 40, right: 20,),
          padding: EdgeInsets.all(10.0),
          color: Colors.white.withOpacity(0.9),
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Read your favorite news again!', style: TextStyle(color: Colors.blue, fontSize: 20.0), textAlign: TextAlign.center,),
              OutlineButton(
                child: Text('Or go back to recent headlines',),
                onPressed: () {_goBack();}
              ),
              _loading ? CircularProgressIndicator() :
              Container(
                width: listWidth,
                height: listHeight,
                child: (_articles == null || _articles.isEmpty) ? 
                Text("You don't have any favorite news yet!", textAlign: TextAlign.center) :
                ListView.builder(
                  itemCount: _articles.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        onTap: () {_goToDetails(_articles[index]);},
                        leading: CachedNetworkImage(
                          imageUrl: _articles[index].urlToImage == null ? 'No image available' : _articles[index].urlToImage,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        title: Text(_articles[index].title == null ? 'No image available' : _articles[index].title),
                        ),
                      );
                    }   
                  ),
              )
            ],
          ),
        ),
    );
  }
}