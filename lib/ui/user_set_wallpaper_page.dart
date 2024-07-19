import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:set_wallpaper_demo/ui/wallpapper_model.dart';

class UserSetWallpaperScreen extends StatefulWidget {
  const UserSetWallpaperScreen({super.key});

  @override
  State<UserSetWallpaperScreen> createState() => _UserSetWallpaperScreenState();
}

class _UserSetWallpaperScreenState extends State<UserSetWallpaperScreen> {
  late Future<List<WallpaperModel>> futureWallpaper;
  WallpaperModel? wallpaper;

  @override
  void initState() {
    // futureWallpaper = WallpaperService.fetchWallpapers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/back_icon.svg",
            ),
          ),
        ),
        title: const Text(
          "User Set Wallpaper",
          style: TextStyle(
            fontFamily: "Satoshi",
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  "https://i.postimg.cc/NMRnRF9R/shingeki-no-kyojin-mikasa-ackerman-v0-g0la70na575d1.webp",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          _buildSetWallPaperButton(),
          // child:
          // Expanded(
          //   child: FutureBuilder<List<WallpaperModel>>(
          //     future: futureWallpaper,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator());
          //       } else if (snapshot.hasError) {
          //         return const Center(
          //             child: Text("Failed to load Wallpaper data"));
          //       } else {
          //         List<WallpaperModel>? wallpapers = snapshot.data;
          //         return GridView.builder(
          //             itemCount: wallpapers?.length,
          //             gridDelegate:
          //                 const SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               // childAspectRatio: (1 / .4),
          //             ),
          //             itemBuilder: (context, index) {
          //               return GestureDetector(
          //                 onTap: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => WallpaperDetail(
          //                         wallpapers[index],
          //                       ),
          //                     ),
          //                   );
          //                 },
          //                 child: CachedNetworkImage(
          //                     imageUrl: wallpapers![index].thumbnailUrl,
          //                     placeholder: (context, url) => const Center(
          //                             child: SizedBox(
          //                           width: 80.0,
          //                           height: 80.0,
          //                           child: CircularProgressIndicator(),
          //                         )),
          //                     errorWidget: (context, url, error) =>
          //                         const Icon(Icons.error),
          //                     fit: BoxFit.cover),
          //               );
          //             });
          //       }
          //     },
          //   ),
          // ),
          // )
          // _buildSetWallPaperButton(),
        ],
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
          setAsWallpaper("assets/wallpapers/image.webp");
        },
        child: const Text(
          "Set WallPaper",
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

        // await platform.invokeMethod('setWallpaper', bytes);
      } else {
        throw Exception('Downloading image failed!');
      }
    } on PlatformException catch (e) {
      print("Failed to set wallpaper: '${e.message}'");
    }
  }
}
