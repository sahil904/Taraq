import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageLoading extends StatelessWidget {
  const ShimmerImageLoading(
      {Key key, @required this.imageUrl, @required this.height, @required this.width})
      : super(key: key);

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        fit: BoxFit.cover,
        height: height,
        placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white,
            direction: ShimmerDirection.rtl,
            period: const Duration(milliseconds: 1000),
            child: Container(
              color: Colors.cyan,
              width: width,
              height: height,
            )),
        errorWidget: (context, url, error) => Icon(Icons.error, size: height));
  }
}
