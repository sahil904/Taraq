import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test/res/app_colors.dart';

class CircularImageView extends StatelessWidget {
  CircularImageView({
    @required this.url,
    this.height = 84,
    this.width = 84,
    @required this.callBack,
    this.errorAssetSvgImage,
    this.showWhiteBorder = true,
  });

  final double width;
  final double height;
  String url;
  final bool showWhiteBorder;
  final Function callBack;
  final String errorAssetSvgImage;

  @override
  Widget build(BuildContext context) {
    url ??= '';

    return GestureDetector(
        onTap: () {
          callBack();
        },
        child: CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: showWhiteBorder ? 2.0 : 0.0,
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: url == null ? null : CachedNetworkImageProvider(url)))),
            placeholder: (context, url) => errorAssetSvgImage == null
                ? Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.white,
                    direction: ShimmerDirection.rtl,
                    period: const Duration(milliseconds: 1000),
                    child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                              width: showWhiteBorder ? 2.0 : 0.0,
                            ))))
                : Container(
                    width: width,
                    height: height,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorTransparent,
                              border: Border.all(
                                color: Colors.white,
                                width: showWhiteBorder ? 2.0 : 0.0,
                              )),
                        ),
                        Image.asset(errorAssetSvgImage, width: width, height: height),
                      ],
                    ),
                  ),
            errorWidget: (context, url, error) => errorAssetSvgImage == null
                ? Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                        color: AppColors.dark_grey_blue,
                        borderRadius: BorderRadius.all(Radius.circular(width / 2)),
                        border: Border.all(
                          color: Colors.white,
                          width: showWhiteBorder ? 2.0 : 0.0,
                        )))
                : Container(
                    width: width,
                    height: height,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorTransparent,
                              border: Border.all(
                                color: Colors.white,
                                width: showWhiteBorder ? 2.0 : 0.0,
                              )),
                        ),
                        Image.asset(errorAssetSvgImage, width: width, height: height),
                      ],
                    ),
                  )));
  }
}

class CircularImageViewNamePlaceHolder extends StatelessWidget {
  CircularImageViewNamePlaceHolder({
    @required this.url,
    @required this.callBack,
    @required this.name,
    this.size = 84,
    this.showWhiteBorder = true,
    this.backgroundColor = AppColors.textGrey4,
    this.textColor = AppColors.textPrimaryColor,
  });

  final double size;
  String url;
  final String name;
  final bool showWhiteBorder;
  final Function callBack;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    url ??= '';
    return GestureDetector(
        onTap: () {
          if (callBack != null) callBack();
        },
        child: CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: showWhiteBorder ? 2.0 : 0.0,
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: CachedNetworkImageProvider(url)))),
            placeholder: (context, url) => Container(
                  width: size,
                  height: size,
                  child: Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: backgroundColor,
                        border: Border.all(
                          color: Colors.white,
                          width: showWhiteBorder ? 2.0 : 0.0,
                        )),
                    child: Text(
                      getInitials(name),
                      style: TextStyle(
                          color: textColor, fontSize: size * .323, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => Container(
                  width: size,
                  height: size,
                  child: Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: backgroundColor,
                        border: Border.all(
                          color: Colors.white,
                          width: showWhiteBorder ? 2.0 : 0.0,
                        )),
                    child: Text(
                      getInitials(name),
                      style: TextStyle(
                          color: textColor, fontSize: size * .323, fontWeight: FontWeight.w700),
                    ),
                  ),
                )));
  }

  String getInitials(String name) {
    try {
      return name.isNotEmpty
          ? name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
          : '';
    } catch (e) {
      return 'NA';
    }
  }
}
