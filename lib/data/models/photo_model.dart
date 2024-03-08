class Photo {
  final String imageUrl;
  final DateTime uploadDate;

  const Photo({
    required this.imageUrl,
    required this.uploadDate,
  });

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      imageUrl: map['imageUrl'],
      uploadDate: map['uploadDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'uploadDate': uploadDate,
    };
  }
}
