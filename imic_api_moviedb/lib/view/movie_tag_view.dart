import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/movie_localdb.dart';

class TaggedMovieView extends StatefulWidget {
  const TaggedMovieView({Key? key}) : super(key: key);

  @override
  State<TaggedMovieView> createState() => _TaggedMovieViewState();
}

class _TaggedMovieViewState extends State<TaggedMovieView> {
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
          title: Text('My Tagged Movies List'),
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
                        ],
                      )
                  ));
            }));
  }

  Future initialize() async{
    var box=await Hive.openBox<MovieLocalDB>('Favorites');
    lst=box.values.where((items) => items.isTag == true)
        .toList();
    await Hive.close();
    setState((){
      lst=lst;
      count=lst.length;
    });
  }
}
