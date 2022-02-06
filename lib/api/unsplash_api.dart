import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

import 'package:qulisoft_test_task/api/url_helper.dart';

class UnsplashApi {
  final _httpClient = http.Client();
  final String userToken =
      "ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9";

  Future<List<Map<String, dynamic>>> loadPhotos({required int page}) async {
    Uri uri = Uri.https(UrlHelper.baseUrl, UrlHelper.photos,
        UrlHelper.getPhotosQuery(userToken: userToken, page: page));

    final httpResponse = await _httpClient.get(
      uri,
      headers: UrlHelper.getRequestHeaders(),
    );

    if (httpResponse.statusCode < 200 || httpResponse.statusCode > 299) {
      throw 'fetch photos error';
    }
    final decodedBody = jsonDecode(httpResponse.body) as List<dynamic>;
    return decodedBody.map((e) => e as Map<String, dynamic>).toList();
  }
}
