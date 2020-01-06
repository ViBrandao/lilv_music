import 'package:flutter/material.dart';
import 'package:lilv_music/http/webclients/artist_webclient.dart';
import 'package:lilv_music/screens/artist_info.dart';

class ArtistSearchButton extends StatelessWidget {
  final _formKey;
  final ArtistWebClient _artistWebClient;
  final TextEditingController _artistNameController;

  ArtistSearchButton(
    this._formKey,
    this._artistWebClient,
    this._artistNameController,
  );

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        //TODO melhorar essa pesquisa
        //TODO colocar mensagem quando não achar o artista
        if (_formKey.currentState.validate()) {
          _artistWebClient
              .find(_artistNameController.text
                  .replaceAll(new RegExp(r' '), '-')
                  .toLowerCase())
              .then((artist) {
            if (artist != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ArtistInfo(artist),
                ),
              );
            }
          }).catchError((error) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Artist not found'),
                duration: Duration(seconds: 2),
              ),
            );
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Search',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
