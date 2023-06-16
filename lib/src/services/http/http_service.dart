import 'package:dio/dio.dart';

class HttpService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3/movie/",
      connectTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
      followRedirects: false,
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZWNjYWMzYWE2NjkyNmIwODcyY2I2NmQ1NjQ2ZGJjYyIsInN1YiI6IjY0ODcwMTdiZTI3MjYwMDBlOGMxZTBjMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.HjAgMcHolGWkSzQS494ZY-Z11eFN7NiDJOHdvqqDEzY",
      },
    ),
  );
}
