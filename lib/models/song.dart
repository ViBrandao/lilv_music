class Song {
  final String description;
  final String url;

  Song(
    this.description,
    this.url,
  );

  Song.fromJson(Map<String, dynamic> json)
      : description = json['desc'],
        url = json['url'];
}
