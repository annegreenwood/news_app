import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/models/articles.dart';

class DetailsScreen extends StatefulWidget {
  final String title;

  DetailsScreen({Key key, this.title}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Articles args;
  bool _isFavorite = false;
  var _favorite;
  bool _checked = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _goBack(){
    Navigator.pop(context);
  }

 void _showToast(titulo) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: new Text(titulo),
        action: SnackBarAction(
            label: 'Ok', onPressed: _scaffoldKey.currentState.hideCurrentSnackBar),
      ),
    );
  }

  _controlFav(fav, article, title) async {
    _favorite = await NewsController.getInstance().getFirst(args.title);

    if(_favorite == null){
      _showToast('Favorite Added');
      NewsController.getInstance().save(article);
    }
    else{
      _showToast('Favorite Removed');
      NewsController.getInstance().delete(title);
    }
  }

  _checkFavorite() async {
    if(args.title == null) return;

    _favorite = await NewsController.getInstance().getFirst(args.title);
    if(this.mounted && _favorite != null){
      setState(() {
       _isFavorite = true; 
      });
    }

    setState(() {
     _checked = true; 
    });
  }

  Widget build(BuildContext context){
    args = ModalRoute.of(context).settings.arguments;

    if(!_checked){
      _checkFavorite();
    }

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {_goBack();}
          ),
          actions: <Widget>[
            IconButton(
              tooltip: _isFavorite ? 'Remove from favorites' : 'Save to favorites',
              onPressed: () {
                setState(() {
                  _isFavorite ^= true;
                });
                _controlFav(_isFavorite, args, args.title);
              },
              icon: Icon(
                _isFavorite ? Icons.star : Icons.star_border,
                semanticLabel: _isFavorite ? 'Save to favorites' : 'Remove from favorites',
              )
            )
          ],
      ),
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        child: SingleChildScrollView(             
          child: Column(
            children: <Widget>[ 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Text(args.title == null ? 'No title available': args.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0), textAlign: TextAlign.justify,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Text(args.description == null ? 'No description available' : args.description, style: TextStyle(fontSize: 16.0, color: Colors.black54), textAlign: TextAlign.justify,),
              ),
              CachedNetworkImage(
                imageUrl: args.urlToImage == null ? 'No image available' : args.urlToImage,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Text(args.content == null ? 'No content available' : args.content, style: TextStyle(fontSize: 18.0), textAlign: TextAlign.justify,),
              )
            ],
          ),
        )
      ),
    );
  }
}