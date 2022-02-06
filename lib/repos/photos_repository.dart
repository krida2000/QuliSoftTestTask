import 'package:qulisoft_test_task/api/unsplash_api.dart';
import 'package:qulisoft_test_task/models/unsplash_photo.dart';

class PhotosRepository {
  final UnsplashApi unsplashApi = UnsplashApi();

  Future<List<UnsplashPhoto>> loadPhotos({required int page}) async {
    final photosJson =
      await unsplashApi.loadPhotos(page: page);

    return photosJson
        .map((photoJson) => UnsplashPhoto.fromJson(photoJson))
        .toList();
  }
}
