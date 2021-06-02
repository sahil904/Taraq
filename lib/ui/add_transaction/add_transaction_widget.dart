import 'package:test/bloc/client_bloc.dart';
import 'package:test/bloc/operation_bloc.dart';
import 'package:test/bloc/project_bloc.dart';
import 'package:test/model/client_list_response.dart';
import 'package:test/model/opertaion_list_response.dart';
import 'package:test/res/app_colors.dart';
import 'package:test/res/styles.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/utils/utils.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTransactionWidget extends StatefulWidget {
  AddTransactionWidget(this.id, {Key key}) : super(key: key);
  int id;

  @override
  _AddTransactionWidgetState createState() => _AddTransactionWidgetState();
}

class _AddTransactionWidgetState extends State<AddTransactionWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  DateTime selectedDate = DateTime.now();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  OperationBloc _operationBloc;
  var operationText = 'سحب';
  var operationId;
  var clientId;
  var clientName = 'حيدر';
  ClientBloc _clientBloc;
  ProjectBloc projectBloc;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    projectBloc = new ProjectBloc(context);
    _clientBloc = new ClientBloc(context);
    _operationBloc = new OperationBloc(context);
    initobersers();
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
          'اجراء عملية',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('IconButton pressed ...');
              projectBloc.transcationRequest(widget.id, clientId.toString(), operationId.toString(),
                  textController1
                  .text.toString().trim(), selectedDate.toString(), textController2.text.toString
                ().trim());
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: SingleChildScrollView(
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
                          // print('Button pressed ...');
                          Utils.showLoader(context);
                          _operationBloc.operationListRequest();
                        },
                        text: operationText,
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: Color(0x004307B1),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.primaryColor,
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
                          Utils.showLoader(context);
                          _clientBloc.clientListRequest();
                        },
                        text: clientName,
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: Color(0x004307B1),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.primaryColor,
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
                            ': المبلغ',
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
                    Container(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: TextFormField(
                          controller: textController1,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: '0000',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
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
                            ':  التاريخ ',
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
                          _selectDate(context);
                        },
                        text: selectedDate.toString(),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: Color(0x004307B1),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.primaryColor,
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
                            ': ملاحظات',
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
                    Container(
                      height: 100,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          controller: textController2,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: '... اكتب ‏ملاحظاتك ‏هنا',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
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
    projectBloc.onTransactionAddSuccess.listen((event) {
      if(event.status)
        Utils.showSuccessMessage(context, "Success");
        Navigator.pop(context);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
