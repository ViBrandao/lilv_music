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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Color(0xffbb002f)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Color(0xffbb002f)),
        ),
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
