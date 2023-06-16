import 'package:get_it/get_it.dart';
import 'package:movies_app/src/features/movies/data/repo_impl/movies_repo_impl.dart';
import 'package:movies_app/src/features/movies/domain/repo/movies_repo.dart';
import 'package:movies_app/src/features/movies/domain/use_cases/movie_usecase.dart';
import 'package:movies_app/src/services/network/network_connection_service.dart';

import '../http/http_service.dart';

GetIt serviceLocator = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {

    // services
    serviceLocator.registerLazySingleton<HttpService>(() => HttpService());
    serviceLocator.registerLazySingleton<NetworkConnectionService>(() => NetworkConnectionService());

    // repo and repo impl
    serviceLocator.registerLazySingleton<MovieRepo>(() => MoviesRepoImpl());

    // usecase
    serviceLocator.registerLazySingleton<MovieUsecase>(() => MovieUsecase(serviceLocator()));
  }
}
