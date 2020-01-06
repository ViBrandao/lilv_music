import 'package:lilv_music/models/song.dart';

class Artist {
  final int id;
  final String code;
  final String description;
  final String url;
  final String picture;
  final List<Song> songs;

  Artist(
    this.id,
    this.code,
    this.description,
    this.url,
    this.picture,
    this.songs,
  );

  Artist.fromJson(Map<String, dynamic> json)
      : id = 0,
        code = json['id'],
        description = json['desc'],
        url = json['url'],
        picture = json['pic_medium'],
        songs = getSongs(json['toplyrics']['item']);

  static List<Song> getSongs(List<dynamic> decodedJson) {
    return decodedJson.map((dynamic json) => Song.fromJson(json)).toList();
  }
}
