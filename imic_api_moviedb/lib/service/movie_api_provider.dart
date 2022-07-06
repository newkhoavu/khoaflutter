import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:imic_api_moviedb/abstract/movie_service.dart';
import 'package:imic_api_moviedb/model/movie.dart';

class MovieApiProvider extends MovieService{
  final String urlKey='api_key=d94fab016ea4e0be19a0ceda532e5455';
  final String urlBase='https://api.themoviedb.org/3/movie';
  final String urlUpcoming='/upcoming?';

  @override
  Future<List<Movie>> getMovieList() async {

    final String upcoming = urlBase + urlUpcoming + urlKey;
    final url = Uri.parse(upcoming);
    http.Response response = await http.get(url);
    String json = response.body.replaceAll("null", '""');
    Map<String, dynamic> mapJson = jsonDecode(json);

    if (response.statusCode == 200) {
      List<Movie> movieItems = (mapJson['results'] as List).map((itemMovie) => Movie.fromJson(itemMovie)).toList();
      return movieItems;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
  @override
  Future<List<Movie>> getMoviesByCategory(String category) async {
    String urlCategory = '/upcoming?';
    switch (category){
      case 'Upcoming':{
        urlCategory='/upcoming?';
      }
      break;
      case 'Popular':{
        urlCategory='/popular?';
      }
      break;
      case 'Now Playing':{
        urlCategory='/now_playing?';
      }
      break;
      case 'Top Rating':{
        urlCategory='/top_rated?';
      }
      break;
    }
    final String upcoming = urlBase + urlCategory + urlKey;
    final url = Uri.parse(upcoming);
    http.Response response = await http.get(url);
    String json = response.body.replaceAll("null", '""');
    Map<String, dynamic> mapJson = jsonDecode(json);

    if (response.statusCode == 200) {
      List<Movie> movieItems = (mapJson['results'] as List).map((itemMovie) => Movie.fromJson(itemMovie)).toList();
      return movieItems;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
}