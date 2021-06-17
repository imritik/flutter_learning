import 'package:flurest/view/video_player/video_items.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Video player'),
        // centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          VideoItems(
            videoPlayerController:
                VideoPlayerController.asset('assets/videos/sample1.mp4'),
            looping: false,
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.asset(
              'assets/videos/sample2.mp4',
            ),
            autoplay: true,
          ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
                "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"),
            looping: true,
            autoplay: false,
          ),
        ],
      ),
    );
  }
}
