import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:set_wallpaper_demo/ui/wallpapper_model.dart';

const platform = MethodChannel('com.example.i_secure_user_app');

class WallpaperDetail extends StatelessWidget {
  final WallpaperModel wallpaper;

  const WallpaperDetail(this.wallpaper, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("${wallpaper.name} (${wallpaper.category})")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: wallpaper.imageUrl,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              _buildSetWallPaperButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSetWallPaperButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Colors.blue,
          ),
        ),
        onPressed: () {
          setAsWallpaper(wallpaper.imageUrl);
        },
        child: const Text(
          "User Set WallPaper",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> setAsWallpaper(String imageUrl) async {
    try {
      // download image
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Convert response body to Uint8List
        Uint8List bytes = response.bodyBytes;

        await platform.invokeMethod('setWallpaper', bytes);
      } else {
        throw Exception('Downloading image failed!');
      }
    } on PlatformException catch (e) {
      print("Failed to set wallpaper: '${e.message}'");
    }
  }
}
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
// import 'package:i_secure_user_app/ui/customer_list/wallpapper_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class WallpaperDetail extends StatelessWidget {
//   final Wallpaper wallpaper;
//
//   const WallpaperDetail(this.wallpaper, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(wallpaper.name),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: wallpaper.isAsset
//                 ? Image.asset(wallpaper.imageUrl, fit: BoxFit.cover)
//                 : Image.network(wallpaper.imageUrl, fit: BoxFit.cover),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Add your method to set wallpaper here
//               setWallpaper(wallpaper.imageUrl, wallpaper.isAsset, context);
//             },
//             child: const Text('Set as Wallpaper'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void setWallpaper(String imageUrl, bool isAsset, BuildContext context) async {
//     try {
//       WallpaperManager.setWallpaperFromFile(
//         isAsset
//             ? await _getImageFileFromAssets(imageUrl)
//             : await _getImageFileFromNetwork(imageUrl),
//         WallpaperManager.HOME_SCREEN,
//       );
//
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Wallpaper set successfully')));
//     } catch (e) {
//       // Show error message
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Failed to set wallpaper: $e')));
//     }
//   }
//
//   Future<String> _getImageFileFromAssets(String assetPath) async {
//     final ByteData assetByteData = await rootBundle.load(assetPath);
//     final Uint8List assetBytes = assetByteData.buffer.asUint8List();
//     final String tempPath = (await getTemporaryDirectory()).path;
//     final String filePath =
//         '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
//     final File file = await File(filePath).writeAsBytes(assetBytes);
//     return file.path;
//   }
//
//   Future<String> _getImageFileFromNetwork(String imageUrl) async {
//     final http.Response response = await http.get(Uri.parse(imageUrl));
//     final Uint8List networkBytes = response.bodyBytes;
//     final String tempPath = (await getTemporaryDirectory()).path;
//     final String filePath =
//         '$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
//     final File file = await File(filePath).writeAsBytes(networkBytes);
//     return file.path;
//   }
// }
