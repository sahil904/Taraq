// ignore: avoid_classes_with_only_static_members
import 'package:test/res/styles.dart';

class KGlobal {
  // ignore: non_constant_identifier_names

  //Global constants
  static const TIME_OUT_DURATION = Duration(seconds: 10);
  static const CONNECT_TIMEOUT = 10000;
  static const RECEIVE_TIMEOUT = 30000;
}

class KPrefs {
  //Pref Constants
  static const TOKEN = 'token';
  static const IS_LOGGED_IN = 'is_logged_in';
  static const APP_NAME = 'Quit Experts';

  static const USER_ID = 'user_id';
  static const USER_EMAIL = 'user_email';
  static const USER_NAME = 'user_name';
  static const FCM_TOKEN = 'fcm_token';
}

class KReqHeaders {
  static const AUTHORIZATION = 'Token';
  static const DEVICE_TYPE = 'device_type';
  static const PLATFORM = 'Platform';
}

class KApiResponseCodes {
  static const int STATUS_SERVICE_UNAVAILABLE = 503;
}

class KApiBase {
  static const BASE_URL = 'https://taraqapp.herokuapp.com/api/auth/';
}

class KApiEndPoints {
  static const API_LOGIN = 'login';
}

class KDateFormats {
  static const DATE_FORMAT_1 = 'yyyy-MM-dd';
  static const DATE_FORMAT_2 = 'yyyy/MM/dd';
  static const DATE_FORMAT_3 = 'dd/MM/yyyy';
  static const DATE_FORMAT_4 = 'EEEE, d MMMM';
  static const DATE_FORMAT_5 = "d' 'MMM' '''yy";
  static const DATE_FORMAT_6 = 'dd MMM';
  static const DATE_FORMAT_7 = 'hh:mm a';
  static const DATE_FORMAT_8 = 'EEEE, MMMM d';
  static const DATE_FORMAT_9 = 'MMMM yyyy';
  static const DATE_FORMAT_10 = 'ddMMyy';
}

class SharedPrefsKeys {
  static const USER_ID = 'TOKEN';
  static const USER_LOGGED_IN = 'USER_LOGGED_IN';
  static const USER_TOKEN = 'USER_TOKEN';
  static const USER_DEVICE_ID = 'devices_id';
  static const FIRST_TIME_LAUNCH = 'first_time_launch';
  static const CART_ITEM_COUNT = "user_data";
  static const USER_ACCESS_KEY = 'access_key';
  static const USER_CART_COUNT = 'cart_count';
  static const USER_FAV_COUNT = 'fav_count';
  static const PRIVACY_POLICY = 'privacy_policy';
  static const TERMS_CONDITION = 'terms_condition';
  static const CONTACT_US = 'contact_us';
  static const ABOUT_US = 'about_us';
}

class Miscellaneous {
  static final double bottomTabBarHeight = isIOS ? 85 : 84;
}

class KNotificationTypes {
  static const POST_REACTION = 'Order';
  static const NOTIFICATION = 'Notification';
  static const FOLLOW = 'follow';
}
