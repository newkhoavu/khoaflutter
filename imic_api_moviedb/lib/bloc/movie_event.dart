import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieList extends MovieEvent {
}

class GetMoviesByCategory extends MovieEvent {
  String catagory;
  GetMoviesByCategory(this.catagory);
}


