import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/res/styles.dart';

class UploadBottomSheet extends StatefulWidget {
  UploadBottomSheet(this.onImageReceived, {this.onVideoReceived, this.pickImage = true});

  final Function onImageReceived;
  final Function onVideoReceived;
  bool pickImage;

  @override
  _UploadBottomSheetState createState() => _UploadBottomSheetState();
}

class _UploadBottomSheetState extends State<UploadBottomSheet> with TickerProviderStateMixin {
  File _imageFile;

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget iconButton(text, icon, callback) {
    return GestureDetector(
        onTap: callback,
        child: Container(
          child: Column(children: <Widget>[
            Icon(
              icon,
              size: 60,
              color: AppColors.textPrimaryColor40,
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(text: text, style: tsSemiBoldTextDarkGrey18),
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorTransparent,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 44, left: 35, right: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(text: "Image Source", style: tsBoldTextDarkGrey26),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      iconButton('Gallery', Icons.image, _onUploadImageClicked),
                      iconButton('Camera', Icons.camera_alt, _onClickPictureClicked)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onClickPictureClicked() async {
    _onImageButtonPressed(ImageSource.camera);
  }

  void _onUploadImageClicked() {
    _onImageButtonPressed(ImageSource.gallery);
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(source: source);
      printImageInfo(_imageFile);
      setState(() {});
      Navigator.pop(context);
      widget.onImageReceived(_imageFile.path);
    } catch (e) {
      debugPrint('Image file error: ' + e.toString());
      widget.onImageReceived('');
      Navigator.pop(context);
    }
  }

  void printImageInfo(File imageFile) async {
    var size = await File(_imageFile.path).length();
    debugPrint('Image file received: ' + _imageFile.path);
    debugPrint('Image file size in bytes: ' + size.toString());
  }
}
