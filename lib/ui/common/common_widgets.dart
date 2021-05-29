import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test/model/error_response.dart';

import 'package:test/res/app_colors.dart';
import 'package:test/res/styles.dart';

class HalfLoader extends StatelessWidget {
  const HalfLoader({this.color = AppColors.primaryColor, this.size = 50.0});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitChasingDots(
      size: size,
      color: color,
    ));
  }

}
class ErrorPageWidget extends StatelessWidget {
  final ErrorResponse error;

  ErrorPageWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
              text: TextSpan(
                text: error.error.message,
                style: tsBoldTextDarkGrey22,
              ),
              textAlign: TextAlign.center,
            )));
  }
}



