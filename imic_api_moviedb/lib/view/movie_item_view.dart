import 'package:flutter/material.dart';

import '../abstract/movie_item.dart';


class MovieItemView extends StatelessWidget {
  final MovieItem movieItem;
  const MovieItemView({Key? key, required this.movieItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 450.0,
        child: Column(children: <Widget>[
          const SizedBox(height: 10),
          movieItem.buildHeader(context),
          const SizedBox(height: 10),
          movieItem.buildBody(context),
          const SizedBox(height: 10),
          SizedBox(
            height: 34,
            child: movieItem.buildFooter(context),
          ),
        ]),
      );
  }
}
