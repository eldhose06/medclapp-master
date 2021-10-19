import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/customer_detail/profile_details.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List fullData = [];
  Map profileData = {};
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    getProfileInfo();
    print('=== globals.loggedStatus ===: ${globals.loggedStatus}');
  }

  getProfileInfo() async {
    if (globals.loggedStatus == 'true') {
      fullData = await getProfileDetails();
      // if (this.mounted) {
      setState(() {
        profileData = fullData[2];
        dataLoaded = true;
      });
    } else {
      setState(() {
        profileData = {};
        dataLoaded = true;
      });
    }
    print('profileData: $profileData');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        child:
            // Text('Profile Screen')
            // dataLoaded == true
            profileData.length != 0
                ? dataLoaded == true
                    ? ListView(
                        children: [
                          Center(
                            child: Text('Profile Details'),
                          ),
                          // Profile Picture
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90)),
                            child: Image.network(APIData.baseUrl +
                                profileData['profilepicture']),
                          ),
                          // Full Name
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                profileData['fullname'].toString(),
                                style: Styles.normalgeneralBlackText,
                                textAlign: TextAlign.center,
                              )),
                          // Blood Group
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Blood Group',
                                      style: Styles.normalgeneralGreyText,
                                    ),
                                  ),
                                  Text(
                                    profileData['bloodgroup'].toString(),
                                    style: Styles.normalgeneralBlackText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),
                          // Gender
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Gender',
                                      style: Styles.normalgeneralGreyText,
                                    ),
                                  ),
                                  Text(
                                    profileData['gender'].toString(),
                                    style: Styles.normalgeneralBlackText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),
                          // DOB
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'DOB',
                                      style: Styles.normalgeneralGreyText,
                                    ),
                                  ),
                                  Text(
                                    profileData['dOB'].toString(),
                                    style: Styles.normalgeneralBlackText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),

                          // Height
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Height',
                                      style: Styles.normalgeneralGreyText,
                                    ),
                                  ),
                                  Text(
                                    profileData['height'].toString(),
                                    style: Styles.normalgeneralBlackText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),

                          // Weight
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Weight',
                                      style: Styles.normalgeneralGreyText,
                                    ),
                                  ),
                                  Text(
                                    profileData['weight'].toString(),
                                    style: Styles.normalgeneralBlackText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )),

                          // Address
                          Container(
                              // color: Colors.amber,
                              height: 100,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              child: Column(
                                children: [
                                  Text(
                                    'Address',
                                    style: Styles.normalgeneralGreyText,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    profileData['address'].toString(),
                                    style: Styles.normalgeneralBlackText,
                                    textAlign: TextAlign.center,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              )),

                          FlatButton(
                            color: Styles.brandLightColor,
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, '/listFamilyMembers');
                            },
                            child: Text(
                              'View Family Members',
                              style: Styles.btnWhiteText,
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          FlatButton(
                            color: Styles.brandLightColor,
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, '/vaccinationReminderList');
                            },
                            child: Text(
                              'View COVID Vaccine Reminder',
                              style: Styles.btnWhiteText,
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          FlatButton(
                            color: Styles.brandLightColor,
                            onPressed: () async {
                              Navigator.pushNamed(
                                  context, '/medicineReminderList');
                            },
                            child: Text(
                              'View Medicine Reminder',
                              style: Styles.btnWhiteText,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: SpinKitFadingCircle(
                          color: Styles.secondaryColor,
                          size: 50.0,
                        )),
                      )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        // height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: Text(
                          'Please login to continue',
                          style: Styles.normalgeneralBlackText,
                        )),
                      ),
                      FlatButton(
                        color: Styles.brandLightColor,
                        onPressed: () async {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'LOGIN ',
                          style: Styles.btnWhiteText,
                        ),
                      )
                    ],
                  ));
  }
}
