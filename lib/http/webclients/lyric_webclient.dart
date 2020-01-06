import 'dart:convert';
import 'package:http/http.dart';
import 'package:lilv_music/http/webclient.dart';
import 'package:lilv_music/models/lyric.dart';

class LyricWebClient {
  static String baseUrl = 'https://api.vagalume.com.br/search.php?';

  Future<Lyric> find(String artistName, String musicName) async {
    final Response response = await client
        .get(baseUrl + 'art=' + artistName + '&mus=' + musicName + '&apikey={key}')
        .timeout(Duration(seconds: 5));

    final dynamic decodedJson = jsonDecode(response.body);

    return Lyric.fromJson(decodedJson['mus'][0]);
  }
}
