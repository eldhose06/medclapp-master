import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medclapp/functions/blood_request/request_blood.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class BloodRequestCreate extends StatefulWidget {
  @override
  _BloodRequestCreateState createState() => _BloodRequestCreateState();
}

class _BloodRequestCreateState extends State<BloodRequestCreate> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final patientNameController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  String _currentSelectedBloodGroup = 'A+';
  var _bloodGroup = ['A+', 'A-', 'AB+', 'AB-', 'B+', 'B-', 'O+', 'O-'];

  String _currentSelectedPriority = 'Within 1 Hour';
  var _priority = [
    'Within 1 Hour',
    'Within 6 Hours',
    'Within 12 Hours',
    'Within 24 Hours'
  ];

  DateTime requestedDate;
  String requestedDateInString;
  String requestedTimeInString;

  bool obscureFlag = true;
  bool profileCompleted = false;

  clearForm() {
    patientNameController.text = "";
    ageController.text = "";
    locationController.text = "";
    phoneController.text = "";
    dateController.text = "";
    timeController.text = "";
  }

  showResponseMessage(List respList) async {
    final snackbar = SnackBar(
      content: Text(respList[1]),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      backgroundColor: respList[0] == 200 ? Colors.green : Colors.red,
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

    if (respList[0] == 200) {
      clearForm();
      setState(() {
        globals.globalTabIndex = 1;
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
                // Sign in Text Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Add Blood Request',
                      style: Styles.normalgeneralText,
                    ))
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 35, left: 15, right: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // Blood Group
                        Container(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 40,
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                  labelStyle: Styles.normalgeneralText,
                                  labelText: 'Select Blood Broup',
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0.0,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                // isEmpty: _currentSelectedBloodGroup == '',
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _currentSelectedBloodGroup,
                                    isDense: true,
                                    onChanged: (String newBloodValue) {
                                      setState(() {
                                        _currentSelectedBloodGroup =
                                            newBloodValue;
                                        state.didChange(newBloodValue);
                                      });
                                    },
                                    items: _bloodGroup.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: Styles.normalgeneralText,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Patient name
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                // height: 50,
                                child: Theme(
                                  data: theme.copyWith(
                                      primaryColor: Styles.greyColor),
                                  child: TextFormField(
                                    style: Styles.normalgeneralText,
                                    controller: patientNameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a patient name';
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
                                      labelText: 'Patient Name',
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

                        // Age
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                // height: 50,
                                child: Theme(
                                  data: theme.copyWith(
                                      primaryColor: Styles.greyColor),
                                  child: TextFormField(
                                    style: Styles.normalgeneralText,
                                    controller: ageController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a valid age';
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
                                      labelText: 'Age',
                                      labelStyle: Styles.normalgeneralText,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 20),

                        // Location
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
                                    controller: locationController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Location is empty';
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
                                      labelText: 'Location',
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

                        // Phone
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
                                    controller: phoneController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Contact Number is empty';
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
                                      labelText: 'Contact Number',
                                      labelStyle: Styles.normalgeneralText,
                                    ),
                                    keyboardType: TextInputType.phone,
                                    cursorColor: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 20),

                        // Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Text(
                            //   'Date of Birth',
                            //   style: Styles.normalgeneralText,
                            // ),
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
                                          // initialDate: fromDate ?? DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        );
                                        if (datePick != null &&
                                            datePick != requestedDate) {
                                          setState(() {
                                            requestedDate = datePick;
                                            requestedDateInString =
                                                "${requestedDate.year}-${requestedDate.month}-${requestedDate.day}";
                                            dateController.text =
                                                requestedDateInString;

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

                        // Time
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
                                    child: TextFormField(
                                      readOnly: true,
                                      style: Styles.normalgeneralText,
                                      controller: timeController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Empty Time, Please enter a time';
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
                                        labelText: 'Time',
                                        labelStyle: Styles.normalgeneralText,
                                      ),
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    child: Image.asset(
                                      'lib/assets/images/icons/calendar.png',
                                      width: 25,
                                    ),
                                    onTap: () async {
                                      final selectedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        // initialTime: selectedTimeList[index]
                                      );

                                      if (selectedTime != null) {
                                        // selectedTime.format(context);

                                        print(
                                            'selectedTime formatted: ${selectedTime.format(context)}');
                                        print(
                                            'selectedTime: ${selectedTime.hour}');
                                        print(
                                            'selectedTime: ${selectedTime.minute}');

                                        setState(() {
                                          requestedTimeInString = selectedTime
                                                  .hour
                                                  .toString()
                                                  .padLeft(2, '0') +
                                              ':' +
                                              selectedTime.minute
                                                  .toString()
                                                  .padLeft(2, '0') +
                                              ':00';
                                          timeController.text =
                                              requestedTimeInString;
                                        });
                                      }
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Priority
                        Container(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 40,
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10.0),
                                  labelStyle: Styles.normalgeneralText,
                                  labelText: 'Within 1 Hour',
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 0.0,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                                isEmpty: _currentSelectedPriority == '',
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _currentSelectedPriority,
                                    isDense: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _currentSelectedPriority = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: _priority.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: Styles.normalgeneralText,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // Priority

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

                                    List requestResponse = await requestBlood(
                                        _currentSelectedBloodGroup,
                                        patientNameController.text,
                                        ageController.text,
                                        locationController.text,
                                        phoneController.text,
                                        requestedDateInString,
                                        requestedTimeInString,
                                        _currentSelectedPriority);

                                    Navigator.pop(context);
                                    print('requestResponse: $requestResponse');

                                    showResponseMessage(requestResponse);
                                  }
                                  // Navigator.pushNamed(context, '/dashboard');
                                },
                                child: Text(
                                  'REQUEST',
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
