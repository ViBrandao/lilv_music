import 'package:lilv_music/database/database.dart';
import 'package:lilv_music/models/artist.dart';
import 'package:lilv_music/models/song.dart';
import 'package:sqflite/sqlite_api.dart';

class ArtistDao {
  static const String _tableName = 'artists';
  static const String _id = 'id';
  static const String _code = 'code';
  static const String _description = 'description';
  static const String _url = 'url';
  static const String _picture = 'picture';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_code TEXT, '
      '$_description TEXT, '
      '$_url TEXT, '
      '$_picture TEXT)';

  Future<int> save(Artist artist) async {
    final Database db = await getDatabase();
    Map<String, dynamic> artistMap = _toMap(artist);
    return db.insert(_tableName, artistMap);
  }

  Future<int> delete(Artist artist) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: _code + '=?',
      whereArgs: [artist.code],
    );
  }

  Future<List<Artist>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM $_tableName ORDER BY $_id DESC');
    List<Artist> artists = _toList(result);

    return artists;
  }

  Future<List<Artist>> findByCode(String code) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM $_tableName where $_code =?', [code]);

    List<Artist> artists = _toList(result);

    return artists;
  }

  Map<String, dynamic> _toMap(Artist artist) {
    final Map<String, dynamic> artistMap = Map();
    artistMap[_code] = artist.code;
    artistMap[_description] = artist.description;
    artistMap[_url] = artist.url;
    artistMap[_picture] = artist.picture;
    return artistMap;
  }

  List<Artist> _toList(List<Map<String, dynamic>> result) {
    final List<Artist> artists = List();

    for (Map<String, dynamic> row in result) {
      final Artist artist = Artist(
        row[_id],
        row[_code],
        row[_description],
        row[_url],
        row[_picture],
        new List<Song>(),
      );
      artists.add(artist);
    }
    return artists;
  }
}
