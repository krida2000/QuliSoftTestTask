import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qulisoft_test_task/models/unsplash_photo.dart';

class PhotoContainer extends StatelessWidget {
  final UnsplashPhoto unsplashPhoto;

  const PhotoContainer({Key? key, required this.unsplashPhoto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: double.infinity,
            maxHeight: 400,
            minHeight: 150,
          ),
          child: CachedNetworkImage(
            imageUrl: unsplashPhoto.smallImageUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
              heightFactor: 0.7,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.contain,
          ),
        ),
        Text(unsplashPhoto.description ?? ""),
        Text(unsplashPhoto.authorName)
      ],
    );
  }
}
