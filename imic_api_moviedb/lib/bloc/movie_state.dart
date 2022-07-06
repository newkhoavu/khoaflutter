import 'package:equatable/equatable.dart';
import 'package:imic_api_moviedb/model/movie.dart';


abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movieList;
  const MovieLoaded(this.movieList);
}

class MovieError extends MovieState {
  final String? message;
  const MovieError(this.message);
}