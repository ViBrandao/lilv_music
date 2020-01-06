import 'package:lilv_music/database/dao/artist_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'lilvmusic.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ArtistDao.tableSql);
    },
    version: 1,
  );
}
