import 'package:audio_manager/audio_manager.dart';
import 'package:flurest/view/audio_player/iconText.dart';
import 'package:flurest/view/audio_player/song_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

var audioManagerInstance = AudioManager.instance;
bool showVol = false;
PlayMode playMode = audioManagerInstance.playMode;
bool isPlaying = false;
double _slider;

class SongsScreen extends StatefulWidget {
  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  void setupAudio() {
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.start:
          _slider = 0;
          break;
        case AudioManagerEvents.seekComplete:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = audioManagerInstance.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          audioManagerInstance.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        elevation: 0,
        title: showVol
            ? Slider(
                value: audioManagerInstance.volume ?? 0,
                onChanged: (value) {
                  setState(() {
                    audioManagerInstance.setVolume(value, showVolume: true);
                  });
                },
              )
            : Text("MusicApp"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              height: 500,
              child: FutureBuilder(
                future: FlutterAudioQuery()
                    .getSongs(sortType: SongSortType.RECENT_YEAR),
                builder: (context, snapshot) {
                  List<SongInfo> songInfo = snapshot.data;
                  if (snapshot.hasData) return SongWidget(songList: songInfo);
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Loading....",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
          bottomPanel()
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget songProgress(BuildContext context) {
    var style = TextStyle(color: Colors.black);
    return Row(
      children: <Widget>[
        Text(
          _formatDuration(audioManagerInstance.position),
          style: style,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2,
              thumbColor: Colors.blueAccent,
              overlayColor: Colors.blue,
              thumbShape: RoundSliderThumbShape(
                  disabledThumbRadius: 5, enabledThumbRadius: 5),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
              activeTrackColor: Colors.blueAccent,
              inactiveTrackColor: Colors.grey,
            ),
            child: Slider(
              value: _slider ?? 0,
              onChanged: (value) {
                setState(() {
                  _slider = value;
                });
              },
              onChangeEnd: (value) {
                if (audioManagerInstance.duration != null) {
                  Duration msec = Duration(
                      milliseconds:
                          (audioManagerInstance.duration.inMilliseconds * value)
                              .round());
                  audioManagerInstance.seekTo(msec);
                }
              },
            ),
          ),
        )),
        Text(
          _formatDuration(audioManagerInstance.duration),
          style: style,
        )
      ],
    );
  }

  Widget bottomPanel() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: songProgress(context),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                    onPressed: () => audioManagerInstance.previous(),
                  ),
                ),
                backgroundColor: Colors.cyan.withOpacity(0.3),
              ),
              CircleAvatar(
                radius: 30,
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      audioManagerInstance.playOrPause();
                    },
                    padding: const EdgeInsets.all(0.0),
                    icon: Icon(
                      audioManagerInstance.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.cyan.withOpacity(0.3),
                child: Center(
                  child: IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                      onPressed: () => audioManagerInstance.next()),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
