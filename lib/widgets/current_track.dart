import 'package:flutter/material.dart';
import 'package:spotify/widgets/current_track_info.dart';
import 'package:spotify/widgets/more_controls.dart';
import 'package:spotify/widgets/player_controls.dart';

class CurrentTrack extends StatefulWidget {
  const CurrentTrack({Key key}) : super(key: key);

  @override
  State<CurrentTrack> createState() => _CurrentTrackState();
}

class _CurrentTrackState extends State<CurrentTrack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.0,
      width: double.infinity,
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Spacer(),
            const CurrentTrackInfo(),
            const Spacer(),
            const PlayerControls(),
            const Spacer(),
            if (MediaQuery.of(context).size.width > 800) const MoreControls(),
          ],
        ),
      ),
    );
  }
}
