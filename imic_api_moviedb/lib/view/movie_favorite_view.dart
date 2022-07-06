import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/movie_localdb.dart';

class FavoriteMovieView extends StatefulWidget {
  const FavoriteMovieView({Key? key}) : super(key: key);

  @override
  State<FavoriteMovieView> createState() => _FavoriteMovieViewState();
}

class _FavoriteMovieViewState extends State<FavoriteMovieView> {
  int count =0;
  List<MovieLocalDB>lst=[];
  final String iconBase='https://image.tmdb.org/t/p/w92/';
  final String defaultImage='https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  @override
  void initState(){
    initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorited Movies List'),
      ),
        body: ListView.builder(
            itemCount: (this.count == null) ? 0 : this.count,
            itemBuilder: (BuildContext context, int position) {
              image = NetworkImage(iconBase + lst[position].posterPath);
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: image,
                      ),
                      title: Text(lst[position].title),
                      subtitle: Column(
                        children:<Widget> [
                          Text('Title: '+lst[position].title),
                          Text('Overview: '+lst[position].overview),
                          TextButton.icon(
                              onPressed: (){
                                _updateMovie(position,lst[position]);
                                initialize();
                                Popup(context, 'tagged');
                              },
                              icon: const Icon(Icons.tag),
                              label: const Text('Tag to your movies list'),
                          ),
                          TextButton.icon(
                              onPressed: (){
                                _deleteMovie(position);
                                initialize();
                                Popup(context, 'removed');
                              },
                              icon: const Icon(Icons.delete),
                              label: const Text('Delete the movie from your favorite list'))
                        ],
                      )
                  ));
            }));
  }

  Future initialize() async{
    var box=await Hive.openBox<MovieLocalDB>('Favorites');
    lst=box.values.toList();
    await Hive.close();
    setState((){
      lst=lst;
      count=lst.length;
    });
  }

  Future<void> _deleteMovie(int index) async{
    var box=await Hive.openBox<MovieLocalDB>('Favorites');
    await box.deleteAt(index);
    await Hive.close();
  }

  Future<void> _updateMovie(int index, MovieLocalDB updateItem) async{
    var box=await Hive.openBox<MovieLocalDB>('Favorites');
    updateItem.isTag=true;
    await box.putAt(index,updateItem);
    await Hive.close();
  }
  void Popup(BuildContext context, String mes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text('The movie has been $mes from your favorite list'),
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
