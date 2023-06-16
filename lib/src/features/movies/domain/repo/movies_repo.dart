import 'package:movies_app/src/features/movies/data/models/responses/movies_videos_list_response.dart';

import '../../data/models/responses/movie_actor_list_response.dart';
import '../../data/models/responses/movie_details_response.dart';
import '../../data/models/responses/movies_list_response.dart';

abstract class MovieRepo {
  Future<MoviesListResponse?> getPlayingNow(int page, {String lang = "en"});
  Future<MoviesListResponse?> getPopularMovies(int page, {String lang = "en"});
  Future<MovieDetailsResponse?> getMoviesDetails(int id);
  Future<MovieActorListResponse?> getMovieActors(int id);
  Future<MoviesVideosListResponse?> getMovieVideo(int id);
}