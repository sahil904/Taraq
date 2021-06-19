import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/bloc/project_bloc.dart';
import 'package:test/model/dashboard_response.dart';
import 'package:test/ui/common/common_widgets.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/ui/login/login_widget.dart';
import 'package:test/utils/constants.dart';
import 'package:test/utils/gridlayoyt.dart';
import 'package:test/utils/utils.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  DashboardWidget({
    Key key,
    this.auth,
  }) : super(key: key);

  final String auth;

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProjectBloc projectBloc;

  @override
  void initState() {
    super.initState();
    projectBloc = new ProjectBloc(context);
    projectBloc.dashboardRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        title: Text(KReqHeaders.APP_NAME),
        centerTitle: true,
        actions: [

          TransparentInkWell(
              onTap: () {
                Utils.logout(context);
              },
              child: Icon(Icons.logout))
          ,SizedBox(width: 15,)
        ],
      ),
      body: SafeArea(child: streamWidget()),
    );
  }

  streamWidget() {
    return StreamBuilder<DashboardResponse>(
      stream: projectBloc.onDashboardSuccess,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Utils().somethingWentWrong();
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            // if (snapshot.data.LoginStatusCheck == "Active") {
            List<Client> clientList = snapshot.data.clients;
            List<Project> projectsList = snapshot.data.projects;
            List<Operation> opertaionList = snapshot.data.operations;
            List<Transaction> transactionsList = snapshot.data.transactions;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'المشاريع',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF653CE0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 80,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: projectsList.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        // _updateProductQuantity(String text) {
                        //   var value = widget.newProducts[index].productSize[0].sizes;
                        //   valueChangeProductSize.value = value;
                        // }

                        // listIndex == index
                        //     ? value
                        //     : widget.newProducts[index]
                        //     .productSize[0]
                        //     .sizes

                        return Container(
                          width: 150,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(2, 4, 4, 4),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                                    child: Text(
                                      projectsList[index].projectName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: AutoSizeText(
                                      "${projectsList[index].count.toString()} : عدد العمليات  ",
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.title2.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF653CE0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                    color: Color(0xFFBEA4E9),
                  ),
                  Center(
                    child: Text(
                      'العملاء',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF653CE0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: clientList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 150,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(2, 4, 4, 4),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
                                    child: Text(
                                      clientList[index].clientName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: AutoSizeText(
                                      "${clientList[index].count.toString()} : عدد العمليات  ",
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.title2.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF653CE0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                    color: Color(0xFFBEA4E9),
                  ),
                  Center(
                    child: Text(
                      'الاجراءات',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF653CE0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    margin: EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: opertaionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // _updateProductQuantity(String text) {
                        //   var value = widget.newProducts[index].productSize[0].sizes;
                        //   valueChangeProductSize.value = value;
                        // }

                        // listIndex == index
                        //     ? value
                        //     : widget.newProducts[index]
                        //     .productSize[0]
                        //     .sizes

                        return Container(
                          width: 150,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(2, 4, 4, 4),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Text(
                                      opertaionList[index].operationName,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: AutoSizeText(
                                      "${opertaionList[index].count.toString()} : عدد العمليات  ",
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.title2.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF653CE0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: AutoSizeText(
                                    "\$ "+  opertaionList[index].price,
                                      textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      style: FlutterFlowTheme.title2.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF653CE0),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 0, 12),
                        child: Text(
                          'هذا الشهر',
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.bodyText2.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: Color(0xFFEEEEEE),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: transactionsList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        // _updateProductQuantity(String text) {
                        //   var value = widget.newProducts[index].productSize[0].sizes;
                        //   valueChangeProductSize.value = value;
                        // }

                        // listIndex == index
                        //     ? value
                        //     : widget.newProducts[index]
                        //     .productSize[0]
                        //     .sizes

                        return Container(
                          margin:  EdgeInsets.fromLTRB(15, 0, 0, 10),

                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "\$ " + transactionsList[index].price,
                                        style: FlutterFlowTheme.subtitle1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF15212B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                  Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 4, 0),
                                  child: Text(
                                    "${transactionsList[index].clientName} : العميل  ",
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),      Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 4, 0),
                                  child: Text(
                                    "${transactionsList[index].projectName} : المشروع  ",
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 4, 0),
                                  child: Text(
                                    "${transactionsList[index].operationName} : الاجراء  ",
                                    style: FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );

            // }
            // else
            //     Utils().navigateToPage(context);
          } else {
            return HalfLoader();
          }
        }
        return HalfLoader();
      },
    );
  }
}
