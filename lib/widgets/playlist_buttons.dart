import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/view_model/current_track_model.dart';

class PlaylistButtons extends StatefulWidget {
  final String followers;

  const PlaylistButtons({
    Key key,
    @required this.followers,
  }) : super(key: key);

  @override
  State<PlaylistButtons> createState() => PlaylistButtonsState();
}

class PlaylistButtonsState extends State<PlaylistButtons> {
  bool _love = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<CurrentTrackModel>(
          builder: (context, value, child) => Container(
            width: (MediaQuery.of(context).size.width > 879) ? 55 : 40,
            height: (MediaQuery.of(context).size.width > 879) ? 55 : 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 7, 182, 30),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: (MediaQuery.of(context).size.width > 879) ? 30 : 20,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          icon: _love
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : const Icon(Icons.favorite_border),
          iconSize: (MediaQuery.of(context).size.width > 879) ? 30 : 20,
          onPressed: () {
            setState(() {
              _love = !_love;
            });
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
          iconSize: (MediaQuery.of(context).size.width > 879) ? 30 : 20,
          onPressed: () {},
        ),
        const Spacer(),
        Text(
          'FOLLOWERS\n${widget.followers}',
          style: Theme.of(context).textTheme.overline.copyWith(
              fontSize: (MediaQuery.of(context).size.width > 879) ? 12 : 10),
          textAlign: TextAlign.right,
        )
      ],
    );
  }
}
