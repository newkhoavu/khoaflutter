import 'package:flutter/material.dart';
import 'package:imic_api_moviedb/abstract/movie_item.dart';
import '../model/movie.dart';
import 'movie_detail_view.dart';
class MovieCardViewItem extends MovieItem{
  int id;
  String title;
  double voteAverage;
  String releaseDate;
  String overview;
  String posterPath;
  final String imgPath='https://image.tmdb.org/t/p/w500/';
  MovieCardViewItem(this.id, this.title, this.voteAverage, this.releaseDate, this.overview, this.posterPath);

  @override
  Widget buildHeader(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline5,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    String path;
    if (posterPath != null) {
      path = imgPath + posterPath;
    } else {
      path =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    Movie movie=Movie(id: id, title: title, voteAverage: voteAverage, releaseDate: releaseDate, overview: overview, posterPath: posterPath);

    return Expanded(
        child: InkWell(
          onTap: (){
            MaterialPageRoute route = MaterialPageRoute(
                builder: (_) => MovieDetail(movie));
            Navigator.push(context, route);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  overview,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                ),
              ),
              Image.network(path, height: 270,),
              const SizedBox(height: 4),
              const Divider(
                color: Colors.grey,
                height: 1,
              )
            ],
          ),
        ));
  }

  @override
  Widget buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(children: [],)
            ],
          ),
        ],
      ),
    );
  }
}
