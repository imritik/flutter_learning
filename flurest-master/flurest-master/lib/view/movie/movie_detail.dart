import 'package:flurest/blocs/movie_bloc.dart';
import 'package:flurest/blocs/movie_detail_bloc.dart';
import 'package:flurest/helpers/helper.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_response.dart';
import 'package:flurest/view/movie/edit_movie.dart';
import 'package:flurest/view/movie/movie_list.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MovieDetail extends StatefulWidget {
  final int selectedMovie;
  const MovieDetail(this.selectedMovie);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc _movieDetailBloc;
  MovieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(widget.selectedMovie);
    _bloc = MovieBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Mover',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text("Edit")),
              PopupMenuItem<int>(value: 1, child: Text("Delete")),
            ],
            onSelected: (item) => selectedItem(context, item),
          ),
        ],
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
                  return ShowMovieDetail(displayMovie: snapshot.data.data);

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

  void selectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        //add navigation here
        print("edit button clicked");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditMovieDetail(widget.selectedMovie)));
        break;
      case 1:
        print("delete clicked");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Confirm"),
              content: new Text("Do you want to delete ?"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () async {
                    await _bloc.deleteMovie(widget.selectedMovie);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MovieScreen(
                              message: "Contact Successfully Deleted",
                            )));
                  },
                ),
              ],
            );
          },
        );

        break;
    }
  }
}

class ShowMovieDetail extends StatelessWidget {
  final Movie displayMovie;

  ShowMovieDetail({Key key, this.displayMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        // new Image.network(
        //   'https://logo.clearbit.com/baremetrics.com',
        //   fit: BoxFit.cover,
        // ),
        // new BackdropFilter(
        //   filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        //   child: new Container(
        //     color: Colors.black.withOpacity(0.4),
        //   ),
        // ),
        new SingleChildScrollView(
          child: new Container(
            margin: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    width: 300.0,
                    height: 300.0,
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(10.0),
                    image: new DecorationImage(
                        image: new NetworkImage(
                            'https://logo.clearbit.com/baremetrics.com'),
                        fit: BoxFit.cover),
                    boxShadow: [
                      new BoxShadow(
                          blurRadius: 20.0, offset: new Offset(0.0, 10.0))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: new Text(
                        displayMovie.title,
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontFamily: 'Arvo'),
                      ),
                    )
                  ],
                ),
                new Text(displayMovie.body,
                    style: new TextStyle(
                        color: Colors.black, fontSize: 22, fontFamily: 'Arvo')),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Container(
                      width: 150.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      child: new Text(
                        'Rating',
                        style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arvo',
                            fontSize: 20.0),
                      ),
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          color: const Color(0xaa3C3261)),
                    )),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: new Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      ),
                    ),
                    new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: new Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        )),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
