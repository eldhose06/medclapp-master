import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medclapp/screens/tabs/emergency.dart';
import 'package:medclapp/screens/tabs/health_records.dart';
import 'package:medclapp/screens/tabs/home.dart';
import 'package:medclapp/screens/tabs/profile.dart';
import 'package:medclapp/screens/widgets/common_drawer.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/screens/widgets/search/search.dart';
import 'package:medclapp/utils/globals.dart' as globals;
import 'package:medclapp/utils/styles.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomeScreen(),
      EmergencyScreen(),
      HealthRecordsScreen(),
      ProfileScreen(),
    ];

    // App Exit Function
    exitAppFunction() async {
      SystemNavigator.pop();
    }

    gotoBackTab() async {
      setState(() {
        // globals.globalTabIndex = globals.globalTabIndex - 1;
        globals.globalTabIndex = 0;
      });
      print('globals.globalTabIndex from gotoBackTab: ' +
          globals.globalTabIndex.toString());
      return false;
    }

    showPopupBox() async {
      showModalBottomSheet(
          context: context,
          builder: (context) => Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                padding:
                    EdgeInsets.only(left: 35, right: 35, top: 25, bottom: 25),
                // color: Colors.grey[200],
                height: 150,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Do You Want To Exit App?',
                      style: Styles.normalgeneralText,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'NO',
                            style: Styles.btnWhiteText,
                          ),
                          color: Styles.secondaryColor,
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        FlatButton(
                          child: Text(
                            'YES',
                            style: Styles.normalgeneralText,
                          ),
                          color: Colors.grey,
                          onPressed: () async {
                            await exitAppFunction();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ));
      return false;
    }

    // onBackPressed Function
    Future<bool> _onBackPressed() async {
      print('globals.globalTabIndex: ' + globals.globalTabIndex.toString());
      return globals.globalTabIndex == 0 ? showPopupBox() : gotoBackTab();
    }

    return Directionality(
        textDirection: globals.defaultLanguage == 'Arabic'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: WillPopScope(
            onWillPop: _onBackPressed,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: globals.globalTabIndex == 0
                      ? Size.fromHeight(120.0)
                      : Size.fromHeight(60.0),
                  child: Column(
                    children: <Widget>[
                      AppBar(
                        elevation: 0,
                        centerTitle: false,
                        backgroundColor: Colors.white,
                        iconTheme: IconThemeData(color: Colors.black),
                        title: Image.asset(
                          'lib/assets/images/header.png',
                          height: 25,
                        ),
                        actions: <Widget>[CommonHeaderWidget()],
                      ),
                      globals.globalTabIndex == 0 ? SearchWidget() : SizedBox()
                    ],
                  ),
                ),
                body: tabs[globals.globalTabIndex],
                drawer: CommonDrawer(),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: Styles.secondaryColor,
                  iconSize: 18,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  currentIndex: globals.globalTabIndex,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: globals.globalTabIndex == 0
                          ? Container(
                              width: 25,
                              padding: EdgeInsets.only(bottom: 6),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/home_1.png',
                                width: 20,
                              ),
                            )
                          : Container(
                              width: 25,
                              padding: EdgeInsets.only(bottom: 6),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/home.png',
                                width: 20,
                              ),
                            ),
                      title: Text(
                        'Home',
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: globals.globalTabIndex == 1
                          ? Container(
                              width: 21,
                              padding: EdgeInsets.only(bottom: 8),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/emergency_1.png',
                                width: 20,
                              ),
                            )
                          : Container(
                              width: 21,
                              padding: EdgeInsets.only(bottom: 8),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/emergency.png',
                                width: 20,
                              ),
                            ),
                      title: Text(
                        'Emergency',
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: globals.globalTabIndex == 2
                          ? Container(
                              width: 22,
                              padding: EdgeInsets.only(bottom: 9),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/records_1.png',
                                width: 20,
                              ),
                            )
                          : Container(
                              width: 22,
                              padding: EdgeInsets.only(bottom: 9),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/records.png',
                                width: 20,
                              ),
                            ),
                      title: Text(
                        'Health Records',
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: globals.globalTabIndex == 3
                          ? Container(
                              width: 23,
                              padding: EdgeInsets.only(bottom: 6),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/profile_1.png',
                                width: 20,
                              ),
                            )
                          : Container(
                              width: 23,
                              padding: EdgeInsets.only(bottom: 6),
                              child: Image.asset(
                                'lib/assets/images/icons/footer/profile.png',
                                width: 20,
                              ),
                            ),
                      title: Text(
                        'Profile',
                      ),
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      globals.globalTabIndex = index;
                    });
                  },
                ),
              ),
            )));
  }
}
