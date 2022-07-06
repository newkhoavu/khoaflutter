import 'package:imic_api_moviedb/model/movie.dart';
import 'package:imic_api_moviedb/service/movie_api_provider.dart';

class MovieApiRepository{
  final _provider=MovieApiProvider();
  Future<List<Movie>> getMovieList(){
    return _provider.getMovieList();
  }
  Future<List<Movie>> getMoviesByCategory(String category){
    return _provider.getMoviesByCategory(category);
  }
}
class NetworkError extends Error {

}