import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageView extends StatelessWidget {
  final String? imageUrl;
  final Widget? placeholder;
  final String defaultImage;
  final bool isLocal;

  const ImageView({
    this.imageUrl,
    this.placeholder,
    this.defaultImage = "",
    this.isLocal = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return placeholder ?? _defaultImage;
    }

    if (isLocal) {
      return Image.file(
        File(imageUrl ?? ""),
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      errorWidget: (context, url, error) {
        return placeholder ?? _defaultImage;
      },
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        );
      },
      fit: BoxFit.cover,
    );
  }

  Widget get _defaultImage => Opacity(
        opacity: 0.5,
        child: SvgPicture.asset(
          defaultImage,
          fit: BoxFit.contain,
        ),
      );
}
