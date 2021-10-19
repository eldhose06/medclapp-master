import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/blood_request/blood_request_list.dart';
import 'package:medclapp/functions/family/family_list.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<void> _launched;
  List bloodRequests = [];
  List familyList = [];
  bool dataLoaded = false;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
    getBloodRequest();
    getFamilyInfo();
  }

  getBloodRequest() async {
    bloodRequests = await getBloodRequestDetails();
    if (this.mounted) {
      setState(() {
        bloodRequests = bloodRequests[2];
        dataLoaded = true;
      });
    }
  }

  getFamilyInfo() async {
    if (globals.loggedStatus == 'true') {
      familyList = await getFamilyDetails();
      if (this.mounted) {
        setState(() {
          familyList = familyList[2];
          dataLoaded = true;
        });
      }
    } else {
      setState(() {
        familyList = [];
        dataLoaded = true;
      });
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     margin: EdgeInsets.symmetric(horizontal: 35),
    //     child: Text('Emergency Screen'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TabBar(
          indicatorColor: Colors.red,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.red,
          tabs: [
            Tab(
              text: 'EMERGENCY CALL',
            ),
            Tab(
              text: 'REQUEST BLOOD',
            )
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Expanded(
          child: TabBarView(
            children: [
              // 1st Tab
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 35, vertical: 35),
                  child:
                      // Center(child: Text('Emergency Details'))
                      Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _launched = _makePhoneCall('tel:101');
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'lib/assets/images/emergency/ambulance.png',
                                width: 75,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'CALL AMBULANCE',
                                    style: Styles.offerMainWhiteTitle,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Dial 101 by tapping here',
                                    style: Styles.btnWhiteText,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),

              ListView(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  globals.loggedStatus == 'true'
                      ? Container(
                          decoration: BoxDecoration(),
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: FlatButton(
                            color: Colors.red,
                            onPressed: () {
                              Navigator.pushNamed(context, '/bloodRequestNew');
                            },
                            child: Text(
                              'Request Blood',
                              style: Styles.btnWhiteText,
                            ),
                          ),
                        )
                      : SizedBox(),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Column(
                      children: dataLoaded == false
                          ? List.generate(1, (index) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                child: Center(
                                    child: SpinKitFadingCircle(
                                  color: Styles.secondaryColor,
                                  size: 50.0,
                                )),
                              );
                            })
                          : bloodRequests == []
                              ? List.generate(1, (index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'No Active Blood Requests',
                                                  style:
                                                      Styles.normalgeneralText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                })
                              : List.generate(bloodRequests.length, (index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Container(
                                                decoration: BoxDecoration(
                                                    color: bloodRequests[index]
                                                                    ['priority']
                                                                .toString() ==
                                                            'Emergency'
                                                        ? Colors.red
                                                        : Colors.orange),
                                                width: 50,
                                                height: 50,
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    bloodRequests[index][
                                                            'bloodgrouprequest']
                                                        .toString(),
                                                    // 'A+',
                                                    style:
                                                        Styles.bloodGroupText,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Patient: ' +
                                                      bloodRequests[index]
                                                              ['patientname']
                                                          .toString() +
                                                      ',   ' +
                                                      bloodRequests[index]
                                                              ['age']
                                                          .toString() +
                                                      ' Yrs',
                                                  style:
                                                      Styles.normalgeneralText,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Location: ' +
                                                      bloodRequests[index]
                                                              ['location']
                                                          .toString(),
                                                  style:
                                                      Styles.normalgeneralText,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Contact No: ' +
                                                      bloodRequests[index]
                                                              ['phonenumber']
                                                          .toString(),
                                                  style:
                                                      Styles.normalgeneralText,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Date & Time: ' +
                                                      bloodRequests[index]
                                                              ['date']
                                                          .toString() +
                                                      ',   ' +
                                                      bloodRequests[index]
                                                              ['time']
                                                          .toString(),
                                                  style:
                                                      Styles.normalgeneralText,
                                                ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                                // Text(
                                                //   'Time: ' +
                                                //       bloodRequests[index]
                                                //               ['time']
                                                //           .toString(),
                                                //   style:
                                                //       Styles.normalgeneralText,
                                                // ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }))
                ],
              )
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }
}
