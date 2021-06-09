import 'package:flutter/material.dart';
import 'package:flutter_application_1/Notifiers/pokemonNotifier.dart';

class GridViewer extends StatefulWidget {
  const GridViewer({Key key}) : super(key: key);

  @override
  _GridViewerState createState() => _GridViewerState();
}

class _GridViewerState extends State<GridViewer> {
  // List<String> images = [
  //   "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  //   "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  //   "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
  //   "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(100, (index) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      'https://picsum.photos/500/500?random=$index',
                      // width: MediaQuery.of(context).size.height * 0.55,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Text(
                      'Image $index',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              );
            })));
    // @override
    // Widget build(BuildContext context) {
    //   return Container(
    //       padding: EdgeInsets.all(12.0),
    //       child: GridView.builder(
    //         itemCount: images.length,
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0),
    //         itemBuilder: (BuildContext context, int index) {
    //           return Image.network(images[index]);
    //         },
    //       ));
    // }
  }
}
