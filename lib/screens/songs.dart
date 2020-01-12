import 'package:flutter/material.dart';
import 'package:lilv_music/components/favorite_songs_list_view.dart';
import 'package:lilv_music/database/dao/song_dao.dart';
import 'package:lilv_music/http/webclients/lyric_webclient.dart';
import 'package:lilv_music/models/song.dart';

class Songs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LyricWebClient _lyricWebClient = LyricWebClient();
    final SongDao _songDao = new SongDao();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Songs'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<Song>>(
              future: _songDao.findAll(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    break;
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    List<Song> _songs = snapshot.data;
                    if (_songs.length > 0)
                      return FavoriteSongsListView(_songs, _lyricWebClient, _songDao);
                    else
                      return Padding(
                        padding: const EdgeInsets.all(80.0),
                        child: Text(
                          'Favorite any song',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    break;
                }
                return Text('Erro');
              },
            ),
          ),
        ],
      ),
    );
  }
}
