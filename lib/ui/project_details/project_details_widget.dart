import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/bloc/project_bloc.dart';
import 'package:test/model/dashboard_response.dart';
import 'package:test/ui/add_transaction/add_transaction_widget.dart';
import 'package:test/ui/common/common_widgets.dart';
import 'package:test/ui/flutter_flow/flutter_flow_theme.dart';
import 'package:test/ui/project_reports/project_reports_widget.dart';
import 'package:test/utils/utils.dart';

class ProjectDetailsWidget extends StatefulWidget {
  int id;
  String projectName;

  ProjectDetailsWidget(this.id,this.projectName, {Key key}) : super(key: key);

  @override
  _ProjectDetailsWidgetState createState() => _ProjectDetailsWidgetState();
}

class _ProjectDetailsWidgetState extends State<ProjectDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProjectBloc projectBloc;

  @override
  void initState() {
    super.initState();
    projectBloc = new ProjectBloc(context);
    projectBloc.projectDetailsRequest(widget.id.toString());
    projectBloc.onProjectListSuccess.listen((isLoading) {
      Navigator.pop(context);
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
          widget.projectName,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              projectPopup(context, widget.id);
              //  Utils.showLoader(context);
              // projectBloc.requestCreateProject(textController.text.toString(),_imageFile);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            iconSize: 30,
          ),

          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectReportsWidget(widget.id),
                ),
              );
            },
            icon: Icon(
              Icons.data_usage_outlined,
              color: Colors.white,
              size: 25,
            ),
            iconSize: 25,
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFDBE2E7),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionWidget(widget.id),
            ),
          ).then((value) => {

          projectBloc.projectDetailsRequest(widget.id.toString())

          });
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add,
          color: FlutterFlowTheme.tertiaryColor,
          size: 28,
        ),
      ),
      body: SafeArea(child: streamWidget()),
    );
  }

  streamWidget() {
    return StreamBuilder<DashboardResponse>(
      stream: projectBloc.onProjectDetailsSuccess,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Utils().somethingWentWrong();
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            // if (snapshot.data.LoginStatusCheck == "Active") {
            List<Client> clientList = snapshot.data.clients;
            List<Operation> opertaionList = snapshot.data.operations;
            List<Transaction> transactionsList = snapshot.data.transactions;
            if (clientList.isEmpty && clientList.isEmpty && clientList.isEmpty)
              return Utils().noItemInCartList();
            else
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (clientList.isNotEmpty)
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
                    if (clientList.isNotEmpty)
                      Container(
                        height: 130,
                        margin: EdgeInsets.only(left: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: clientList.length,
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
                    if (clientList.isNotEmpty)
                      Divider(
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                        color: Color(0xFFBEA4E9),
                      ),
                    if (opertaionList.isNotEmpty)
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
                    if (opertaionList.isNotEmpty)
                      Container(
                        height: 130,
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
                                                  fontSize: 15,
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
                                          "\$ " +  opertaionList[index].price,
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
                    if (transactionsList.isNotEmpty)
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
                    if (transactionsList.isNotEmpty)
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

  projectPopup(BuildContext context, int addressId) {
    return showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Are you sure to delete this project",
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "No",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Yes",
              ),
              onPressed: () {
                Navigator.of(context).pop();
                projectBloc.deleteProjectRequest(addressId);
              },
            )
          ],
        );
      },
    );
  }
}
