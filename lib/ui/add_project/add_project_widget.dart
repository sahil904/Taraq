import 'dart:io';

import 'package:flutter_svg/svg.dart';
import 'package:test/bloc/project_bloc.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/ui/common/upload_bottom_sheet.dart';
import 'package:test/utils/utils.dart';
import 'package:test/ui/common/custom_bottom_sheet.dart'as CustomBottomSheet;

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
class AddProjectWidget extends StatefulWidget {
  AddProjectWidget({Key key}) : super(key: key);

  @override
  _AddProjectWidgetState createState() => _AddProjectWidgetState();
}

class _AddProjectWidgetState extends State<AddProjectWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File _imageFile;
  ProjectBloc projectBloc;
  @override
  void initState() {
    super.initState();
    projectBloc=new ProjectBloc(context);
    textController = TextEditingController();
    projectBloc.onClientAddSuccess.listen((event) {
      if (event.status) {
        Utils.hideLoader();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(
          'مشروع جديد',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Utils.showLoader(context);
              projectBloc.requestCreateProject(textController.text.toString(),_imageFile);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            iconSize: 30,
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    _imageClicked();
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Color(0xFF95A1AC),
                    size: 30,
                  ),
                  iconSize: 30,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'اسم ‏المشروع',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4307B1),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4307B1),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            ),
            if(_imageFile != null)
            userImage()
          ],
        ),
      ),
    );
  }
  userImage() {
    return Container(
      height: 140,
      child: Row(
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: _imageFile == null
                      ? Container(
                      width: double.infinity,
                      //height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white90,
                      ),
                      child:
                      // images == ''
                      //     ?
                      Image.asset('assets/images/user_2@2x.png')
                    // : ClipOval(
                    //     child: Image.network(
                    //     images,
                    //     fit: BoxFit.fill,
                    //     width: 100,
                    //     height: 100,
                    //   )),
                  )
                      : Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: FileImage(_imageFile),
                      minRadius: 55,
                      maxRadius: 55,
                    ),
                  ),

                  // Align
                )),
          ),
        ],
      ),
    );
  }

  void _onImageReceived(String url) async {
    if (Utils.isEmpty(url)) return;
    debugPrint('recieved image path: ' + url);
    setState(() {
      _imageFile = File(url);
    });
  }

  void _imageClicked() {
    CustomBottomSheet.showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.colorTransparent,
      builder: (BuildContext context) {
        return UploadBottomSheet(_onImageReceived);
      },
    );
  }
}
