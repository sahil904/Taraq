// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:test/res/app_colors.dart';
// import 'package:test/ui/cart/cart_screen.dart';
// import 'package:test/ui/chat/chat_bot_screen.dart';
// import 'package:test/ui/dashboard/dashboard_screen.dart';
// import 'package:test/ui/tutorial/tutoria_screen.dart';
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     PersistentTabController _controller;
//
//     _controller = PersistentTabController(initialIndex: 0);
//
//     List<Widget> _buildScreens() {
//       return [
//         DashBoardScreen(),
//         CartScreen(),
//         TutorialScreen(),
//         ChatBotScreen(),
//       ];
//     }
//
//     List<PersistentBottomNavBarItem> _navBarsItems() {
//       return [
//         PersistentBottomNavBarItem(
//           icon: Icon(Icons.home_filled),
//           title: ("Home"),
//           activeColorPrimary: AppColors.textPrimaryColor11,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: Icon(CupertinoIcons.cart),
//           title: ("Cart"),
//           activeColorPrimary: AppColors.textPrimaryColor11,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: Icon(Icons.video_collection_outlined),
//           title: ("Tutorial"),
//           activeColorPrimary: AppColors.textPrimaryColor11,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: Icon(CupertinoIcons.chat_bubble_2),
//           title: ("Chat"),
//           activeColorPrimary: AppColors.textPrimaryColor11,
//           inactiveColorPrimary: CupertinoColors.systemGrey,
//         ),
//       ];
//     }
//
//     return WillPopScope(
//       onWillPop: () async {
//         return showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text(
//                 "Confirm Exit",
//               ),
//               content: Text(
//                 "Are you sure you want to exit?",
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(
//                     "YES",
//                   ),
//                   onPressed: () {
//                     SystemNavigator.pop();
//                   },
//                 ),
//                 TextButton(
//                   child: Text(
//                     "NO",
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             );
//           },
//         );
//       },
//       child: PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         confineInSafeArea: true,
//         backgroundColor: AppColors.primary_color,
//         // Default is Colors.white.
//         handleAndroidBackButtonPress: false,
//         // Default is true.
//         resizeToAvoidBottomInset: false,
//         // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//         stateManagement: false,
//         // Default is true.
//         hideNavigationBarWhenKeyboardShows: true,
//         // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//         // decoration: NavBarDecoration(
//         //   borderRadius: BorderRadius.circular(10.0),
//         //   colorBehindNavBar: Colors.white,
//         // ),
//         popAllScreensOnTapOfSelectedTab: true,
//         popActionScreens: PopActionScreensType.all,
//         itemAnimationProperties: ItemAnimationProperties(
//           // Navigation Bar's items animation properties.
//           duration: Duration(milliseconds: 200),
//           curve: Curves.ease,
//         ),
//         screenTransitionAnimation: ScreenTransitionAnimation(
//           // Screen transition animation on change of selected tab.
//           animateTabTransition: true,
//           curve: Curves.ease,
//           duration: Duration(milliseconds: 200),
//         ),
//         navBarStyle:
//             NavBarStyle.style1, // Choose the nav bar style with this property.
//       ),
//     );
//   }
// }
