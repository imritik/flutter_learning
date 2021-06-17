import 'package:flurest/blocs/movie_bloc.dart';
import 'package:flurest/blocs/movie_detail_bloc.dart';
import 'package:flurest/helpers/helper.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_response.dart';
import 'package:flurest/view/movie/movie_list.dart';

import 'package:flutter/material.dart';

class EditMovieDetail extends StatefulWidget {
  final int selectedMovie;
  const EditMovieDetail(this.selectedMovie);

  @override
  _EditMovieDetailState createState() => _EditMovieDetailState();
}

class _EditMovieDetailState extends State<EditMovieDetail> {
  MovieDetailBloc _movieDetailBloc;
  MovieBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Movie _post = new Movie();

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(widget.selectedMovie);
    _bloc = MovieBloc();
  }

  _showSnackBar(String text, BuildContext context) {
    final snackbar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    // ScaffoldMessenger.showSnackBar(snackbar);
  }

  _updatePost(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      _showSnackBar("Failed to edit Contact", context);
      return;
    }
    _formKey.currentState.save();

    _post.id = widget.selectedMovie;

    await _bloc.updateMovie(_post);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieScreen(
              message: "Contact Successfully Updated !",
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Edit Contact',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            _movieDetailBloc.fetchMovieDetail(widget.selectedMovie),
        child: StreamBuilder<ApiResponse<Movie>>(
          stream: _movieDetailBloc.movieDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return _editMovie(snapshot.data.data, context);

                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        _movieDetailBloc.fetchMovieDetail(widget.selectedMovie),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _movieDetailBloc.dispose();
    super.dispose();
  }

  Widget _editMovie(Movie movie, BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 16,
                ),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Title"),
                  initialValue: movie.title,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Title cannot be empty";
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    _post.title = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32, top: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Description", alignLabelWithHint: true),
                  initialValue: movie.body,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Description cannot be empty";
                    }

                    return null;
                  },
                  onSaved: (String value) {
                    _post.body = value;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
                child: ElevatedButton(
                  onPressed: () {
                    _updatePost(context);
                  },
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
