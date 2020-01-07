import 'package:flutter/material.dart';
import 'package:lilv_music/database/dao/artist_dao.dart';
import 'package:lilv_music/models/artist.dart';
import 'package:lilv_music/models/song.dart';

class ArtistSaveButton extends StatelessWidget {
  final Artist _artist;
  final ArtistDao _artistDao;

  ArtistSaveButton(this._artist, this._artistDao);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xfff50057),
      child: Icon(Icons.save),
      onPressed: () async {
        List<Artist> artists = await _artistDao.findByCode(_artist.code);

        if (artists.length == 0) {
          final Artist newArtist = Artist(
            0,
            _artist.code,
            _artist.description,
            _artist.url,
            _artist.picture,
            List<Song>(),
          );

          _artistDao.save(newArtist).then((id) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Artist save on favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        } else {
          _artistDao.delete(_artist).then((id) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Artist removed from favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        }
      },
    );
  }
}
