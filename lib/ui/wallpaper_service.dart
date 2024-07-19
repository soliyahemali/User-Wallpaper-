import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:set_wallpaper_demo/ui/wallpapper_model.dart';

const String imageWallpaperUrl =
    "https://raw.githubusercontent.com/rahuldshetty/flutter-wallpaper-app/master/wallpaper_collection/wallpaper_data_v1.json";

class WallpaperService {
  static Future<List<WallpaperModel>> fetchWallpapers() async {
    // Read JSON data from remote location
    final response = await http.get(Uri.parse(imageWallpaperUrl));

    if (response.statusCode == 200) {
      // Load wallpaper data into Object structure
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => WallpaperModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
}

// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:i_secure_user_app/ui/customer_list/wallpapper_model.dart';
//
// class WallpaperService {
//   static Future<List<Wallpaper>> fetchWallpapers() async {
//     try {
//       final String response =
//           await rootBundle.loadString('assets/json/wallpaper_data.json');
//       final data = await json.decode(response) as List<dynamic>;
//       return data.map((json) => Wallpaper.fromJson(json)).toList();
//     } catch (e, s) {
//       print("=====>$e$s<==========");
//     }
//     return [];
//   }
// }
