import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:spotify/core/constant.dart';
import '../model/song.dart';
import '../view_model/current_track_model.dart';

class TracksList extends StatelessWidget {
  const TracksList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('songs').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 35,
              ));
            case ConnectionState.none:
              return const Center(child: Text('No Connection'));

            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<Song> tracks;

                tracks = snapshot.data.docs
                    .map((doc) => Song.fromJson(doc.data()))
                    .toList();

                return DataTable(
                  headingTextStyle: Theme.of(context)
                      .textTheme
                      .overline
                      .copyWith(fontSize: 12.0),
                  dataRowHeight: 54.0,
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text('TITLE')),
                    DataColumn(label: Text('ARTIST')),
                    DataColumn(label: Text('ALBUM')),
                    DataColumn(label: Icon(Icons.access_time)),
                  ],
                  rows: tracks.map((e) {
                    return DataRow(
                        cells: [
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40.0,
                                  child: CachedNetworkImage(
                                    imageUrl: e.imageUrl,
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  e.title,
                                  style: TextStyle(
                                      fontSize:
                                          (MediaQuery.of(context).size.width >
                                                  879)
                                              ? 14
                                              : 11),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(
                              e.artist,
                              style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 879)
                                          ? 14
                                          : 11),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.album,
                              style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 879)
                                          ? 14
                                          : 11),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.duration,
                              style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(context).size.width > 879)
                                          ? 14
                                          : 11),
                            ),
                          ),
                        ],
                        onSelectChanged: (_) async {
                          String urlSong = e.songURL;
                          var pro = Provider.of<CurrentTrackModel>(context,
                              listen: false);
                          pro.songUrl = urlSong;
                          pro.songName = e.title;
                          pro.artistName = e.artist;
                          pro.isPlaying = true;
                          await audioPlayer.play(UrlSource(urlSong));
                        });
                  }).toList(),
                );
              } else {
                return const SizedBox();
              }
          }
        });
  }
}
