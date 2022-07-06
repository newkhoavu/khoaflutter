import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/movie.dart';
import '../model/movie_localdb.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath='https://image.tmdb.org/t/p/w500/';
  MovieDetail(this.movie);


  @override
  Widget build(BuildContext context) {
    MovieLocalDB movieLocalDB=MovieLocalDB(movie.id.toString(), movie.title, movie.overview, movie.posterPath, false);
    String path;
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children:<Widget>[
              Container(
                padding: EdgeInsets.all(16),
                height: height/1.5,
                child: Image.network(path),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(movie.overview),
              ),
              Container(
                child: TextButton(
                  onPressed:(){
                    _addToFavorite(movieLocalDB);
                    Popup(context);
                  },
                  child: const Text('Add to Favorite List'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void>_addToFavorite(MovieLocalDB movieLocalDB) async {
    var box=await Hive.openBox<MovieLocalDB>('Favorites');
    var itemLists = box.values
        .where((items) => items.id == movieLocalDB.id)
        .toList();
    if (itemLists.isEmpty) {
      box.add(movieLocalDB);
    }
    await Hive.close();
  }

  void Popup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text('The movie has been added to your favorite list'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }
}
