import 'package:bloc/bloc.dart';
import 'package:imic_api_moviedb/bloc/movie_event.dart';
import 'package:imic_api_moviedb/service/movie_api_repositiory.dart';
import 'movie_state.dart';



class MovieBloc extends Bloc<MovieEvent, MovieState> {
 
  MovieBloc() : super(MovieInitial()) {

    final MovieApiRepository apiRepository = MovieApiRepository();

    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList = await apiRepository.getMovieList();
        emit(MovieLoaded(mList));

      } on NetworkError {
        emit(const MovieError("Failed to fetch data. is your device online?"));
      }
    });

    on<GetMoviesByCategory>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList = await apiRepository.getMoviesByCategory(event.catagory);
        emit(MovieLoaded(mList));

      } on NetworkError {
        emit(const MovieError("Failed to fetch data. is your device online?"));
      }
    });
  }
}