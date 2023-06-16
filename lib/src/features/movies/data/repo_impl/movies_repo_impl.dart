import 'package:dio/dio.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movie_actor_list_response.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movies_list_response.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movies_videos_list_response.dart';
import 'package:movies_app/src/features/movies/domain/repo/movies_repo.dart';
import 'package:movies_app/src/services/http/api_routes.dart';
import 'package:movies_app/src/services/http/http_service.dart';
import 'package:movies_app/src/services/network/network_connection_service.dart';
import 'package:movies_app/src/services/service_locator/service_locator.dart';

import '../models/responses/movie_details_response.dart';

class MoviesRepoImpl implements MovieRepo {
  @override
  Future<MoviesListResponse?> getPlayingNow(int page, {String lang = "en"}) async {
    if (await serviceLocator<NetworkConnectionService>().hasConnection()) {
      var response = await serviceLocator<HttpService>().dio.get(ApiRoutes.playingNow(page, lang: lang));
      if (response.statusCode == 200) {
        return MoviesListResponse.fromJson(response.data);
      }
    }
    return null;
  }

  @override
  Future<MoviesListResponse?> getPopularMovies(int page, {String lang = "en"}) async {
    if (await serviceLocator<NetworkConnectionService>().hasConnection()) {
      var response = await serviceLocator<HttpService>().dio.get(ApiRoutes.popular(page, lang: lang));
      if (response.statusCode == 200) {
        return MoviesListResponse.fromJson(response.data);
      }
    }
    return null;
  }

  @override
  Future<MovieDetailsResponse?> getMoviesDetails(int id) async {
    if (await serviceLocator<NetworkConnectionService>().hasConnection()) {
      var response = await serviceLocator<HttpService>().dio.get(ApiRoutes.moviesDetails(id));
      if (response.statusCode == 200) {
        return MovieDetailsResponse.fromJson(response.data);
      }
    }
    return null;
  }

  @override
  Future<MovieActorListResponse?> getMovieActors(int id) async {
    if (await serviceLocator<NetworkConnectionService>().hasConnection()) {
      var response = await serviceLocator<HttpService>().dio.get(ApiRoutes.movieCast(id));
      if (response.statusCode == 200) {
        return MovieActorListResponse.fromJson(response.data);
      }
    }
    return null;
  }

  @override
  Future<MoviesVideosListResponse?> getMovieVideo(int id) async {
    if (await serviceLocator<NetworkConnectionService>().hasConnection()) {
      var response = await serviceLocator<HttpService>().dio.get(ApiRoutes.movieVideo(id));
      if (response.statusCode == 200) {
        return MoviesVideosListResponse.fromJson(response.data);
      }
    }
    return null;
  }
}
