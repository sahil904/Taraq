import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/res/strings.dart';
import 'package:test/res/styles.dart';
import 'package:test/ui/common/transparent_inkwell.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {@required this.buttonText, @required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: () {
        onButtonPressed();
      },
      child: Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.textPrimaryColor11,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(buttonText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.arrow_right_alt_sharp,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
class LoginButton extends StatelessWidget {
  const LoginButton(
      {@required this.buttonText, @required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return TransparentInkWell(
      onTap: () {
        onButtonPressed();
      },
      child: Container(
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.textPrimaryColor11,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(buttonText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),

              ],
            ),
          )),
    );
  }
}

class SmallPrimaryButton extends StatelessWidget {
  const SmallPrimaryButton(
      {@required this.buttonText, @required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth;
    screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onButtonPressed();
      },
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.pinkColor,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Center(
            child: Text(buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontFamily: font_gilroy,
                    fontWeight: FontWeight.w500)),
          )),
    );
  }
}

class AddNewButton extends StatelessWidget {
  const AddNewButton(
      {this.buttonText = '+ Add New', @required this.onButtonPressed});

  final String buttonText;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onButtonPressed();
      },
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: AppColors.primary_color,
                style: BorderStyle.solid),
            color: AppColors.pale_grey_two,
            borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: buttonText,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primary_color)),
          ),
        ),
      ),
    );
  }
}
