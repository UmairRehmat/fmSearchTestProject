import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fmsearcfeature/models/album_response.dart';
import 'package:fmsearcfeature/utilities/network_constants.dart';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  List<Album?> albums = [];
  String albumsKeyword = "";
  Future<List<Album?>> getResults(String? search) async {
    if (albums.length == 0 && search != albumsKeyword) {
      try {
        AlbumResponse albumResponse = await getAlbumList(search!);
        print("length of response");
        print(albumResponse.results?.albummatches?.album);

        albums = albumResponse.results?.albummatches?.album ?? [];
      } catch (error) {
        print("Error:${error.toString()}");
      }
    }
    print(albums.length);
    return albums;
  }

  Future getAlbumList(String search) async {
    try {
      String url = "$BASE_URL$albumSearchApi$search";
      print('URL: $url');

      var response = await http.get(Uri.parse(url));
      print('category Response status: ${response.statusCode}');
      print('category Response body: ${response.body}');
      if (response.statusCode == 200) {
        return AlbumResponse.fromJson(json.decode(response.body));
      } else
        return "Error Code ${response.statusCode} ${json.decode(response.body)['message']}";
    } catch (error) {
      return "Error Code${error.toString()}";
    }
  }
}
