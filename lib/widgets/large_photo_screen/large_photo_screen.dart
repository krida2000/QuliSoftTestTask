import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qulisoft_test_task/models/unsplash_photo.dart';

class LargePhotoScreen extends StatelessWidget {
  final transformationController = TransformationController();
  final UnsplashPhoto unsplashPhoto;

  LargePhotoScreen({Key? key, required this.unsplashPhoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(unsplashPhoto.description ?? "No name photo"),
      ),
      body: InteractiveViewer(
        transformationController: transformationController,
        minScale: 0.1,
        maxScale: 4.6,
        scaleEnabled: true,
        panEnabled: true,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: unsplashPhoto.fullImageUrl,
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
      )
    );
  }
}
