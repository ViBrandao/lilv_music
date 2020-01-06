import 'package:flutter/material.dart';
import 'package:lilv_music/screens/home.dart';

void main() {
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primaryColor: Color(0xff212121),
        primaryColorDark: Color(0xff000000),
        primaryColorLight: Color(0xff484848),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xfff50057),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Home(),
    );
  }
}
