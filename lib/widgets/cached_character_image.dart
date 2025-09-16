import 'package:cached_network_image/cached_network_image.dart';
import 'package:eff_mob_tes_app/data/const.dart';
import 'package:flutter/material.dart';

class CachedCharacterImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CachedCharacterImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: (context, url) => Container(
        color: Color(kColorImageCache),
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        color: Color(kColorImageCache),
        child: const Icon(Icons.error),
      ),
      memCacheWidth: (width ?? kCharacterImageWidth).toInt(),
      memCacheHeight: (height ?? kCharacterImageHeight).toInt(),
    );
  }
}
