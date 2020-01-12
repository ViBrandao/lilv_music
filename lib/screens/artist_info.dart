import 'package:flutter/material.dart';
import 'package:lilv_music/components/artist_save_button.dart';
import 'package:lilv_music/components/artist_songs_list_view.dart';
import 'package:lilv_music/database/dao/artist_dao.dart';
import 'package:lilv_music/database/dao/song_dao.dart';
import 'package:lilv_music/http/webclients/lyric_webclient.dart';
import 'package:lilv_music/models/artist.dart';

class ArtistInfo extends StatelessWidget {
  final Artist _artist;
  final LyricWebClient _lyricWebClient = LyricWebClient();
  final ArtistDao _artistDao = ArtistDao();
  final SongDao _songDao = new SongDao();

  ArtistInfo(this._artist);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Artist'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Color(0xffbb002f),
            child: Text(
              _artist.description,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            color: Color(0xffbb002f),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                height: 150.0,
                image: NetworkImage(
                  //TODO colocar essa url em algum lugar
                  'https://www.vagalume.com.br/${_artist.picture}',
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).primaryColorLight,
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Songs',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ArtistSongsListView(_artist.songs, _lyricWebClient, _songDao),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => ArtistSaveButton(_artist, _artistDao),
      ),
    );
  }
}
