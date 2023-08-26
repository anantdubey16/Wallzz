// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_new, avoid_print, avoid_function_literals_in_foreach_calls, file_names, duplicate_ignore

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallzz/model/categoryModel.dart';
import 'package:wallzz/model/photosmodel.dart';

class ApiOperations {
  static List<Photosmodel> trendingWallpapers = [];
  static List<Photosmodel> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static Future<List<Photosmodel>> getTrendingWallpapers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"), headers: {
      "Authorization":
          "563492ad6f917000010000015b353b1bc7434819917802c5d15ad2f5"
    }).then((value) {
      Map<String, dynamic> jasonData = jsonDecode(value.body);
      List photos = jasonData['photos'];
      for (var element in photos) {
        trendingWallpapers.add(Photosmodel.FromAPI2App(element));
      }
    });
    return trendingWallpapers;
  }

  static Future<List<Photosmodel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {
          "Authorization":
              "563492ad6f917000010000015b353b1bc7434819917802c5d15ad2f5"
        }).then((value) {
      Map<String, dynamic> jasonData = jsonDecode(value.body);
      List photos = jasonData['photos'];
      searchWallpapersList.clear();
      for (var element in photos) {
        searchWallpapersList.add(Photosmodel.FromAPI2App(element));
      }
    });
    return searchWallpapersList;
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();

    final _random = new Random();

    for (String catName in cateogryName) {
      List<Photosmodel> wallpapers = await searchWallpapers(catName);
      if (wallpapers.isNotEmpty) {
        Photosmodel photoModel = wallpapers[_random.nextInt(wallpapers.length)];
        print("IMG SRC IS HERE");
        print(photoModel.imgSrc);
        cateogryModelList
            .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
      }
    }
    return cateogryModelList;
  }
}
