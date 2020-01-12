class Lyric {
  final int id;
  final String code;
  final String name;
  final String text;

  Lyric(
    this.id,
    this.code,
    this.name,
    this.text,
  );

  Lyric.fromJson(Map<String, dynamic> json)
      : id = 0,
        code = json['id'],
        name = json['name'],
        text = json['text'];
}
