import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/core/constant.dart';
import 'package:spotify/view_model/current_track_model.dart';

class PlayerControls extends StatefulWidget {
  const PlayerControls({Key key}) : super(key: key);

  @override
  State<PlayerControls> createState() => PlayerControlsState();
}

class PlayerControlsState extends State<PlayerControls> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else if (s == PlayerState.stopped) {
        setState(() {
          position = duration;
          isPlaying = false;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });

    audioPlayer.onPositionChanged.listen((p) => setState(() => position = p));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.shuffle, color: whiteColor),
              iconSize: (MediaQuery.of(context).size.width > 879) ? 20 : 18,
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.skip_previous_outlined, color: whiteColor),
              iconSize: (MediaQuery.of(context).size.width > 879) ? 20 : 18,
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_outline_outlined
                      : Icons.play_circle_outline,
                  color: whiteColor),
              iconSize: (MediaQuery.of(context).size.width > 879) ? 34 : 30,
              onPressed: () async {
                var pro =
                    Provider.of<CurrentTrackModel>(context, listen: false);
                setState(() {
                  isPlaying = !isPlaying;
                });
                if (isPlaying) {
                  String urlSongGloable = pro.songUrl;
                  pro.isPlaying = true;
                  await audioPlayer.play(UrlSource(
                      urlSongGloable)); // will immediately start playing
                } else {
                  await audioPlayer.pause();
                  pro.isPlaying = false;
                }
              },
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.skip_next_outlined, color: whiteColor),
              iconSize: (MediaQuery.of(context).size.width > 879) ? 20 : 18,
              onPressed: () {},
            ),
            IconButton(
              padding: const EdgeInsets.only(),
              icon: const Icon(Icons.repeat, color: whiteColor),
              iconSize: (MediaQuery.of(context).size.width > 879) ? 20 : 18,
              onPressed: () {},
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Text(formatTime(position),
                  style: TextStyle(
                    color: whiteColor,
                    fontSize:
                        (MediaQuery.of(context).size.width > 879) ? 16 : 11,
                  )),
              const SizedBox(width: 8.0),
              SizedBox(
                width: (MediaQuery.of(context).size.width > 879) ? 300 : 180,
                child: Slider(
                    value: position.inSeconds.toDouble(),
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey[600],
                    onChanged: (double newValue) async {
                      final position = Duration(seconds: newValue.toInt());
                      await audioPlayer.seek(position);
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} dollars';
                    }),
              ),
              const SizedBox(width: 8.0),
              Text(
                formatTime(duration - position),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: (MediaQuery.of(context).size.width > 879) ? 16 : 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
