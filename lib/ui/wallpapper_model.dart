class WallpaperModel {
  final String category;
  final String name;
  final String thumbnailUrl;
  final String imageUrl;

  WallpaperModel(
      {required this.category,
      required this.name,
      required this.thumbnailUrl,
      required this.imageUrl});

  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
        category: json['category'],
        name: json['namge'],
        thumbnailUrl: json['thumbnailUrl'],
        imageUrl: json['imageUrl']);
  }
}
// class Wallpaper {
//   final String category;
//   final String name;
//   final String imageUrl;
//   final bool isAsset;
//
//   Wallpaper({
//     required this.category,
//     required this.name,
//     required this.imageUrl,
//     this.isAsset = false,
//   });
//
//   factory Wallpaper.fromJson(Map<String, dynamic> json) {
//     return Wallpaper(
//       category: json['category'],
//       name: json['name'],
//       imageUrl: json['imageUrl'],
//       isAsset: json['isAsset'] ?? false,
//     );
//   }
// }
