import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/reminders/medicine_reminder_list.dart';
import 'package:medclapp/screens/widgets/footer/bottom_navbar.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/utils/styles.dart';

class MedicineReminders extends StatefulWidget {
  @override
  _MedicineRemindersState createState() => _MedicineRemindersState();
}

class _MedicineRemindersState extends State<MedicineReminders> {
  List medicineRemindersList = [];
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    getMedicineReminders();
  }

  getMedicineReminders() async {
    medicineRemindersList = await getMedicineReminderDetails();
    print('medicineRemindersList: $medicineRemindersList');

    if (this.mounted) {
      setState(() {
        medicineRemindersList = medicineRemindersList[2];
        dataLoaded = true;
      });
    }

    print('medicineRemindersList: $medicineRemindersList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: ListView(children: [
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 45),
        //   child: FlatButton(
        //     color: Colors.green,
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/addMedicineReminder');
        //     },
        //     child: Text(
        //       'Add New Medicine Reminder',
        //       style: Styles.btnWhiteText,
        //     ),
        //   ),
        // ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
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
                    : medicineRemindersList.toString() == '[]'
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
                                            'No Medicine Reminders Available',
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
                        : List.generate(medicineRemindersList.length, (index) {
                            return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            medicineRemindersList[index]
                                                    ['medicinename']
                                                .toString(),
                                            style: Styles.categoryTitleText,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'From: ' +
                                                medicineRemindersList[index]
                                                        ['fromdate']
                                                    .toString(),
                                            style: Styles.smallgeneralText,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'To: ' +
                                                medicineRemindersList[index]
                                                        ['todate']
                                                    .toString(),
                                            style: Styles.smallgeneralText,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Frequency: ' +
                                                medicineRemindersList[index]
                                                        ['frequency']
                                                    .toString(),
                                            style: Styles.smallgeneralText,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Time Assigned: ' +
                                                medicineRemindersList[index]
                                                        ['reminder']
                                                    .toString(),
                                            style: Styles.smallgeneralText,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          }))),
      ]),
      bottomNavigationBar: BottomNavbarWidget(),
    );
  }
}
