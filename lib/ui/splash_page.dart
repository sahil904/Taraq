import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/res/styles.dart';
import 'package:test/ui/login/login_widget.dart';
import 'package:test/utils/pref_utils.dart';
import 'package:test/utils/utils.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var splashDuration = 2000;
  double screenHeight;
  double screenWidth;
  String userId;

  @override
  void initState() {
    super.initState();

    startCountdownTimer();

    Utils.hideKeyBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: splashCenterWidget());
  }

  Widget splashCenterWidget() {
    return Stack(
      children: [
        Center(
          child: Container(
            color: AppColors.textPrimaryColor9,
            child: Center(
              child: Text(
                "Spalsh here",
                style: tsBoldTextWhite22,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Timer> startCountdownTimer() async {
    final _duration = Duration(milliseconds: splashDuration);
    return Timer(_duration, navigateToPage);
  }

  void navigateToPage() {
    if (PrefUtils.isLoggedIn()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => NavBarPage(),
        ),
        (r) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginWidget(),
        ),
        (r) => false,
      );
    }
  }
}
