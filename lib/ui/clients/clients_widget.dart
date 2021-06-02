import 'package:test/bloc/client_bloc.dart';
import 'package:test/model/client_list_response.dart';
import 'package:test/ui/common/common_widgets.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/utils/utils.dart';

import '../add_page/add_page_widget.dart';
import '../edit_page/edit_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientsWidget extends StatefulWidget {
  ClientsWidget({Key key}) : super(key: key);

  @override
  _ClientsWidgetState createState() => _ClientsWidgetState();
}

class _ClientsWidgetState extends State<ClientsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ClientBloc _clientBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _clientBloc = new ClientBloc(context);
    initobersers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFDBE2E7),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPageWidget("client"),
            ),
          ).whenComplete(() => initobersers());
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
    return StreamBuilder<List<DataClient>>(
      stream: _clientBloc.onClientListSuccess,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Utils().somethingWentWrong();
        if (snapshot.hasData) {
          List<DataClient> list = snapshot.data;

          if (snapshot.data != null) {
            // if (snapshot.data.LoginStatusCheck == "Active") {
            if (snapshot.data.isNotEmpty)
              return ListView.builder(
                shrinkWrap: true,
                //controller: _scrollController,
                itemCount: list.length,
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,

                itemBuilder: (BuildContext context, int index) {
                  // return index == list.length
                  //     ? PaginationLoader(
                  //     // stream: _operationBloc
                  //     //     .followingListPaginationLoader
                  // )
                  //     :
                  return clientList(list[index]);
                },
              );
            else
              return Utils().noItemInCartList();
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

  clientList(DataClient list) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.tertiaryColor,
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
                            'assets/images/user_2@2x.png',
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
                        Align(
                          alignment: Alignment(0, 0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 0,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                ),
                                Text(
                                  list.clientName,
                                  style: FlutterFlowTheme.title2.override(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: ()  {
                                           Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditPageWidget(
                                                  clientName: list.clientName, clientId: list.id,typeAdd:'client' ,),
                                            ),
                                          ).whenComplete(() => initobersers());
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.edit,
                                          color: Color(0xFF95A1AC),
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                        ),
                                      ),
                                      TransparentInkWell(
                                        onTap: () {
                                          projectPopup(context, list.id);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Color(0xFF95A1AC),
                                          size: 25,
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
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  void initobersers() {
    _clientBloc.onDeleteLoader.listen((isLoading) {
      if (isLoading)
        Utils.showLoader(context);
      else
        Utils.hideLoader();
    });

    _clientBloc.clientListRequest();
  }
  projectPopup(BuildContext context, int id) {
    return showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Are you sure to delete this client",
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
               // Utils.showLoader(context);
                _clientBloc.deleteClientListRequest(id);

              },
            )
          ],
        );
      },
    );
  }

}
