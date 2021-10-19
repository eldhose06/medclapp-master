import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  checkUserLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userTokenVal = prefs.getString('userAuthToken');
    String userId = prefs.getString('userId');

    print('userTokenVal: $userTokenVal');
    print('userId: $userId');

    if (userTokenVal != null && userTokenVal != '') {
      globals.loggedStatus = 'true';
      globals.customerId = userId;
    } else {
      globals.loggedStatus = 'false';
    }
  }

  startTime() async {
    await checkUserLoggedInStatus();

    var _duration = Duration(seconds: 3);
    return Timer(_duration, getNextPage);
  }

  void getNextPage() async {
    globals.loggedStatus == 'true'
        ? goToDashboard()
        : Navigator.of(context).pushReplacementNamed('/instruction1');
  }

  goToDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String completedProfile = prefs.getString('completedProfile');

    if (completedProfile == 'yes') {
      setState(() {
        globals.globalTabIndex = 0;
      });
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
      // Navigator.of(context).pushReplacementNamed('/completeProfile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: globals.defaultLanguage == 'Arabic'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
            backgroundColor: Colors.white,
            // backgroundColor: Styles.secondaryColor,
            body: ListView(
              children: <Widget>[
                Container(
                    // decoration: BoxDecoration(
                    //   // color: Styles.secondaryColor,
                    //   image: DecorationImage(
                    //       fit: BoxFit.cover,
                    //       // colorFilter: ColorFilter.mode(
                    //       //     Styles.secondaryColor.withOpacity(0.3),
                    //       //     BlendMode.dstATop),
                    //       image: AssetImage('lib/assets/images/bg.png')),
                    // ),
                    height: MediaQuery.of(context).size.height - 100,
                    child: Center(
                        child: Container(
                      // width: 165,
                      height: 180,
                      padding: EdgeInsets.all(15),
                      // decoration: BoxDecoration(
                      //   color: Styles.secondaryColor,
                      //   borderRadius: BorderRadius.circular(90)
                      // ),
                      child: Image.asset(
                        'lib/assets/images/splash_logo.png',
                      ),
                    ))),
                SizedBox(
                  height: 15,
                )
              ],
            )));
  }
}
