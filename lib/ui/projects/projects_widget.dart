import 'package:cached_network_image/cached_network_image.dart';
import 'package:test/bloc/project_bloc.dart';
import 'package:test/model/project_list_response.dart';
import 'package:test/ui/common/common_widgets.dart';
import 'package:test/ui/common/transparent_inkwell.dart';
import 'package:test/utils/constants.dart';
import 'package:test/utils/utils.dart';

import '../add_project/add_project_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../project_details/project_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsWidget extends StatefulWidget {
  ProjectsWidget({Key key}) : super(key: key);

  @override
  _ProjectsWidgetState createState() => _ProjectsWidgetState();
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProjectBloc _projectBloc;

  @override
  void initState() {
    super.initState();
    _projectBloc = new ProjectBloc(context);
    initobersers();
  }

  initobersers() {
    _projectBloc.projectListRequest();
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
      backgroundColor: Color(0xFFDBE2E7),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        elevation: 8,
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProjectWidget(),
              ),
            ).whenComplete(() => initobersers());
          },
          child: Icon(
            Icons.add,
            color: FlutterFlowTheme.tertiaryColor,
            size: 28,
          ),
        ),
      ),
      body: SafeArea(child: streamWidget()),
    );
  }

  streamWidget() {
    return StreamBuilder<List<DataProject>>(
      stream: _projectBloc.onProjectListSuccess,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Utils().somethingWentWrong();
        if (snapshot.hasData) {
          List<DataProject> list = snapshot.data;

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
                  return operationList(list[index]);
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

  operationList(DataProject list) {
    return Container(
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
                CachedNetworkImage(
                  imageUrl: KApiBase.BASE_URL_IMAGE+list.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailsWidget(list.id,list.projectName),
                  ),
                ).whenComplete(() => initobersers());
              },
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
                            height: 0,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                          Text(
                            list.projectName,
                            style: FlutterFlowTheme.title2.override(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF95A1AC),
                              size: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
