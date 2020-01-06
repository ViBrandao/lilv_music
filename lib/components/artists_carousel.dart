import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lilv_music/http/webclients/artist_webclient.dart';
import 'package:lilv_music/models/artist.dart';
import 'package:lilv_music/screens/artist_info.dart';

class ArtistsCarousel extends StatelessWidget {
  final List<Artist> _artists ;
  final ArtistWebClient _webClient;

  ArtistsCarousel(this._artists, this._webClient);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      enableInfiniteScroll: true,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      enlargeCenterPage: true,
      items: _artists.map((artist) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColorDark),
              child: InkWell(
                onTap: () {
                  _webClient
                      .find(artist.url.replaceAll('/', ''))
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
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        artist.description,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Image(
                        image: NetworkImage(
                          //TODO colocar essa url em algum lugar
                          'https://www.vagalume.com.br/${artist.picture}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
