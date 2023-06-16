import 'package:movies_app/src/features/movies/data/models/responses/movie_actor_list_response.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movies_videos_list_response.dart';
import 'package:movies_app/src/features/movies/domain/repo/movies_repo.dart';

import '../../data/models/responses/movie_details_response.dart';
import '../../data/models/responses/movies_list_response.dart';

class MovieUsecase {
  final MovieRepo movieRepo;

  MovieUsecase(this.movieRepo);

  Future<MoviesListResponse?> getPlayingNow(int page, {String lang = "en"}) async {
    return await movieRepo.getPlayingNow(page, lang: lang);
  }

  Future<MoviesListResponse?> getPopularMovies(int page, {String lang = "en"}) async {
    return await movieRepo.getPopularMovies(page, lang: lang);
  }

  Future<MovieDetailsResponse?> getMoviesDetails(int id) async {
    return await movieRepo.getMoviesDetails(id);
  }

  Future<MovieActorListResponse?> getMovieActors(int id) async {
    return await movieRepo.getMovieActors(id);
  }

  Future<MoviesVideosListResponse?> getMovieVideo(int id) async {
    return await movieRepo.getMovieVideo(id);
  }
}
