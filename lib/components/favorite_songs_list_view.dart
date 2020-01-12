import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lilv_music/database/dao/song_dao.dart';
import 'package:lilv_music/http/webclients/lyric_webclient.dart';
import 'package:lilv_music/models/song.dart';
import 'package:lilv_music/screens/lyric_info.dart';

class FavoriteSongsListView extends StatefulWidget {
  final List<Song> _songs;
  final LyricWebClient _lyricWebClient;
  final SongDao _songDao;

  FavoriteSongsListView(this._songs, this._lyricWebClient, this._songDao);

  @override
  _FavoriteSongsListViewState createState() => _FavoriteSongsListViewState();
}

class _FavoriteSongsListViewState extends State<FavoriteSongsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget._songs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: InkWell(
            onTap: () {
              var infos = (widget._songs[index].url
                      .replaceFirst('/', '')
                      .replaceFirst('.html', ''))
                  .split('/');
              var songArtist = infos[0];
              var songName = infos[1];
              widget._lyricWebClient.find(songArtist, songName).then((lyric) {
                if (lyric != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LyricInfo(lyric),
                    ),
                  );
                }
              });
            },
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: Container(
                color: Theme.of(context).primaryColorLight,
                child: ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(
                    widget._songs[index].description,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Remove',
                  color: Color(0xfff50057),
                  icon: Icons.delete,
                  onTap: () async {
                    widget._songDao.delete(widget._songs[index]).then((id) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed from favorites'),
                          action: SnackBarAction(
                            label: 'Confirm',
                            onPressed: () {
                              setState(() {
                                widget._songs.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
