import 'package:flutter/material.dart';

class ArtistSearchText extends StatelessWidget {
  final TextEditingController _artistNameController;

  ArtistSearchText(this._artistNameController);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _artistNameController,
      decoration: InputDecoration(
        hintText: 'Artist',
        hintStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(fontSize: 16.0, color: Colors.white),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some artist';
        }
        return null;
      },
    );
  }
}
