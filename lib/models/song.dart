class Song {
  final int id;
  final String code;
  final String description;
  final String url;

  Song(this.id, this.code, this.description, this.url);

  Song.fromJson(Map<String, dynamic> json)
      : id = 0,
        code = json['id'],
        description = json['desc'],
        url = json['url'];
}
