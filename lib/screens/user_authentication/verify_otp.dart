import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medclapp/functions/user_auths/verify_otp.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTP extends StatefulWidget {
  final String phone;

  VerifyOTP({this.phone});

  @override
  _VerifyOTPState createState() => _VerifyOTPState(phone: phone);
}

class _VerifyOTPState extends State<VerifyOTP> {
  final String phone;

  _VerifyOTPState({this.phone});

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  clearForm() {
    phoneController.text = "";
    otpController.text = "";
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

      Timer(Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/login", (Route<dynamic> route) => false);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    assignPhone();
    print('=== phone ===: $phone');
  }

  assignPhone() async {
    setState(() {
      phoneController.text = '+' + phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                  'Verify OTP To Continue',
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
                    // Phone
                    Visibility(
                      visible: false,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              // height: 50,
                              child: Theme(
                                data: theme.copyWith(
                                    primaryColor: Styles.greyColor),
                                child: TextFormField(
                                  style: Styles.normalgeneralText,
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter a valid phone';
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
                                    labelText: 'Phone',
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
                    ),

                    SizedBox(height: 20),

                    // // OTP
                    // Row(
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: Container(
                    //         // height: 50,
                    //         child: Theme(
                    //           data: theme.copyWith(
                    //               primaryColor: Styles.greyColor),
                    //           child: TextFormField(
                    //             style: Styles.normalgeneralText,
                    //             controller: otpController,
                    //             validator: (value) {
                    //               if (value.isEmpty) {
                    //                 return 'Please enter a valid OTP';
                    //               }
                    //               return null;
                    //             },
                    //             decoration: InputDecoration(
                    //               contentPadding: EdgeInsets.symmetric(
                    //                   vertical: 0.0, horizontal: 10.0),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   width: 0.0,
                    //                 ),
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(30.0)),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   width: 0.0,
                    //                 ),
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(30.0)),
                    //               ),
                    //               errorBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   width: 0.0,
                    //                 ),
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(30.0)),
                    //               ),
                    //               focusedErrorBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   width: 0.0,
                    //                 ),
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(30.0)),
                    //               ),
                    //               labelText: 'OTP',
                    //               labelStyle: Styles.normalgeneralText,
                    //             ),
                    //             keyboardType: TextInputType.number,
                    //             cursorColor: Colors.grey,
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),

                    // SizedBox(
                    //   height: 75,
                    // ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Text('Enter OTP', style: Styles.normalgeneralText,),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: PinCodeTextField(
                                textInputType: TextInputType.number,
                                backgroundColor: Colors.transparent,
                                // textStyle: Styles.lightWhite,
                                length: 6,
                                obsecureText: false,
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v.length < 6) {
                                    return 'Please Enter Valid Code';
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 45,
                                    fieldWidth: 40,
                                    activeColor: Colors.white,
                                    borderWidth: 1.0,
                                    inactiveColor: Styles.secondaryColor,
                                    selectedColor: Colors.green),
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: false,
                                errorTextSpace: 35,
                                controller: otpController,
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                onChanged: (value) {
                                  print(value);
                                  // setState(() {
                                  //   currentText = value;
                                  // });
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  return true;
                                },
                              )),
                        ],
                      ),
                    ),

                    // SizedBox(
                    //   height: 15,
                    // ),

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
                                List signupResponse = await verifyOtp(
                                    phoneController.text.trim(),
                                    otpController.text);

                                Navigator.pop(context);
                                showResponseMessage(signupResponse);
                              }
                              // Navigator.pushNamed(context, '/dashboard');
                            },
                            child: Text(
                              'Verify',
                              style: Styles.btnWhiteText,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 35),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: InkWell(
                              onTap: () async {
                                // clearForm();
                                // Navigator.pushNamed(context, '/forgot');
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 15),
                                child: Text('Forgot Password',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Styles.redColor, fontSize: 12)),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: InkWell(
                              onTap: () async {
                                clearForm();
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 15),
                                child: Text('Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Styles.secondaryColor,
                                        fontSize: 12)),
                              )),
                        )
                      ],
                    ),

                    SizedBox(height: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
