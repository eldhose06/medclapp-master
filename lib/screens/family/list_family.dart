import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/family/family_list.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/utils/globals.dart' as globals;
import 'package:medclapp/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ListFamilyMembers extends StatefulWidget {
  @override
  _ListFamilyMembersState createState() => _ListFamilyMembersState();
}

class _ListFamilyMembersState extends State<ListFamilyMembers> {
  List familyList = [];
  bool dataLoaded = false;
  Future<void> _launched;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getFamilyInfo();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
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
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          // Family Member Add
          globals.loggedStatus == 'true'
              ? Container(
                  decoration: BoxDecoration(),
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  child: FlatButton(
                    shape: StadiumBorder(),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pushNamed(context, '/addMember');
                    },
                    child: Text(
                      'Add New Family Member',
                      style: Styles.btnWhiteText,
                    ),
                  ),
                )
              : SizedBox(),

          // Family Members List
          ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: dataLoaded == false
                  ? List.generate(1, (index) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 5,
                        child: Center(
                            child: SpinKitFadingCircle(
                          color: Styles.secondaryColor,
                          size: 50.0,
                        )),
                      );
                    })
                  : familyList == []
                      ? List.generate(1, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'No Family Members Added',
                                          style: Styles.normalgeneralText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        })
                      : List.generate(familyList.length, (index) {
                          return
                              // Text('Family Member 1'),
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[100],
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Full Name
                                    Row(
                                      children: [
                                        Container(
                                            width: 70,
                                            child: Text(
                                              'Full Name: ',
                                              style:
                                                  Styles.normalgeneralGreyText,
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          familyList[index]['fullname']
                                              .toString(),
                                          style: Styles.normalgeneralBlackText,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    // Gender
                                    Row(
                                      children: [
                                        Container(
                                            width: 70,
                                            child: Text(
                                              'Gender: ',
                                              style:
                                                  Styles.normalgeneralGreyText,
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          familyList[index]['gender']
                                              .toString(),
                                          style: Styles.normalgeneralBlackText,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    // DOB
                                    Row(
                                      children: [
                                        Container(
                                          width: 70,
                                          child: Text(
                                            'DOB: ',
                                            style: Styles.normalgeneralGreyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          familyList[index]['dob'].toString(),
                                          style: Styles.normalgeneralBlackText,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    // Relationship
                                    Row(
                                      children: [
                                        Container(
                                          width: 70,
                                          child: Text(
                                            'Relationship: ',
                                            style: Styles.normalgeneralGreyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          familyList[index]['relationship']
                                              .toString(),
                                          style: Styles.normalgeneralBlackText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            _launched = _makePhoneCall(
                                                "tel: ${familyList[index]['phone']}");
                                          });
                                        },
                                        child: Icon(
                                          Icons.phone,
                                          color: Styles.labColorPrimary,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        })),
        ],
      ),
    );
  }
}
