import 'package:flurest/view/audio_player/media_source.dart';
import 'package:flurest/view/audio_player/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:media_player/data_sources.dart';

class MediaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(list[index]['title']),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              print(list[index]);
              if (list[index]['source'] is Playlist)
                return VideoPlayerScreen(playlist: list[index]['source']);
              else
                return VideoPlayerScreen(source: list[index]['source']);
            }));
          },
        );
      },
    );
  }
}
