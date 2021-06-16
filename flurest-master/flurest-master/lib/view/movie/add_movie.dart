import 'package:flurest/blocs/movie_bloc.dart';
import 'package:flurest/helpers/helper.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_response.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Movie _post = new Movie();
  MovieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc();
  }

  _showSnackBar(String text, BuildContext context) {
    final snackbar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    // ScaffoldMessenger.showSnackBar(snackbar);
  }

  _createPost(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      _showSnackBar("Failed to add Movie", context);
      return;
    }
    _formKey.currentState.save();

    _post.id = 1;

    // await ApiViewmodel.postData();
    await _bloc.addMovie(_post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add a Movie'),
      ),
      body: StreamBuilder<ApiResponse<bool>>(
        stream: _bloc.movieAddStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return _addMovieForm(true, context);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.addMovie(_post),
                );
                break;
            }
          }
          return Container(
            child: _addMovieForm(false, context),
          );
        },
      ),
    );
  }

  Widget _addMovieForm(bool value, BuildContext context) {
    if (value) {
      Future.delayed(Duration.zero, () async {
        _showSnackBar("Movie Successfully Added !", context);
      });
    }
    return Scaffold(
      body: Container(
        child: Form(
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
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: "Description", alignLabelWithHint: true),
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
                    _createPost(context);
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
