import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/custom_views/custom_overlays.dart';
import 'package:test/custom_views/route_animations.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/res/strings.dart';
import 'package:test/res/styles.dart';
import 'package:test/ui/login/login_widget.dart';
import 'package:test/utils/constants.dart';
import 'log.dart';
// import 'package:connectivity/connectivity.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static BuildContext _loaderContext;
  static BuildContext _loadingDialoContext;
  static bool _isLoaderShowing = false;
  static bool _isLoadingDialogShowing = false;
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;
  //MediaQuery.of(context).size.width;

//  Checks
  static bool isNotEmpty(String s) {
    return s != null && s.trim().isNotEmpty;
  }

  // static Future<bool> check() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }


  static Future<void> logout(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
          (r) => false,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static bool isEmpty(String s) {
    return !isNotEmpty(s);
  }

  static bool isListNotEmpty(List<dynamic> list) {
    return list != null && list.isNotEmpty;
  }

  //  Views
  static void showToast(BuildContext context, String message) {
    showCustomToast(context, message);
  }

  static void showSuccessMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: AppColors.snackBarGreen);
  }

  static void showNeutralMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: AppColors.snackBarColor);
  }

  static void showErrorMessage(BuildContext context, String message) {
    showCustomToast(context, message);
  }

  static void showValidationMessage(BuildContext context, String message) {
    Log.info('Toast message : ' + message);
    showCustomToast(context, message);
  }


  static void showCustomToast(BuildContext context, String message,
      {Color bgColor = AppColors.snackBarRed}) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, bgColor);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(const Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static void showLoader(BuildContext context) {
    if (!_isLoaderShowing) {
      _isLoaderShowing = true;
      _loaderContext = context;
      showDialog(
          context: _loaderContext,
          barrierDismissible: false,
          builder: (context) {
            return SpinKitChasingDots(
              color: AppColors.primaryColor,
            );
          }).then((value) => {_isLoaderShowing = false, Log.info('Loader hidden!')});
    }
  }

  static void showLoadingDialog(BuildContext context) {
    if (!_isLoadingDialogShowing) {
      _isLoadingDialogShowing = true;
      _loadingDialoContext = context;
      showDialog(
          context: _loadingDialoContext,
          barrierDismissible: false,
          builder: (context) {
            return SpinKitChasingDots(
              color: AppColors.pinkColor,
            );
          }).then((value) => {_isLoadingDialogShowing = false, Log.info('LoadingDialog hidden!')});
    }
  }

  // static Future<File> compressAndGetFile(File file) async {
  //   final dir = await path_provider.getTemporaryDirectory();
  //   final targetPath =
  //       dir.absolute.path + "/" + DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
  //
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: 88,
  //     rotate: 0,
  //   );
  //
  //   print(file.lengthSync());
  //   print(result.lengthSync());
  //
  //   return result;
  // }

  static void hideLoader() {
    if (_isLoaderShowing && _loaderContext != null) {
      Navigator.pop(_loaderContext);
      _loaderContext = null;
    }
  }

  static void hideLoadingDialog() {
    if (_isLoadingDialogShowing && _loadingDialoContext != null) {
      Navigator.pop(_loadingDialoContext);
      _loadingDialoContext = null;
    }
  }

  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static ThemeData getAppThemeData() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        brightness: Brightness.light,
      ),
      canvasColor: Colors.transparent,
      primarySwatch: AppColors.primary_color,
      fontFamily: font_gilroy,
      brightness: Brightness.light,
    );
  }

  static DateTime convertDateFromString(String strDate) {
    DateTime date = DateTime.parse(strDate);
    // var formatter = new DateFormat('yyyy-MM-dd');
    return date;
  }

  static Future<bool> onWillPop(BuildContext context) {
    final DateTime now = DateTime.now();
    DateTime currentBackPressTime;
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Utils.showToast(context, 'Press again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }


  Future<String> sessionCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString(SharedPrefsKeys.USER_ID);
    // print("userIdNewProducts " + userId);
    return prefs.getString(SharedPrefsKeys.USER_ID);
  }
  Future<String> sessionAccessKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getString(SharedPrefsKeys.USER_ACCESS_KEY);
    // print("userIdNewProducts " + userId);
    return prefs.getString(SharedPrefsKeys.USER_ACCESS_KEY);
  }

  Future<int> sessionCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getInt(SharedPrefsKeys.CART_ITEM_COUNT);
    // print("userIdNewProducts " + userId);
    return prefs.getInt(SharedPrefsKeys.CART_ITEM_COUNT);
  }

  Future<int> sessionFavCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.getInt(SharedPrefsKeys.USER_FAV_COUNT);
    // print("userIdNewProducts " + userId);
    return prefs.getInt(SharedPrefsKeys.USER_FAV_COUNT);
  }


  somethingWentWrong() {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie.asset('assets/images/went_wrong.json'),
          Text(
            " Something went wrong! ",
            style: tsSemiBoldTextDarkGrey20,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Brace yourself till get the error fixed",
            style: tsSemiBoldTextDarkGrey16,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "You may also refresh the page or try again later",
            style: tsSemiBoldTextDarkGrey16,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),

          // Container(
        ],
      )),
    );
  }

  Widget noItemInCartList() {
    return Container(
      color: AppColors.white1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No Data found',
              style: tsSemiBoldTextDarkGrey20,
            ),
          ),
        ],
      ),
    );
  }


}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }


}
