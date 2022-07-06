import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imic_api_moviedb/abstract/movie_item.dart';
import 'package:imic_api_moviedb/bloc/movie_bloc.dart';
import 'package:imic_api_moviedb/bloc/movie_state.dart';
import 'package:imic_api_moviedb/service/movie_api_provider.dart';
import 'package:imic_api_moviedb/view/movie_cardview_item.dart';
import 'package:imic_api_moviedb/view/movie_tag_view.dart';

import 'bloc/movie_event.dart';
import 'model/movie.dart';
import 'view/movie_favorite_view.dart';
import 'view/movie_item_view.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  MovieBloc _movieBloc = MovieBloc();
  MovieApiProvider api=MovieApiProvider();
  String dropdownvalue = 'Upcoming';
  var items = [
    'Upcoming',
    'Popular',
    'Now Playing',
    'Top Rating',
  ];
  //var movieBox=await Hive.openBox<Movie>('MovieBox');
  @override
  void initState() {
    //initialize();
    _movieBloc.add(GetMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          DropdownButton(
            // Initial Value
              value: dropdownvalue,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue){
                setState(() {
                  dropdownvalue = newValue!;
                  _movieBloc.add(GetMoviesByCategory(newValue));
                });
              }),
        ],
      ),
      //body:_buildHomeScreenBody(context,_movieList),
      body: _buildBody(),
      //body: Container(child: Text(data),),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Container(
        child: BlocProvider(
          create: (_) => _movieBloc,
          child: BlocListener<MovieBloc, MovieState>(
            listener: (context, state) {
              ///check state is friend error
              if (state is MovieError) {
                ///show snack bar message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieInitial) {
                    return _buildLoading();
                  } else if (state is MovieLoading) {
                    return _buildLoading();
                  } else if (state is MovieLoaded) {
                    return _buildHomeScreenBody(context,
                         state.movieList);
                  } else if (state is MovieError) {
                    return Container();
                  } else {
                    return Container();
                  }
                } //builder
            ),
          ),
        )
    );
  }

  Widget _buildHomeScreenBody(BuildContext context,List<Movie>_movieList) {
    final movies = List<MovieItem>.generate(_movieList.length, (index) {
      final item = _movieList[index];
      return MovieCardViewItem(
          item.id, item.title, item.voteAverage, item.releaseDate,
          item.overview, item.posterPath);
    });
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          for (var item in movies) MovieItemView(movieItem: item),
        ],
      ),
    );
  }


  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tag),
          label: 'Tag',
        )
      ],
      currentIndex: 0,
      onTap: (int index){
        if(index==1){
          MaterialPageRoute route = MaterialPageRoute(
              builder: (_) => const FavoriteMovieView());
          Navigator.push(context, route);
        }else if(index==2){
          MaterialPageRoute route = MaterialPageRoute(
              builder: (_) => const TaggedMovieView());
          Navigator.push(context, route);
        }
      },
    );
  }
}





