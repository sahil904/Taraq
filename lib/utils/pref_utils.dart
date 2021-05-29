import 'package:test/utils/shared_preferences.dart';

import 'constants.dart';

// ignore: avoid_classes_with_only_static_members
class PrefUtils {
  static void setUserToken(String token) {
    Prefs.prefs?.setString(SharedPrefsKeys.USER_TOKEN, token);
  }

  static String getUserToken() {
    final String value = Prefs.prefs?.getString(SharedPrefsKeys.USER_TOKEN);
    return value ?? '';
  }

  static void setDevicesId(String token) {
    Prefs.prefs?.setString(SharedPrefsKeys.USER_DEVICE_ID, token);
  }

  static String getDevicesId() {
    final String value = Prefs.prefs?.getString(SharedPrefsKeys.USER_DEVICE_ID);
    return value ?? '';
  }


  static void setUserFavCount(String count) {
    Prefs.prefs?.setString(SharedPrefsKeys.USER_FAV_COUNT, count);
  }

  static String getUserFavCount() {
    final String value = Prefs.prefs?.getString(SharedPrefsKeys.USER_FAV_COUNT);
    return value ?? '';
  }

  static void setFirstTimeLaunch(bool firstTimeLaunch) {
    Prefs.prefs?.setBool(SharedPrefsKeys.FIRST_TIME_LAUNCH, firstTimeLaunch);
  }

  static bool isFirstTimeLaunch() {
    final bool value = Prefs.prefs?.getBool(SharedPrefsKeys.FIRST_TIME_LAUNCH) ?? true;
    return value ?? true;
  }

  static bool isLoggedIn() {
    return Prefs.prefs?.getString(SharedPrefsKeys.USER_TOKEN) != null ?? false;
  }
}
