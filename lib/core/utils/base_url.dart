class BaseUrl {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'aec430914e97e1e5105c8480777cda9a';
  static const String language = 'en-US';
  static const String urlPopularMovies =
      '$baseUrl/movie/popular?api_key=$apiKey&language=$language&page=1';
  static const String urlGenres =
      '$baseUrl/genre/movie/list?api_key=$apiKey&language=$language';
  static String urlPosterPath(String path) =>
      'http://image.tmdb.org/t/p/w185$path';
}
