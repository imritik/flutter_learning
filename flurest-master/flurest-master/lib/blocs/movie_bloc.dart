import 'dart:async';

import 'package:flurest/networking/api_response.dart';
import 'package:flurest/repository/movie_repository.dart';

import 'package:flurest/models/movie_response.dart';
import 'package:flurest/constants/url.dart' as Constants;

class MovieBloc {
  MovieRepository _movieRepository;

  StreamController _movieListController;

  StreamController _addMovieController;

  StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
      _movieListController.sink;

  Stream<ApiResponse<List<Movie>>> get movieListStream =>
      _movieListController.stream;

  //post movie
  StreamSink<ApiResponse<bool>> get movieAddSink => _addMovieController.sink;

  Stream<ApiResponse<bool>> get movieAddStream => _addMovieController.stream;

  // it provides a sink property to add data(events, variables, network requests)
  //to the stream and also a stream property where you either transform data or
  //listen to the data, errors and done events added to the stream.

  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _addMovieController = StreamController<ApiResponse<bool>>.broadcast();
    _movieRepository = MovieRepository();
    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching Contacts'));
    try {
      List<Movie> movies =
          await _movieRepository.fetchMovieList(Constants.BASE_URL);
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  addMovie(Movie movie) async {
    print("in bloc $movie");
    movieAddSink.add(ApiResponse.loading('Adding'));
    try {
      bool isMovieAdded =
          await _movieRepository.addMovie(Constants.ADD_MOVIE_URL, movie);
      movieAddSink.add(ApiResponse.completed(isMovieAdded));
    } catch (e) {
      movieAddSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  updateMovie(Movie movie) async {
    print("in bloc update");
    await _movieRepository.updateMovie(Constants.ADD_MOVIE_URL, movie);
  }

  deleteMovie(int id) async {
    await _movieRepository
        .deleteMovie(Constants.DELETE_MOVIE_URL + id.toString());
  }

  dispose() {
    _movieListController?.close();
  }
}
