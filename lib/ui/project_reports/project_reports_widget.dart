import 'package:test/bloc/client_bloc.dart';
import 'package:test/bloc/operation_bloc.dart';
import 'package:test/bloc/project_bloc.dart';
import 'package:test/model/client_list_response.dart';
import 'package:test/model/opertaion_list_response.dart';
import 'package:test/model/project_list_response.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/res/styles.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/ui/report_result/report_result_widget.dart';
import 'package:test/utils/utils.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectReportsWidget extends StatefulWidget {
  int id;

  ProjectReportsWidget(this.id, {Key key}) : super(key: key);

  @override
  _ProjectReportsWidgetState createState() => _ProjectReportsWidgetState();
}

class _ProjectReportsWidgetState extends State<ProjectReportsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ClientBloc _clientBloc;
  ProjectBloc projectBloc;
  OperationBloc _operationBloc;

  var operationText = 'يرجى اختيار الاجراء';
  var operationId = 0;
  var clientId = 0;
  var clientName = 'يرجى اختيار العميل';

  DateTime startSelectedDate = DateTime.now();
  DateTime endSelectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _clientBloc = new ClientBloc(context);
    projectBloc = new ProjectBloc(context);
    _operationBloc = new OperationBloc(context);
    initobersers();
  }

  void initobersers() {
    _operationBloc.onOperationListSuccess.listen((event) {
      if (event.isNotEmpty) {
        setupAlertDialogOperation(context, event);
      }
      Utils.hideLoader();
    });
    _clientBloc.onClientListSuccess.listen((event) {
      Utils.hideLoader();
      if (event.isNotEmpty) setupAlertDialogClient(context, event);
    });
    projectBloc.onTransactionReportSuccessBS.listen((event) {
      if (event.status) Utils.showSuccessMessage(context, "Success");


      print(event.toJson());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportResultWidget(event.data),
        ),
      );
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
          'تقرير المشروع',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()  {
              Utils.showLoader(context);
              projectBloc.reportRequest(widget.id, clientId.toString(), operationId.toString(), startSelectedDate.toString().substring(0, 10),
                  endSelectedDate.toString().substring(0, 10));

            },
            icon: Icon(
              Icons.done,
              color: Colors.white,
              size: 25,
            ),
            iconSize: 25,
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ': الاجراء  ',
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              Utils.showLoader(context);
                              _clientBloc.clientListRequest();
                            },
                            text: clientName,
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40,
                              color: FlutterFlowTheme.primaryColor,
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 5,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.primaryColor,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                      color: Color(0xFFBEA4E9),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ':  العميل ',
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              Utils.showLoader(context);
                              _operationBloc.operationListRequest();
                            },
                            text: operationText,
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40,
                              color: FlutterFlowTheme.primaryColor,
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 5,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.primaryColor,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                      color: Color(0xFFBEA4E9),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ':  من ',
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                              _startSelectDate(context);
                            },
                            text: startSelectedDate.toString().substring(0, 10),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 40,
                              color: FlutterFlowTheme.primaryColor,
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 5,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.primaryColor,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                      color: Color(0xFFBEA4E9),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ':  الى ',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                        _endSelectDate(context);
                      },
                      text: endSelectedDate.toString().substring(0, 10),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 40,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        elevation: 5,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.primaryColor,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  setupAlertDialogOperation(context, List<DataOpertaion> productSize) async {
    return await showDialog<String>(
      context: context,
      builder: (_) => new AlertDialog(
          content: Container(
        // height: 250.0, // Change as per your requirement
        width: isIOS ? 355.0 : 350, // Change as per your requirement
        child: ListView(
          shrinkWrap: true,
          children: [
            /*    SizedBox(
                  height: 5,
                ),
                Text(
                  productSize,
                  style: tsSemiBoldTextDarkGrey20,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),*/
            ListView.builder(
              shrinkWrap: true,
              itemCount: productSize.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    TransparentInkWell(
                      onTap: () {
                        setState(() {
                          operationText = productSize[index].clientName;
                          operationId = productSize[index].id;
                          //   valueChangeProductSize.value = productSize[index].sizes;
                          print(operationText);
                        });

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 30,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          productSize[index].clientName,
                          style: tsSemiBoldTextDarkGrey13,
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.black,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  setupAlertDialogClient(context, List<DataClient> productSize) async {
    return await showDialog<String>(
      context: context,
      builder: (_) => new AlertDialog(
          content: Container(
        // height: 250.0, // Change as per your requirement
        width: isIOS ? 355.0 : 350, // Change as per your requirement
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: productSize.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    TransparentInkWell(
                      onTap: () {
                        setState(() {
                          clientName = productSize[index].clientName;
                          clientId = productSize[index].id;
                        });

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 30,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          productSize[index].clientName,
                          style: tsSemiBoldTextDarkGrey13,
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.black,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _startSelectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startSelectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startSelectedDate)
      setState(() {
        startSelectedDate = picked;
      });
  }

  Future<void> _endSelectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endSelectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endSelectedDate)
      setState(() {
        endSelectedDate = picked;
      });
  }
}
