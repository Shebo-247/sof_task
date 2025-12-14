import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sof_task/core/widgets/shimmer_widget.dart';
import 'package:sof_task/gen/assets.gen.dart';

class CustomCachedImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomCachedImageWidget({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      height: height ?? 60,
      width: width ?? 60,
      errorWidget: (context, url, error) =>
          errorWidget ??
          Assets.images.placeholder.image(
            height: height ?? 60,
            width: width ?? 60,
            fit: fit ?? BoxFit.contain,
          ),
      placeholder: (context, url) =>
          placeholder ?? ShimmerWidget(height: height ?? 60),
      fit: fit ?? BoxFit.contain,
    );
  }
}
