class LayerNote {
  final int? id;
  final int artworkId;
  final String layerType;
  final String imagePath;
  final String noteText;
  final String createdAt;

  LayerNote({
    this.id,
    required this.artworkId,
    required this.layerType,
    required this.imagePath,
    required this.noteText,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artworkId': artworkId,
      'layerType': layerType,
      'imagePath': imagePath,
      'noteText': noteText,
      'createdAt': createdAt,
    };
  }

  factory LayerNote.fromMap(Map<String, dynamic> map) {
    return LayerNote(
      id: map['id'],
      artworkId: map['artworkId'],
      layerType: map['layerType'],
      imagePath: map['imagePath'],
      noteText: map['noteText'],
      createdAt: map['createdAt'],
    );
  }
}