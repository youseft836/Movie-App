class ApiRoutes {
  static String popular(int page, {String lang = "en"}) => "popular?language=$lang&page=$page";
  static String playingNow(int page, {String lang = "en"}) => "now_playing?language=$lang&page=$page";
  static String moviesDetails(int id) => "$id";
  static String movieCast(int id) => "$id/credits";
  static String movieVideo(int id) => "$id/videos";
}