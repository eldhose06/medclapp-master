import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medclapp/functions/health_records/add_new_record.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class AddHealthRecordScreen extends StatefulWidget {
  @override
  _AddHealthRecordScreenState createState() => _AddHealthRecordScreenState();
}

class _AddHealthRecordScreenState extends State<AddHealthRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final memberController = TextEditingController();
  final hospitalController = TextEditingController();
  File _image;

  DateTime selectedDate;
  String selectedDateInString;

  clearForm() {
    dateController.text = "";
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
        globals.globalTabIndex = 2;
      });
      Timer(Duration(seconds: 2), () {
        Navigator.pushNamed(context, '/healthRecordScreen');
      });
    }
  }

  // Attachment Upload
  _uploadProductFromGallery() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'png',
          'jpeg',
        ],
        allowMultiple: false
        // allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
        );
    if (result != null) {
      File image = File(result.files.single.path);
      setState(() {
        _image = image;
      });
      print('_image PATH: ' + _image.path.toString());
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
                      'Add New Medical Record',
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
                                        return 'Description is empty';
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
                                      labelText: 'Description',
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
                          height: 20,
                        ),

                        // Family Member Name
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
                                    controller: memberController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Family Member Name is empty';
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
                                      labelText: 'Family Member Name',
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
                          height: 20,
                        ),

                        // Hospital Name
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
                                    controller: hospitalController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Hospital Name is empty';
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
                                      labelText: 'Hospital Name',
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

                        // Picture
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlineButton(
                            color: Styles.secondaryColor,
                            shape: StadiumBorder(),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Add Record',
                                  style: Styles.normalgeneralGreyText,
                                ),
                                Icon(
                                  Icons.attach_file,
                                  size: 12,
                                  color: Styles.greyColor,
                                )
                              ],
                            ),
                            onPressed: () async {
                              await _uploadProductFromGallery();
                              setState(() {
                                _image = _image;
                              });
                            },
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        _image != null
                            ? Container(
                                child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ))
                            : SizedBox(),

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
                                    List uploadResponse = await uploadRecord(
                                        selectedDateInString,
                                        descriptionController.text,
                                        memberController.text,
                                        hospitalController.text,
                                        _image);
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
