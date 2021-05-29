import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test/res/strings.dart';

import 'app_colors.dart';

final bool isIOS = Platform.isIOS;

bool get isWeb => kIsWeb;

bool get isMobile => !isWeb && (Platform.isIOS || Platform.isAndroid);

bool get isDesktop =>
    !isWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

bool get isApple => !isWeb && (Platform.isIOS || Platform.isMacOS);

bool get isGoogle => !isWeb && (Platform.isAndroid || Platform.isFuchsia);

class TextStyles {
  static bool isSmallScreen = false;
  static bool isBigScreen = false;
  static const smallHeightParameterInPixels = 700;

  static void setScreenSize(bool isSmall) {
    isSmallScreen = isSmall;
    isBigScreen = !isSmall;
  }
}

//Medium Styles
const tsMediumHeadingGrey1 = TextStyle(
    color: AppColors.textGrey1, fontSize: 22.0, fontWeight: FontWeight.w500);

final tsDarkGreyBlueBoldTs16 = TextStyle(
    color: AppColors.dark_grey_blue_40,
    fontSize: 16,
    height: 1.5,
    fontFamily: font_gilroy,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1);

final tsDarkGreyBlue60BoldTs16 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontSize: 16,
    height: 1.5,
    fontFamily: font_gilroy,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1);

final tsDarkGreyBlueBoldTs14 = TextStyle(
    color: AppColors.dark_grey_blue_40,
    fontSize: 14,
    fontFamily: font_gilroy,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.18);

final tsGreyBlueBoldTs14 = TextStyle(
  color: AppColors.dark_grey_blue,
  fontSize: 14,
  fontFamily: font_gilroy,
  height: 1.5,
  fontWeight: FontWeight.w500,
);

final tsDarkGreyBlue60BoldTs14 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontSize: 14,
    fontFamily: font_gilroy,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.18);

//Bold Styles

const tsDarkGreyBlueBoldTs26 = TextStyle(
    color: AppColors.dark_grey_blue,
    fontFamily: font_gilroy,
    fontSize: 26,
    fontWeight: FontWeight.w700);

const tsDarkGreyBlueBoldTs24 = TextStyle(
    color: AppColors.dark_grey_blue,
    fontSize: 24,
    height: 1.5,
    fontFamily: font_gilroy,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.09);

const tsDarkGreyBlueBoldTs22 = TextStyle(
  color: AppColors.dark_grey_blue,
  fontSize: 22,
  fontFamily: font_gilroy,
  fontWeight: PoppinsBold,
);

const tsBoldButtonPrimary1 = TextStyle(
    color: AppColors.textGrey1,
    fontFamily: font_gilroy,
    fontSize: 18.0,
    fontWeight: FontWeight.w700);
const tsBoldButtonBlack20 = TextStyle(
    color: AppColors.black,
    fontFamily: font_gilroy,
    fontSize: 20.0,
    fontWeight: FontWeight.w700);

const tsMediumTextLightGrey16 = TextStyle(
    color: AppColors.primaryColor,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsMediumTextLight60Grey16 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGrey60Primary16 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGrey50Primary12 = TextStyle(
    color: AppColors.textPrimaryColor50,
    fontFamily: font_gilroy,
    fontSize: 12.0,
    fontWeight: FontWeight.w500);

const tsMediumTextBlue50Primary12 = TextStyle(
    color: AppColors.textPrimaryColor9,
    fontFamily: font_gilroy,
    fontSize: 12.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGrey50Primary14 = TextStyle(
    color: AppColors.textPrimaryColor50,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsMediumTextBlack50Primary14 = TextStyle(
    color: AppColors.black,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsMediumTextRed50Primary14 = TextStyle(
    color: AppColors.snackBarRed,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGreen50Primary14 = TextStyle(
    color: AppColors.greenColor,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGreyPrimary12 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 12.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGrey40Primary16 = TextStyle(
    color: AppColors.textPrimaryColor40,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);

const tsMediumTextDarkGrey16 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);

const tsSemiBoldTextDarkBlue15 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 15.0,
    fontWeight: FontWeight.w600);

const tsSemiBoldTextGrey13 = TextStyle(
    color: AppColors.textGrey5,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w600);

const tsBoldTextGrey13 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w700);

const tsMediumTextGrey13 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGrey15 = TextStyle(
    color: AppColors.textPrimaryColor60,
    fontFamily: font_gilroy,
    fontSize: 15.0,
    fontWeight: FontWeight.w500);

const tsSemiBoldTextGreen13 = TextStyle(
    color: AppColors.greenColor,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w600);
const tsSemiBoldTextGreen16 = TextStyle(
    color: AppColors.greenColor,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w600);

const tsSemiBoldTextDarkGrey18 = TextStyle(
  color: AppColors.black,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  fontFamily: font_gilroy,
);
const tsSemiBoldTextDarkGrey16 = TextStyle(
    color: AppColors.black,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w600);
const tsSemiBoldTextPrimary16 = TextStyle(
    color: AppColors.primary_color,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsSemiBoldTextDarkGrey20 = TextStyle(
    color: AppColors.black,
    fontFamily: font_gilroy,
    fontSize: 20.0,
    fontWeight: FontWeight.w600);

const tsSemiBoldTextDarkGrey15 = TextStyle(
    color: AppColors.black,
    fontFamily: font_gilroy,
    fontSize: 15.0,
    fontWeight: FontWeight.w600);
const tsSemiBoldTextDarkGrey13 = TextStyle(
    color: AppColors.black,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w600);
const tsSemiBoldTextDarkGrey12 = TextStyle(
    color: AppColors.black,
    fontFamily: font_gilroy,
    fontSize: 12.0,
    fontWeight: FontWeight.w600);

const tsBoldTextWhite14 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w700);
const tsBoldTextWhite13 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w500);
const tsBoldTextColor16 = TextStyle(
    color: AppColors.textPrimaryColor11,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsBoldTextColor32 = TextStyle(
    color: AppColors.textPrimaryColor11,
    fontFamily: font_gilroy,
    fontSize: 32.0,
    fontWeight: FontWeight.w700);

const tsMediumTextWhite14 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);
const tsMediumTextWhite12 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 12.0,
    fontWeight: FontWeight.w500);
const tsMediumTextPrimary12 = TextStyle(
    color: AppColors.textPrimaryColor11,
    fontFamily: font_gilroy,
    fontSize: 12.0,
    fontWeight: FontWeight.w500);
const tsMediumTextWhite13 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w500);
const tsMediumTextWhite16 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);
const tsMediumTextWhite27 = TextStyle(
    color: AppColors.white27,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGrey80PrimaryText14 = TextStyle(
    color: AppColors.textPrimaryColor80,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsMediumTextGreyPrimaryText14 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsBoldTextDarkGrey26 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 26.0,
    fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey22 = TextStyle(
    color: AppColors.textPrimaryColor11,
    fontFamily: font_gilroy,
    fontSize: 28.0,
    fontWeight: FontWeight.w800);

const tsBoldTextWhite22 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 22.0,
    fontWeight: FontWeight.w700);

const tsBoldTextWhite28 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 28.0,
    fontWeight: FontWeight.w700);

