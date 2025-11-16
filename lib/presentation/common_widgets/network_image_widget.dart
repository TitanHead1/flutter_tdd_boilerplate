import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/api_constants.dart';
import '../config/app_color.dart';


class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  const NetworkImageWidget({super.key, required this.imageUrl,required this.fit});

  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      imageUrl: imageUrl.startsWith("http")
          ? imageUrl
          : ApiConstants.imageBaseUrl+imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.3),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: AppColor.shimmerBaseColor,
        highlightColor: AppColor.shimmerHighlightColor,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
