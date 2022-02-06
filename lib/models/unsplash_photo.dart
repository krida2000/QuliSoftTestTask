class UnsplashPhoto {
  final String id;
  final String? description;
  final String authorName;
  final String smallImageUrl;
  final String fullImageUrl;

  UnsplashPhoto({
    required this.id,
    required this.description,
    required this.authorName,
    required this.smallImageUrl,
    required this.fullImageUrl,
  });

  factory UnsplashPhoto.fromJson(Map<String, dynamic> json) => UnsplashPhoto(
        id: json["id"] as String,
        description: json["description"] as String?,
        authorName: (json["user"] as Map<String, dynamic>)["username"] as String,
        smallImageUrl: (json["urls"] as Map<String, dynamic>)["small_s3"] as String,
        fullImageUrl: (json["urls"] as Map<String, dynamic>)["full"] as String,
      );
}
