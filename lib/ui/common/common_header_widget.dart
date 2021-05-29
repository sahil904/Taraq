import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/res/styles.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/utils/AppAssets.dart';

class CommonHeaderWidget extends StatelessWidget {
  final String heading;

  const CommonHeaderWidget({Key key, @required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              Row(
                children: [
                  TransparentInkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(left: 15, top: 3),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      heading,
                      style: tsBoldTextWhite18,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 7.5, right: 7.5),
                          child: SvgPicture.asset(
                            AppAssets.notification,
                            //   color: AppColors.white,
                          )),
                      Container(
                          margin: const EdgeInsets.only(left: 7.5, right: 7.5),
                          child: Image.asset(
                            AppAssets.menu,
                            height: 20,
                            //   color: AppColors.white,
                          )),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
