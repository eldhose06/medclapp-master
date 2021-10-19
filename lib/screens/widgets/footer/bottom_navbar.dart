import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medclapp/screens/base.dart';
import 'package:medclapp/utils/globals.dart' as globals;
import 'package:medclapp/utils/styles.dart';

class BottomNavbarWidget extends StatefulWidget {
  @override
  _BottomNavbarWidgetState createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  _onTap(int index) {
    print('INSIDE _onTap');

    setState(() {
      globals.globalTabIndex = 0;
    });

    Timer(Duration(seconds: 2), () {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return DashboardScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      onTap: _onTap,
    );
  }
}
