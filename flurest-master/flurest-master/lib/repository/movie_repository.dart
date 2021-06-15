import 'package:flurest/networking/api_base_helper.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/apiKey.dart';

class MovieRepository {
  final String _apiKey = apiKey;

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList(String url) async {
    final response = await _helper.get(url);
    return MovieResponse.fromJson(response).results;
  }

  Future<bool> addMovie(String url, Movie movie) async {
    print("in repository  $movie");
    var map = movie.toMap();
    print("after toJson  $map");
    final response = await _helper.post(url, map);
    return response;
  }
}
