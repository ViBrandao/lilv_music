import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lilv_music/models/lyric.dart';

class MusicInfo extends StatelessWidget {
  final Lyric _lyric;

  MusicInfo(this._lyric);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Music'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Color(0xffbb002f),
            padding: EdgeInsets.all(8.0),
            child: Text(
                _lyric.name,
              style: TextStyle(fontSize: 24.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  _lyric.text,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Color(0xfff50057),
//        child: Icon(Icons.star_border),
//        onPressed: () {},
//      ),
    );
  }
}
