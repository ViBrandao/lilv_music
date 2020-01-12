import 'package:lilv_music/database/database.dart';
import 'package:lilv_music/models/lyric.dart';
import 'package:sqflite/sqlite_api.dart';

class LyricDao {
  static const String _tableName = 'lyrics';
  static const String _id = 'id';
  static const String _code = 'code';
  static const String _name = 'name';
  static const String _text = 'text';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_code TEXT, '
      '$_name TEXT, '
      '$_text TEXT)';

  Future<int> save(Lyric lyric) async {
    final Database db = await getDatabase();
    Map<String, dynamic> artistMap = _toMap(lyric);
    return db.insert(_tableName, artistMap);
  }

  Future<int> delete(Lyric song) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: _code + '=?',
      whereArgs: [song.code],
    );
  }

  Future<List<Lyric>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
    await db.rawQuery('SELECT * FROM $_tableName ORDER BY $_id DESC');
    List<Lyric> lyrics = _toList(result);

    return lyrics;
  }

  Future<List<Lyric>> findByCode(String code) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
    await db.rawQuery('SELECT * FROM $_tableName where $_code =?', [code]);

    List<Lyric> lyrics = _toList(result);

    return lyrics;
  }

  Map<String, dynamic> _toMap(Lyric lyric) {
    final Map<String, dynamic> lyricMap = Map();
    lyricMap[_code] = lyric.code;
    lyricMap[_name] = lyric.name;
    lyricMap[_text] = lyric.text;
    return lyricMap;
  }

  List<Lyric> _toList(List<Map<String, dynamic>> result) {
    final List<Lyric> lyrics = List();

    for (Map<String, dynamic> row in result) {
      final Lyric lyric = Lyric(
        row[_id],
        row[_code],
        row[_name],
        row[_text],
      );
      lyrics.add(lyric);
    }
    return lyrics;
  }
}
