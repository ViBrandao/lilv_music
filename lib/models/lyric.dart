class Lyric {
  final int id;
  final String codigo;
  final String name;
  final String text;

  Lyric(
    this.id,
    this.codigo,
    this.name,
    this.text,
  );

  Lyric.fromJson(Map<String, dynamic> json)
      : id = 0,
        codigo = json['id'],
        name = json['name'],
        text = json['text'];
}
