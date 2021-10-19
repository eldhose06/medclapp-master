import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/health_records/health_record_list.dart';
import 'package:medclapp/screens/health_record/record_detail.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class HealthRecordsScreen extends StatefulWidget {
  @override
  _HealthRecordsScreenState createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  List healthRecords = [];
  List filteredHealthRecords = [];
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    getHealthRecords();
  }

  getHealthRecords() async {
    healthRecords = await getHealthRecordDetails();

    healthRecords = healthRecords[2];

    print('healthRecords: $healthRecords');

    for (int i = 0; i < healthRecords.length; i++) {
      print('user: ${healthRecords[i]['user']}');
      print('user: ${globals.customerId}');
      if (healthRecords[i]['user'].toString() ==
          globals.customerId.toString()) {
        print('Equal: $i');
        setState(() {
          filteredHealthRecords.add(healthRecords[i]);
        });
      }
    }

    if (this.mounted) {
      setState(() {
        filteredHealthRecords = filteredHealthRecords;
        dataLoaded = true;
      });
    }

    print('filteredHealthRecords: $filteredHealthRecords');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(
        height: 15,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
        child: FlatButton(
          color: Colors.green,
          onPressed: () {
            Navigator.pushNamed(context, '/addRecord');
          },
          child: Text(
            'Add New Health Record',
            style: Styles.btnWhiteText,
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child:
              // Text('Health Records Screen')
              Column(
                  children: dataLoaded == false
                      ? List.generate(1, (index) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(
                                child: SpinKitFadingCircle(
                              color: Styles.secondaryColor,
                              size: 50.0,
                            )),
                          );
                        })
                      : filteredHealthRecords.toString() == '[]'
                          ? List.generate(1, (index) {
                              return Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'No Health Records Uploaded',
                                                style: Styles.normalgeneralText,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            })
                          : List.generate(filteredHealthRecords.length,
                              (index) {
                              return Column(children: [
                                InkWell(
                                  onTap: () {
                                    print('===ON pressed Health Record Detail');
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                HealthRecordDetailScreen(
                                                    recordDetail:
                                                        filteredHealthRecords[
                                                            index])));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  filteredHealthRecords[index]
                                                          ['description']
                                                      .toString(),
                                                  style:
                                                      Styles.normalgeneralText,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  filteredHealthRecords[index]
                                                          ['date']
                                                      .toString(),
                                                  style:
                                                      Styles.normalgeneralText,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]);
                            })))
    ]);
  }
}
