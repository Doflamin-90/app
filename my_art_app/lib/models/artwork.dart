class Artwork {
  final int? id;
  final String title;
  final String createdAt;

  Artwork({
    this.id,
    required this.title,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
    };
  }

  factory Artwork.fromMap(Map<String, dynamic> map) {
    return Artwork(
      id: map['id'],
      title: map['title'],
      createdAt: map['createdAt'],
    );
  }
}