import 'package:flutter/material.dart';
import 'package:lilv_music/http/webclients/lyric_webclient.dart';
import 'package:lilv_music/models/artist.dart';
import 'package:lilv_music/screens/music_info.dart';

class ArtistsListView extends StatelessWidget {
  final Artist _artist;
  final LyricWebClient _lyricWebClient;

  ArtistsListView(this._artist, this._lyricWebClient);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _artist.songs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: InkWell(
            onTap: () {
              var infos = (_artist.songs[index].url
                      .replaceFirst('/', '')
                      .replaceFirst('.html', ''))
                  .split('/');

              var songArtist = infos[0];
              var songName = infos[1];

              _lyricWebClient.find(songArtist, songName).then((lyric) {
                if (lyric != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MusicInfo(lyric),
                    ),
                  );
                }
              });
            },
            child: Container(
              color: Theme.of(context).primaryColorLight,
              child: ListTile(
                leading: Icon(Icons.music_note),
                title: Text(
                  _artist.songs[index].description,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
