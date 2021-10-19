import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medclapp/functions/family/add_family_member.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class AddFamilyMember extends StatefulWidget {
  @override
  _AddFamilyMemberState createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final relationController = TextEditingController();
  final phoneController = TextEditingController();

  String _currentSelectedGender = 'Select';
  var _gender = ['Select', 'Male', 'Female', 'Other'];

  DateTime requestedDate;
  String requestedDateInString;
  String requestedTimeInString;

  clearForm() {
    fullNameController.text = "";
    dobController.text = "";
    relationController.text = "";
    phoneController.text = "";
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
        Navigator.pushNamed(context, '/listFamilyMembers');
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
                      'Add Family Member',
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
                        // Full name
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
                                    controller: fullNameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter full name';
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
                                      labelText: 'Full Name',
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

                        // Gender
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
                                  labelText: 'Select Gender',
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
                                    value: _currentSelectedGender,
                                    isDense: true,
                                    onChanged: (String genderVal) {
                                      setState(() {
                                        _currentSelectedGender = genderVal;
                                        state.didChange(genderVal);
                                      });
                                    },
                                    items: _gender.map((String value) {
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

                        // DOB
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
                                          controller: dobController,
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
                                            labelText: 'DOB',
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
                                            datePick != requestedDate) {
                                          setState(() {
                                            requestedDate = datePick;
                                            requestedDateInString =
                                                "${requestedDate.year}-${requestedDate.month}-${requestedDate.day}";
                                            dobController.text =
                                                requestedDateInString;

                                            print(
                                                'dobController.text: {$dobController.text}');
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

                        // Relationship
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
                                    controller: relationController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter the Relationship';
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
                                      labelText: 'Relationship',
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

                                    List requestResponse =
                                        await addFamilyMember(
                                            fullNameController.text,
                                            _currentSelectedGender,
                                            dobController.text,
                                            relationController.text,
                                            phoneController.text);

                                    Navigator.pop(context);
                                    print('requestResponse: $requestResponse');

                                    showResponseMessage(requestResponse);
                                  }
                                  // Navigator.pushNamed(context, '/dashboard');
                                },
                                child: Text(
                                  'ADD MEMBER',
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
