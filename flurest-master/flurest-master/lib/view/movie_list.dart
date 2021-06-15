import 'package:flurest/blocs/movie_bloc.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_response.dart';
import 'package:flurest/view/add_movie.dart';
import 'package:flurest/view/movie_detail.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieBloc _bloc;

  bool isOn = false;

  void toggle() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          actions: <Widget>[
            Column(
              children: [
                Switch(
                    value: isOn,
                    onChanged: (val) {
                      toggle();
                    }),
              ],
            )
          ],
          title: Text(
            'Mover',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Test Name'),
                accountEmail: Text('test@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    "T",
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
                onTap: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => MapPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.video_call),
                title: Text('Video Player'),
                enabled: false,
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => _bloc.fetchMovieList(),
          child: StreamBuilder<ApiResponse<List<Movie>>>(
            stream: _bloc.movieListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return isOn
                        ? MovieListView(movieList: snapshot.data.data)
                        : MovieList(
                            movieList: snapshot.data.data,
                          );
                    break;
                  case Status.ERROR:
                    return Error(
                      errorMessage: snapshot.data.message,
                      onRetryPressed: () => _bloc.fetchMovieList(),
                    );
                    break;
                }
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddPostScreen()));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetail(movieList[index].id)));
              },
              child: Card(
                  child: Column(children: [
                Flexible(
                  flex: 2,
                  child: Center(
                      child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.teal,
                    child: Text(
                      movieList[index].title[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  )),
                ),
                Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(movieList[index].title),
                        ),
                      ],
                    )),
              ])),
            ));
      },
    );
  }
}

class MovieListView extends StatelessWidget {
  final List<Movie> movieList;

  const MovieListView({Key key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Divider(),
      ),
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Center(
                        child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text(
                        movieList[index].title[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )),
                  ),
                  Flexible(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(movieList[index].title),
                          ),
                        ],
                      )),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetail(movieList[index].id)));
              },
            ));
      },
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            child: Text(
              'Retry',
              style: TextStyle(),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
