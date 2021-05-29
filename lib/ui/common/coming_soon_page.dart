import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/res/app_colors.dart';

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text('Feature is coming soon...',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
