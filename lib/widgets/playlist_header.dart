import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spotify/widgets/playlist_buttons.dart';

class PlaylistHeader extends StatelessWidget {
  const PlaylistHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('playlist')
            .doc('uGZ63rJRkP8hNmrk586e')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 10,
              ));
            case ConnectionState.none:
              return const Center(child: Text('No Connection'));

            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          height: 200.0,
                          width: 200.0,
                          fit: BoxFit.cover,
                          imageUrl: snapshot.data['imageURL'],
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PLAYLIST',
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    .copyWith(fontSize: 12.0),
                              ),
                              const SizedBox(height: 12.0),
                              Text(snapshot.data['name'],
                                  style: TextStyle(
                                    fontSize:
                                        (MediaQuery.of(context).size.width >
                                                879)
                                            ? 24
                                            : 20,
                                    fontWeight: FontWeight.w400,
                                  )),
                              const SizedBox(height: 16.0),
                              Text(
                                snapshot.data['description'],
                                style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 879)
                                          ? 18
                                          : 16,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Created by ${snapshot.data['creator']} • ${snapshot.data['songlen']} songs, ${snapshot.data['duration']}',
                                style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 879)
                                          ? 19
                                          : 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    PlaylistButtons(followers: snapshot.data['followers']),
                  ],
                );
              }
          }
          return Container();
        });
  }
}
