import 'dart:io';
import 'package:flurest/view/audio_player/iconText.dart';
import 'package:flurest/view/audio_player/songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongWidget extends StatelessWidget {
  final List<SongInfo> songList;

  SongWidget({@required this.songList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        // ignore: missing_return
        itemBuilder: (context, songIndex) {
          SongInfo song = songList[songIndex];
          if (song.displayName.contains(".mp3")) {
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ClipRect(
                        // child: Image(
                        //   height: 90,
                        //   width: 150,
                        //   fit: BoxFit.cover,
                        //   // image: FileImage(File(song.albumArtwork)),
                        // ),
                        ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  song.title,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text("Release Year: ${song.year}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              print("${song.filePath}");
                              audioManagerInstance
                                  .start("file://${song.filePath}", song.title,
                                      desc: song.displayName != null
                                          ? song.displayName
                                          : '',
                                      auto: true,
                                      cover: song.albumArtwork != null
                                          ? song.albumArtwork
                                          : '')
                                  .then((err) {
                                print(err);
                              });
                            },
                            child: IconText(
                              iconData: Icons.play_circle_outline_outlined,
                              iconColor: Colors.blue,
                              string: "Play",
                              textColor: Colors.black,
                              iconSize: 25,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