const tsBoldTextWhite18 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 18.0,
    fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey18 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 18.0,
    fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey20 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 20.0,
    fontWeight: FontWeight.w700);

const tsBoldTextWhite20 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 20.0,
    fontWeight: FontWeight.w700);

const tsBoldTextLightGrey16 = TextStyle(
    color: AppColors.textPrimaryColor30,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsBoldTextLight40Grey16 = TextStyle(
    color: AppColors.textPrimaryColor40,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsBoldTextLight40Grey14 = TextStyle(
    color: AppColors.textPrimaryColor40,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey16 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey14 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey12 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 12.0,
    fontWeight: FontWeight.w700);

const tsBoldTextDarkGrey10 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 10.0,
    fontWeight: FontWeight.w700);

const tsBoldTextPink16 = TextStyle(
    color: AppColors.pinkColor,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsSemiBoldTextPink15 = TextStyle(
    color: AppColors.pinkColor,
    fontFamily: font_gilroy,
    fontSize: 15.0,
    fontWeight: FontWeight.w600);

const tsBoldTextPink23 = TextStyle(
    color: AppColors.pinkColor,
    fontFamily: font_gilroy,
    fontSize: 23.0,
    fontWeight: FontWeight.w700);

const tsMediumTextPink14 = TextStyle(
    color: AppColors.pinkColor,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsSemiBoldTextPink14 = TextStyle(
    color: AppColors.pinkColor,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w600);

const tsBoldTextGreen16 = TextStyle(
    color: AppColors.greenColor,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsBoldTextWhite16 = TextStyle(
    color: AppColors.white,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsBoldTextLightWhite16 = TextStyle(
    color: AppColors.lightWhite,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w500);
const tsBoldTextLightWhite14 = TextStyle(
    color: AppColors.lightWhite,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);
const tsTextLightWhite14 = TextStyle(
    color: AppColors.lightWhite,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w500);

const tsBoldText30White16 = TextStyle(
    color: AppColors.white30,
    fontFamily: font_gilroy,
    fontSize: 16.0,
    fontWeight: FontWeight.w700);

const tsSemiBoldTextGrey40Primary14 = TextStyle(
    color: AppColors.textPrimaryColor40,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w600);

const tsSemiBoldTextGrey50Primary14 = TextStyle(
    color: AppColors.textPrimaryColor50,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w600);

const tsSemiBoldTextGreyPrimary14 = TextStyle(
    color: AppColors.textPrimaryColor,
    fontFamily: font_gilroy,
    fontSize: 14.0,
    fontWeight: FontWeight.w600);

const tsSemiBoldTextPink13 = TextStyle(
    color: AppColors.pinkColor,
    fontFamily: font_gilroy,
    fontSize: 13.0,
    fontWeight: FontWeight.w600);

const tsSemiBoldTextBattleshipGrey16 = TextStyle(
    color: AppColors.battleship_grey,
    fontFamily: font_gilroy,
    fontSize: 16,
    height: 1.1,
    fontWeight: PoppinsSemiBold);

const tsGreenBoldGreen23 = TextStyle(
    color: AppColors.greenColor,
    fontFamily: font_gilroy,
    fontSize: 23,
    fontWeight: PoppinsBold);
