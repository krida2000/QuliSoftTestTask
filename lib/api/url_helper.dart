class UrlHelper {
  static String get baseUrl => 'api.unsplash.com';
  static String get photos => "/photos/";

  static Map<String, String> getPhotosQuery(
          {required String userToken, required int page}) =>
      {
        if (userToken.isNotEmpty) "client_id": userToken,
        "page": "$page",
      };

  static Map<String, String> getRequestHeaders() =>
      {
        "Content-Type": "application/json",
      };
}
