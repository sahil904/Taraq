import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/ui/clients/clients_widget.dart';
import 'package:test/ui/dashboard/dashboard_widget.dart';
import 'package:test/ui/flutter_flow/flutter_flow_theme.dart';
import 'package:test/ui/login/login_widget.dart';
import 'package:test/ui/operations/operations_widget.dart';
import 'package:test/ui/projects/projects_widget.dart';
import 'package:test/utils/log.dart';

import 'res/app_colors.dart';
import 'utils/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    _initDependencies();
    //  initPlatformState();
  }

  Future<void> _initDependencies() async {
    Log.init();
    final init = await Prefs.init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white,
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'dashboard';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'dashboard': DashboardWidget(),
      'projects': ProjectsWidget(),
      'Clients': ClientsWidget(),
      'operations': OperationsWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              size: 30,
            ),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.listAlt,
              size: 24,
            ),
            label: 'المشاريع',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.users,
              size: 24,
            ),
            label: 'العملاء',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.networkWired,
              size: 24,
            ),
            label: 'الاجراءات',
          )
        ],
        backgroundColor: Colors.white,
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: FlutterFlowTheme.primaryColor,
        unselectedItemColor: Color(0x8A000000),
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
