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
import 'flutter_flow/flutter_flow_theme.dart';

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
    return Container(
      color: FlutterFlowTheme.primaryColor,
      child: Center(
        child: Column(

mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Projects",
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

             SizedBox(height: 20,),

            SizedBox(
              child: CircularProgressIndicator(),
              height: 30.0,
              width: 30.0,

            ),          ],
        ),
      ),
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
