import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medclapp/functions/user_auths/complete_profile.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final addressController = TextEditingController();
  File _image;

  String _currentSelectedBloodGroup = 'A+ve';
  var _bloodGroup = [
    'A+ve',
    'A-ve',
    'AB+ve',
    'AB-ve',
    'B+ve',
    'B-ve',
    'O+ve',
    'O-ve'
  ];

  String _currentSelectedGender = 'Select';
  var _gender = ['Select', 'Male', 'Female', 'Other'];

  DateTime requestedDate;
  String requestedDateInString;

  String latitude = '';
  String longitude = '';
  List addresses = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    if (this.mounted) {
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        globals.currentLatitude = latitude;
        globals.currentLongitude = longitude;
        globals.currentLocation = addresses.first.featureName;
      });
    }

    // print('addresses: ${addresses.first.featureName}');
    // print('addresses: ${addresses.first.addressLine}');
  }

  clearForm() {
    fullNameController.text = "";
    dobController.text = "";
    heightController.text = "";
    weightController.text = "";
    addressController.text = "";
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

      Timer(Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/profile", (Route<dynamic> route) => false);
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
          body: SafeArea(
              child: SingleChildScrollView(
            padding: EdgeInsets.all(35),
            child: Column(
              children: <Widget>[
                // Logo Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 125,
                      padding: EdgeInsets.only(top: 35),
                      child: Image.asset(
                        'lib/assets/images/splash_logo.png',
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 35,
                ),

                // Sign in Text Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Complete Profile',
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
                        // Fullname
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
                                        return 'Please enter fullname';
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

                        // Height
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
                                    controller: heightController,
                                    // validator: (value) {
                                    //   if (value.isEmpty) {
                                    //     return 'Please enter your height';
                                    //   }
                                    //   return null;
                                    // },
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
                                      labelText: 'Height in cm',
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

                        // Weight
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
                                    controller: weightController,
                                    // validator: (value) {
                                    //   if (value.isEmpty) {
                                    //     return 'Please enter your weight';
                                    //   }
                                    //   return null;
                                    // },
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
                                      labelText: 'Weight in kg',
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

                        // Address
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
                                    controller: addressController,
                                    // validator: (value) {
                                    //   if (value.isEmpty) {
                                    //     return 'Address is empty';
                                    //   }
                                    //   return null;
                                    // },
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
                                      labelText: 'Address',
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
                                  'Add Picture',
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
                                    List signupResponse = await completeProfile(
                                        fullNameController.text,
                                        _currentSelectedBloodGroup,
                                        _currentSelectedGender,
                                        requestedDateInString,
                                        heightController.text,
                                        weightController.text,
                                        addressController.text,
                                        _image);
                                    print('signupResponse: $signupResponse');
                                    Navigator.pop(context);
                                    showResponseMessage(signupResponse);
                                  }
                                  // Navigator.pushNamed(context, '/dashboard');
                                },
                                child: Text(
                                  'Complete Profile',
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
