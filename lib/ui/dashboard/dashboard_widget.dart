import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/bloc/project_bloc.dart';
import 'package:test/model/dashboard_response.dart';
import 'package:test/ui/common/common_widgets.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/ui/login/login_widget.dart';
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
      backgroundColor: Color(0xFFDBE2E7),
      appBar: AppBar(
        actions: [
          TransparentInkWell(
              onTap: () {
                logout();
              },
              child: Icon(Icons.logout))
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
                    margin: EdgeInsets.only(left: 20),
                    height: 130,
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
                          width: 130,
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
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            projectsList[index].projectName,
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.bodyText2.override(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: AutoSizeText(
                                      projectsList[index].count.toString(),
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
                    height: 130,
                    margin: EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: clientList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 130,
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
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            clientList[index].clientName,
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.bodyText2.override(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: AutoSizeText(
                                      clientList[index].count.toString(),
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
                    height: 130,
                    margin: EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
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
                          width: 130,
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
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            opertaionList[index].operationName,
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.bodyText2.override(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: AutoSizeText(
                                      opertaionList[index].count.toString(),
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
                  ListView.builder(
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

                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              border: Border.all(
                                color: Color(0xFFC8CED5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/debit.svg',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 4, 4, 0),
                                              child: Text(
                                                transactionsList[index].notes,
                                                style: FlutterFlowTheme.bodyText2.override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
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

  Future<void> logout() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
      (r) => false,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
