import 'package:flutter/material.dart';
import 'package:lilv_music/database/dao/lyric_dao.dart';
import 'package:lilv_music/models/lyric.dart';

class LyricSaveButton extends StatelessWidget {
  final Lyric _lyric;
  final LyricDao _lyricDao;

  LyricSaveButton(this._lyric, this._lyricDao);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xfff50057),
      child: Icon(Icons.save),
      onPressed: () async {
        List<Lyric> lyrics = await _lyricDao.findByCode(_lyric.code);

        if (lyrics.length == 0) {
          final Lyric newLyric = Lyric(
            0,
            _lyric.code,
            _lyric.name,
            _lyric.text,
          );

          _lyricDao.save(newLyric).then((id) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Lyric save on favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        } else {
          _lyricDao.delete(_lyric).then((id) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Lyric removed from favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        }
      },
    );
  }
}
