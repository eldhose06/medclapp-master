import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medclapp/functions/reminders/add_vaccine_reminder.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class AddMedicineReminderScreen extends StatefulWidget {
  @override
  _AddMedicineReminderScreenState createState() =>
      _AddMedicineReminderScreenState();
}

class _AddMedicineReminderScreenState extends State<AddMedicineReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final dateController = TextEditingController();
  final centreController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime selectedDate;
  String selectedDateInString;

  clearForm() {
    dateController.text = "";
    centreController.text = "";
    descriptionController.text = "";
  }

  showResponseMessage(List respList) async {
    final snackbar = SnackBar(
      content: Text(respList[0]),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      backgroundColor: respList[1] == 200 ? Colors.green : Colors.red,
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

    if (respList[1] == 200) {
      clearForm();
      setState(() {
        globals.globalTabIndex = 3;
      });
      Timer(Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/dashboard", (Route<dynamic> route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
        textDirection: globals.defaultLanguage == 'Arabic'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Styles.normalBgColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
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
          body: SafeArea(
              child: SingleChildScrollView(
            padding: EdgeInsets.all(35),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),

                // Sign in Text Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Add New Vaccine Reminder',
                      style: Styles.normalgeneralText,
                    ))
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 45, left: 15, right: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),

                        // Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 120,
                              height: 40,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: 200,
                                      child: Theme(
                                        data: theme.copyWith(
                                            primaryColor: Colors.black),
                                        child: TextFormField(
                                          readOnly: true,
                                          style: Styles.normalgeneralText,
                                          controller: dateController,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Empty Date, Please enter a date';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0.0,
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 0.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                            ),
                                            labelText: 'Date',
                                            labelStyle:
                                                Styles.normalgeneralText,
                                          ),
                                          keyboardType: TextInputType.number,
                                          cursorColor: Colors.grey,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                      child: Image.asset(
                                        'lib/assets/images/icons/calendar.png',
                                        width: 25,
                                      ),
                                      onTap: () async {
                                        final datePick = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );
                                        if (datePick != null &&
                                            datePick != selectedDate) {
                                          setState(() {
                                            selectedDate = datePick;
                                            selectedDateInString =
                                                "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                                            dateController.text =
                                                selectedDateInString;

                                            print(
                                                'dateController.text: {$dateController.text}');
                                          });
                                        }
                                      })
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Vaccine Centre
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                // height: 50,
                                child: Theme(
                                  data: theme.copyWith(
                                      primaryColor: Colors.black),
                                  child: TextFormField(
                                    style: Styles.normalgeneralText,
                                    controller: centreController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Vaccine Centre is empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      labelText: 'Vaccine Centre',
                                      labelStyle: Styles.normalgeneralText,
                                    ),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 20),

                        // Description
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                // height: 50,
                                child: Theme(
                                  data: theme.copyWith(
                                      primaryColor: Colors.black),
                                  child: TextFormField(
                                    style: Styles.normalgeneralText,
                                    controller: descriptionController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Additional Information is empty';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 10.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      labelText: 'Additional Information',
                                      labelStyle: Styles.normalgeneralText,
                                    ),
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 35,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                color: Styles.secondaryColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Styles.secondaryColor,
                                        width: 0.5,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        });
                                    // Navigator.pushNamed(context, '/dashboard');
                                    List uploadResponse =
                                        await addVaccineReminder(
                                            centreController.text,
                                            descriptionController.text,
                                            selectedDateInString);
                                    print('uploadResponse: $uploadResponse');
                                    Navigator.pop(context);
                                    showResponseMessage(uploadResponse);
                                  }
                                  // Navigator.pushNamed(context, '/dashboard');
                                },
                                child: Text(
                                  'Submit',
                                  style: Styles.btnWhiteText,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 35),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
