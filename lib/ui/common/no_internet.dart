import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test/res/styles.dart';

import 'package:test/res/app_colors.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({
   // @required this.onRetryClick,
    Key key}) : super(key: key);

  //final  Future<bool> onRetryClick;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: AppColors.white),
            child: SafeArea(
              bottom: false,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height:
                              TextStyles.isBigScreen ? screenHeight * .204 : screenHeight * .15),
                      SvgPicture.asset('assets/images/no_internet_connection.svg',
                          height: TextStyles.isBigScreen ? screenHeight * .22 : screenHeight * .27),
                      SizedBox(
                          height:
                              TextStyles.isBigScreen ? screenHeight * .036 : screenHeight * .044),
                      Text("No Internet Connection", style: tsSemiBoldTextPink13),
                      const SizedBox(height: 12),
                      Text(
                        "Please check your internet connection\nagain, or connect to a WiFi",
                        textAlign: TextAlign.center,
                        style: tsSemiBoldTextPink15,
                      )
                    ],
                  ),
                  // Visibility(
                  //   visible: false,
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: PrimaryButton(
                  //       buttonText: 'Retry',
                  //       onButtonPressed: (){
                  //      //   onRetryClick;
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
