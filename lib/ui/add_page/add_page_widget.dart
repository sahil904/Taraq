import 'package:test/bloc/client_bloc.dart';
import 'package:test/bloc/operation_bloc.dart';
import 'package:test/custom_views/route_animations.dart';
import 'package:test/ui/clients/clients_widget.dart';
import 'package:test/utils/utils.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPageWidget extends StatefulWidget {
  String clientName;
  String typeAdd;

  AddPageWidget(this.typeAdd, {this.clientName});

  @override
  _AddPageWidgetState createState() => _AddPageWidgetState();
}

class _AddPageWidgetState extends State<AddPageWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ClientBloc _clientBloc;
  OperationBloc _operationBloc;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _clientBloc = new ClientBloc(context);
    _operationBloc = new OperationBloc(context);
    initobersers();
  }

  void initobersers() {
    _clientBloc.onClientAddSuccess.listen((event) {
      if (event.status) {
        Utils.hideLoader();
        Navigator.pop(context);
      }
    });
    _operationBloc.onOperationAddSuccess.listen((event) {
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
        title: AutoSizeText(
          'اضافة',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('IconButton pressed ...');
              if (textController.text.isNotEmpty) {
                Utils.showLoader(context);
                if (widget.typeAdd != "Opertional")
                  _clientBloc.requestCreateClient(textController.text.toString().trim());
                else
                  _operationBloc.requestCreateOperation(textController.text.toString().trim());
              } else
                Utils.showToast(context, "Please enter client name");
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: ' ‎....يرجى ‏كتابة ‏هنا ‏',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
