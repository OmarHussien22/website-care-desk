class Avatar {
  final int? id;
  final String? url;

  const Avatar({
    this.id,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': url,
    };
  }

  static const Avatar example = Avatar(
    id: 1,
    url: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
  );
}
