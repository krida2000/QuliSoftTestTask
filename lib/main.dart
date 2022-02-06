import 'package:flutter/material.dart';

import 'package:qulisoft_test_task/widgets/photos_list_screen/photos_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotosListScreen(),
    );
  }
}
