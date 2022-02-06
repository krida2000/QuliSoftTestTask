import 'package:flutter/material.dart';
import 'package:qulisoft_test_task/models/unsplash_photo.dart';
import 'package:qulisoft_test_task/repos/photos_repository.dart';
import 'package:qulisoft_test_task/widgets/large_photo_screen/large_photo_screen.dart';
import 'package:qulisoft_test_task/widgets/photos_list_screen/photo_container.dart';
import 'package:qulisoft_test_task/widgets/photos_list_screen/photos_list_screen_bloc.dart';

class PhotosListScreen extends StatefulWidget {
  const PhotosListScreen({Key? key}) : super(key: key);

  @override
  State<PhotosListScreen> createState() => _PhotosListScreenState();
}

class _PhotosListScreenState extends State<PhotosListScreen> {
  final PhotosListScreenBloc imageListScreenBloc = PhotosListScreenBloc(
    photosRepository: PhotosRepository(),
  );
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galery"),
      ),
      body: StreamBuilder<List<UnsplashPhoto>?>(
          stream: imageListScreenBloc.photosList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              controller: controller,
              cacheExtent: 8000,
              key: const Key("photosListView"),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LargePhotoScreen(
                              unsplashPhoto: snapshot.data![index])));
                },
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: PhotoContainer(
                    key: Key(snapshot.data![index].id),
                    unsplashPhoto: snapshot.data![index],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      imageListScreenBloc.scrollStreamSink.add(null);
    }
  }
}
