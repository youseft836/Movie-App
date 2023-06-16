import 'package:flutter/material.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movie_details_response.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movies_list_response.dart';
import 'package:movies_app/src/features/movies/data/models/responses/movies_videos_list_response.dart';
import 'package:movies_app/src/features/movies/domain/use_cases/movie_usecase.dart';
import 'package:movies_app/src/services/service_locator/service_locator.dart';

import '../../data/models/responses/movie_actor_list_response.dart';

class MoviesManager with ChangeNotifier {
  bool loading = false;
  bool loadDetails = false;

  var moviesUsecase = serviceLocator<MovieUsecase>();

  MoviesListResponse? moviesListResponse;
  MovieDetailsResponse? movieDetailsResponse;
  MovieActorListResponse? movieActorListResponse;
  MoviesVideosListResponse? moviesVideosListResponse;

  void getPlayingNow() async {
    togglePlayingNowState();
    moviesListResponse = await moviesUsecase.getPlayingNow(1);
    togglePlayingNowState();
  }

  void getPopular() async {
    togglePlayingNowState();
    moviesListResponse = await moviesUsecase.getPopularMovies(1);
    togglePlayingNowState();
  }

  void getMoviesDetails(int movieId) async {
    toggleLoadDetailsState();
    movieDetailsResponse = await moviesUsecase.getMoviesDetails(movieId);
    movieActorListResponse = await moviesUsecase.getMovieActors(movieId);
    moviesVideosListResponse = await moviesUsecase.getMovieVideo(movieId);
    toggleLoadDetailsState();
  }

  void togglePlayingNowState() {
    loading = !loading;
    notifyListeners();
  }

  void toggleLoadDetailsState() {
    loadDetails = !loadDetails;
    notifyListeners();
  }
}