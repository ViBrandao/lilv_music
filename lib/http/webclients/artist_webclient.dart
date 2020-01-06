import 'dart:convert';
import 'package:http/http.dart';
import 'package:lilv_music/http/webclient.dart';
import 'package:lilv_music/models/artist.dart';

class ArtistWebClient {
  static String baseUrl = 'https://www.vagalume.com.br';

  Future<Artist> find(String artistName) async {
    final Response response = await client
        .get(baseUrl + '/' + artistName + '/' + 'index.js')
        .timeout(Duration(seconds: 5));

    final dynamic decodedJson = jsonDecode(response.body);

    return Artist.fromJson(decodedJson['artist']);
  }
}
