import 'package:flutter/material.dart';
import 'package:test/res/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  final String headerText;
  final Function onButtonPressed;

  CustomAppbar({
    Key key,
    this.headerText,
    this.onButtonPressed,
  }) : super(key: key);

  double  _screenHeight;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.only(top: _screenHeight * .049),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: onButtonPressed,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, bottom: 18, top: 18),
                      /*TODO Replace with icon*/
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '< Back',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: headerText,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
