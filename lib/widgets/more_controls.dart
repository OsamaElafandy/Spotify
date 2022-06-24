import 'package:flutter/material.dart';
import 'package:spotify/core/constant.dart';

class MoreControls extends StatefulWidget {
  const MoreControls({Key key}) : super(key: key);

  @override
  State<MoreControls> createState() => MoreControlsState();
}

class MoreControlsState extends State<MoreControls> {
  bool mute = false;
  double volume = 1.0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.devices_outlined, color: whiteColor),
          iconSize: 20.0,
          onPressed: () {},
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                  mute ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                  color: whiteColor),
              onPressed: () async {
                setState(() {
                  mute = !mute;
                  volume = mute ? 0.0 : 1.0;
                });

                await audioPlayer.setVolume(mute ? 0 : 1);
              },
            ),
            SizedBox(
              width: 155,
              child: Slider(
                  value: volume,
                  min: 0,
                  max: 1.0,
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey[600],
                  label: 'Set volume value',
                  onChanged: (double newValue) async {
                    setState(() {
                      volume = newValue;
                    });
                    await audioPlayer.setVolume(newValue);
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  }),
            )
          ],
        ),
        IconButton(
          icon: const Icon(Icons.fullscreen_outlined, color: whiteColor),
          onPressed: () {},
        ),
      ],
    );
  }
}
