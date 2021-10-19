import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medclapp/functions/user_auths/logout.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:share/share.dart';

import 'package:medclapp/utils/globals.dart' as globals;

class CommonDrawer extends StatefulWidget {
  @override
  _CommonDrawerState createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Container(
          //     padding: EdgeInsets.only(
          //         left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
          //     child: Column(
          //       children: <Widget>[
          //         // SizedBox(height: 10,),
          //       ],
          //     )), // MENU HEAD AREA

          Container(
            color: Styles.brandLightColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Logo Container
                Container(
                    margin: EdgeInsets.only(left: 35, top: 30, right: 25),
                    child: Text(
                      'MEDCLAPP Pvt. Ltd',
                      style: TextStyle(color: Colors.white),
                    )
                    // Image.asset(
                    //   'lib/assets/images/splash_logo.png',
                    //   height: 50,
                    // ),
                    ),

                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),

          // // Corona Virus Assessment Block
          // ListTile(
          //   selectedTileColor: Colors.amberAccent,
          //   selected: true,
          //   title: Text(
          //     'Coronavirus Assessment',
          //     style: Styles.normalgeneralText,
          //   ),
          //   leading: Container(
          //     padding: EdgeInsets.only(top: 10),
          //     child: Icon(Icons.ac_unit),
          //   ),
          //   subtitle: Text(
          //     'Take a 3 minutes self assessment',
          //     style: Styles.extrasmallgeneralGreyText,
          //   ),
          // ),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          //   margin: EdgeInsets.only(top: 10),
          //   child: Text(
          //     'MEDCLAPP CARE SERVICES',
          //     style: Styles.normalgeneralText,
          //   ),
          // ),

          // // Consult Now
          // Container(
          //   color: Color(0XFFEDEDED),
          //   margin: EdgeInsets.only(bottom: 1),
          //   child: FlatButton(
          //       onPressed: () async {
          //         // print(globals.globalTabIndex);
          //         // setState(() {
          //         //   globals.globalTabIndex = 1;
          //         // });
          //         // print(globals.globalTabIndex);
          //         // Navigator.pop(context);
          //         // Navigator.pushReplacementNamed(context, '/dashboard');
          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'Consult Now',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),

          // // Book Health Packages
          // Container(
          //   color: Color(0XFFEDEDED),
          //   margin: EdgeInsets.only(bottom: 1),
          //   child: FlatButton(
          //       onPressed: () async {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'Book Health Packages',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),

          // // Order Lab Test
          // Container(
          //   color: Color(0XFFEDEDED),
          //   margin: EdgeInsets.only(bottom: 1),
          //   child: FlatButton(
          //       onPressed: () async {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'Order Lab Test',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),

          // // Order Medicines
          // Container(
          //   color: Color(0XFFEDEDED),
          //   margin: EdgeInsets.only(bottom: 1),
          //   child: FlatButton(
          //       onPressed: () async {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'Order Medicines',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),

          // // Buy Subscriptions
          // Container(
          //   color: Color(0XFFEDEDED),
          //   margin: EdgeInsets.only(bottom: 1),
          //   child: FlatButton(
          //       onPressed: () async {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'Buy Subscriptions',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),

          // Personal Heading
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'PERSONAL',
              style: Styles.normalgeneralText,
            ),
          ),

          // Family Members
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/listFamilyMembers');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Family Members',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // VACCINE Reminder
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, '/vaccinationReminderList');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'VACCINE Reminder',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // Medicine Reminder
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, '/medicineReminderList');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Medicine Reminder',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // Records Heading
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'RECORDS',
              style: Styles.normalgeneralText,
            ),
          ),

          // Health Files
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    globals.globalTabIndex = 2;
                  });
                  Navigator.of(context).pushNamed('/dashboard');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Health Files',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // Settings Heading
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'BLOG',
              style: Styles.normalgeneralText,
            ),
          ),

          // Health Feed
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  setState(() {
                    globals.globalTabIndex = 0;
                  });
                  Navigator.of(context).pushNamed('/dashboard');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Health Feed',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // About Heading
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'ABOUT',
              style: Styles.normalgeneralText,
            ),
          ),

          // About Medclapp
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'About Medclapp',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // Terms & Conditions
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Terms & Conditions ',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // Privacy Policy
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Privacy Policy ',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // FAQ
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'FAQ ',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // Logout
          Container(
            color: Color(0XFFEDEDED),
            margin: EdgeInsets.only(bottom: 1),
            child: FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  globals.loggedStatus == 'false'
                      ? Navigator.pushNamed(context, '/login')
                      : await logout(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      globals.loggedStatus == 'false' ? 'LOGIN ' : 'LOGOUT',
                      style: Styles.normalgeneralText,
                    ),
                  ],
                )),
          ),

          // Share App Block
          ListTile(
            onTap: () {
              print('Clicked Shareapp');
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/shareapp');
              Share.share(
                  'Download Medclapp App from store https://play.google.com/store');
            },
            selectedTileColor: Styles.brandLightColor,
            selected: true,
            title: Text(
              'Share the App',
              style: Styles.btnWhiteText,
            ),
            leading: Container(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              'Recommend to family and friends',
              style: Styles.smallgeneralWhiteText,
            ),
          ),

          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 15),
          //   padding: EdgeInsets.symmetric(horizontal: 25),
          //   child: Divider(
          //     height: 1,
          //     color: Colors.grey,
          //   ),
          // ),

          // // About Us
          // Container(
          //   child: FlatButton(
          //       onPressed: () async {},
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'About Us',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),

          // // Settings
          // Container(
          //   child: FlatButton(
          //       onPressed: () async {
          //         Navigator.pushNamed(context, '/policies');
          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'Settings',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),

          // // Share App Menu
          // Container(
          //   child: FlatButton(
          //       onPressed: () async {
          // print('Clicked Shareapp');
          // Navigator.pop(context);
          // // Navigator.pushNamed(context, '/shareapp');
          // Share.share(
          //     'Download Medclapp App from store https://play.google.com/store');
          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Text(
          //             'Share',
          //             style: Styles.normalgeneralText,
          //           ),
          //         ],
          //       )),
          // ),
        ],
      ),
    ));
  }
}
