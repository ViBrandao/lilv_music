import 'package:lilv_music/database/database.dart';
import 'package:lilv_music/models/song.dart';
import 'package:sqflite/sqlite_api.dart';

class SongDao {
  static const String _tableName = 'songs';
  static const String _id = 'id';
  static const String _code = 'code';
  static const String _description = 'description';
  static const String _url = 'url';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_code TEXT, '
      '$_description TEXT, '
      '$_url TEXT)';

  Future<int> save(Song song) async {
    final Database db = await getDatabase();
    Map<String, dynamic> songMap = _toMap(song);
    return db.insert(_tableName, songMap);
  }

  Future<int> delete(Song song) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: _code + '=?',
      whereArgs: [song.code],
    );
  }

  Future<List<Song>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
    await db.rawQuery('SELECT * FROM $_tableName ORDER BY $_id DESC');
    List<Song> songs = _toList(result);

    return songs;
  }

  Future<List<Song>> findByCode(String code) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
    await db.rawQuery('SELECT * FROM $_tableName where $_code =?', [code]);

    List<Song> songs = _toList(result);

    return songs;
  }

  Map<String, dynamic> _toMap(Song song) {
    final Map<String, dynamic> songMap = Map();
    songMap[_code] = song.code;
    songMap[_description] = song.description;
    songMap[_url] = song.url;
    return songMap;
  }

  List<Song> _toList(List<Map<String, dynamic>> result) {
    final List<Song> songs = List();

    for (Map<String, dynamic> row in result) {
      final Song song = Song(
        row[_id],
        row[_code],
        row[_description],
        row[_url],
      );
      songs.add(song);
    }
    return songs;
  }
}
