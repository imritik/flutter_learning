import 'package:flurest/networking/api_base_helper.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/apiKey.dart';

class MovieDetailRepository {
  final String _apiKey = apiKey;

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Movie> fetchMovieDetail(String selectedMovie) async {
    final response = await _helper.get(selectedMovie);
    return Movie.fromJson(response);
  }
}
