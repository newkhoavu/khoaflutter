import '../model/movie.dart';

abstract class MovieService{
  Future<List<Movie>> getMovieList();
  Future<List<Movie>> getMoviesByCategory(String catagory);
}