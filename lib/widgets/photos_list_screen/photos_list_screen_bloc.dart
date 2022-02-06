import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:qulisoft_test_task/models/unsplash_photo.dart';
import 'package:rxdart/rxdart.dart';

import 'package:qulisoft_test_task/repos/photos_repository.dart';

class PhotosListScreenBloc {
  final PhotosRepository _photosRepository;

  final BehaviorSubject<List<UnsplashPhoto>?> _photosListSubject =
      BehaviorSubject<List<UnsplashPhoto>?>();
  final StreamController<void> _scrollStreamController =
      StreamController<void>();

  PhotosListScreenBloc({
    required photosRepository,
  }) : _photosRepository = photosRepository {
    loadNextPhotosPage();

    _scrollStreamController.stream
        .debounceTime(const Duration(milliseconds: 1000))
        .listen((event) {loadNextPhotosPage();});
  }

  Stream<List<UnsplashPhoto>?> get photosList => _photosListSubject.stream;

  StreamSink get scrollStreamSink => _scrollStreamController.sink;
  int _nextPageNumber = 1;

  void loadNextPhotosPage() async {
    try {
      List<UnsplashPhoto> uploadedPhotos =
          await _photosRepository.loadPhotos(page: _nextPageNumber);
      _nextPageNumber++;

      _addPhotosToStream(uploadedPhotos);
    } catch (err, stack) {
      if (kDebugMode) {
        print(err);
        print(stack);
      }
    }
  }

  void _addPhotosToStream(List<UnsplashPhoto> newPhotos) {
    List<UnsplashPhoto>? initialPhotos = _photosListSubject.valueOrNull;

    if (initialPhotos != null) {
      _photosListSubject.add(initialPhotos + newPhotos);
    } else {
      _photosListSubject.add(newPhotos);
    }
  }

  void dispose() {
    _photosListSubject.close();
  }
}
