import 'package:test/bloc/login_bloc.dart';
import 'package:test/utils/utils.dart';
import 'package:test/utils/validation_utils.dart';

import '../../main.dart';
import '../dashboard/dashboard_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({
    Key key,
    this.username,
    this.password,
  }) : super(key: key);

  final String username;
  final String password;

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController passWordController;
  TextEditingController userNameController;
  LoginBloc _loginBloc;
  bool canProceed = false;
  bool isValidEmail = false;
  bool isValidName = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = new LoginBloc(context);
    passWordController = TextEditingController();
    userNameController = TextEditingController();
    userNameController.addListener(_checkInputValidations);
    passWordController.addListener(_checkInputValidations);

    _loginBloc.onLoginSuccess.listen((event) {
      if (event!=null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavBarPage(),
          ),
          (r) => false,
        );
      } else
        Utils.showErrorMessage(context, "Please Check login details");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    passWordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.primaryColor,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.06, -0.63),
              child: Image.asset(
                'assets/images/iconfinder_apple_logo_734833.png',
                width: 280,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Container(
                        width: 285,
                        height: 40,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, 0),
                              child: TextFormField(
                                controller: userNameController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'اسم ‏المستخدم',
                                  hintStyle: GoogleFonts.getFont(
                                    'Lato',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Align(
                              alignment: Alignment(0.95, 0.5),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Container(
                        width: 285,
                        height: 40,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, 0),
                              child: TextFormField(
                                controller: passWordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'كلمة ‏المرور',
                                  hintStyle: GoogleFonts.getFont(
                                    'Lato',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                  ),
                                ),
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Align(
                              alignment: Alignment(0.95, 0.5),
                              child: Icon(
                                Icons.lock_open,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              _onContinueButtonClicked();
                            },
                            text: 'تسجيل الدخول',
                            options: FFButtonOptions(
                              width: 125,
                              height: 40,
                              color: Color(0x00FFFFFF),
                              textStyle: GoogleFonts.getFont(
                                'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFF553BBA),
                                width: 2,
                              ),
                              borderRadius: 0,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _checkInputValidations() {
    if (userNameController.text.isNotEmpty) {
      isValidName = true;
    } else
      isValidName = false;

    if (passWordController.text.isNotEmpty) {
      isValidEmail = true;
    } else
      isValidEmail = false;

    setState(() {
      if (isValidName && isValidEmail) {
        canProceed = true;
      } else {
        canProceed = false;
      }
    });
  }

  void _onContinueButtonClicked() {
    if (canProceed) {
      _loginBloc.loginRequest(
          userNameController.text.toString().trim(), passWordController.text.toString().trim());
    } else {
      showValidationError();
    }
  }

  void showValidationError() {
    if (userNameController.text.isEmpty) {
      Utils.showErrorMessage(context, 'Enter your email');
      return;
    } else if (passWordController.text.isEmpty) {
      Utils.showErrorMessage(context, 'Enter valid password');
      return;
    }
  }
}
