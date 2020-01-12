import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lilv_music/components/artist_search_button.dart';
import 'package:lilv_music/components/artist_search_text.dart';
import 'package:lilv_music/components/artists_carousel.dart';
import 'package:lilv_music/database/dao/artist_dao.dart';
import 'package:lilv_music/http/webclients/artist_webclient.dart';
import 'package:lilv_music/models/artist.dart';
import 'package:lilv_music/screens/songs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _artistNameController = TextEditingController();
  final ArtistWebClient _artistWebClient = ArtistWebClient();
  final ArtistDao _artistDao = ArtistDao();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: ArtistSearchText(_artistNameController),
              ),
              Container(
                width: double.infinity,
                child: Builder(
                  builder: (context) => ArtistSearchButton(
                    _formKey,
                    _artistWebClient,
                    _artistNameController,
                  ),
                ),
              ),
              Container(
                height: 325.0,
                padding: EdgeInsets.only(top: 8.0),
                width: double.infinity,
                child: Card(
                  color: Theme.of(context).primaryColorDark,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Favorite Artists',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        FutureBuilder(
                            future: _artistDao.findAll(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  break;
                                case ConnectionState.waiting:
                                  break;
                                case ConnectionState.active:
                                  break;
                                case ConnectionState.done:
                                  final List<Artist> _artists = snapshot.data;
                                  if (_artists.length > 0) {
                                    return Expanded(
                                      child: ArtistsCarousel(
                                        _artists,
                                        _artistWebClient,
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(80.0),
                                      child: Text(
                                        'Favorite any artist',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
                                  break;
                              }
                              return Text('Erro');
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Songs(),
                              ),
                            );
                          },
                          child: Text('Lyrics'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text('More'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
