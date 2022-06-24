import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/core/constant.dart';
import 'package:spotify/view_model/current_track_model.dart';

class CurrentTrackInfo extends StatelessWidget {
  const CurrentTrackInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentTrackModel>(
      builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.songName,
              style: TextStyle(
                color: whiteColor,
                fontSize: (MediaQuery.of(context).size.width > 879) ? 14 : 10,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              model.artistName,
              style: TextStyle(
                color: whiteColor,
                fontSize: (MediaQuery.of(context).size.width > 879) ? 14 : 10,
              ),
            ),
          ],
        );
      },
    );
  }
}
