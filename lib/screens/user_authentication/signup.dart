import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medclapp/functions/user_auths/signup.dart';
import 'package:medclapp/screens/user_authentication/verify_otp.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureFlag = true;
  bool profileCompleted = false;

  clearForm() {
    phoneController.text = "";
    emailController.text = "";
    passwordController.text = "";
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
      Timer(Duration(seconds: 2), () {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, "/verify", (Route<dynamic> route) => false);
        //
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) =>
                VerifyOTP(phone: phoneController.text)));
      });

      // clearForm();
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

                // Welcome Text Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Welcome',
                      style: Styles.bloodGroupText,
                    ))
                  ],
                ),

                SizedBox(
                  height: 15,
                ),

                // Sign in Text Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Sign Up To Continue',
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
                                    controller: phoneController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a valid phone';
                                      } else if (value.length < 12) {
                                        return 'Please enter phone with country code';
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

                        SizedBox(height: 20),

                        // Email
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
                                    controller: emailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a valid email';
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
                                      labelText: 'Email',
                                      labelStyle: Styles.normalgeneralText,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 20),

                        // Password
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
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Password is empty';
                                      } else if (value.length < 6) {
                                        return 'Minimum password length is 6';
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
                                        labelText: 'Password',
                                        labelStyle: Styles.normalgeneralText,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            print('clicked on password view');
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            if (obscureFlag == true) {
                                              setState(() {
                                                obscureFlag = false;
                                              });
                                            } else {
                                              setState(() {
                                                obscureFlag = true;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            obscureFlag == true
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            // color: Colors.white,
                                            size: 15,
                                          ),
                                        )),
                                    keyboardType: TextInputType.text,
                                    obscureText: obscureFlag,
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
                                    // Navigator.of(context).push(
                                    //     CupertinoPageRoute(
                                    //         builder: (BuildContext context) =>
                                    //             VerifyOTP(
                                    //                 phone: '+' +
                                    //                     phoneController.text,
                                    //                 email: emailController.text,
                                    //                 password: passwordController
                                    //                     .text)));
                                    // Navigator.pushNamed(context, '/verify');
                                    List signupResponse = await signupUser(
                                        '+' + phoneController.text.trim(),
                                        emailController.text,
                                        passwordController.text);

                                    Navigator.pop(context);
                                    showResponseMessage(signupResponse);
                                  }
                                  // Navigator.pushNamed(context, '/dashboard');
                                },
                                child: Text(
                                  'Sign Up',
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
                                    padding:
                                        EdgeInsets.only(top: 5, bottom: 15),
                                    child: Text('Forgot Password',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Styles.redColor,
                                            fontSize: 12)),
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
                                    padding:
                                        EdgeInsets.only(top: 5, bottom: 15),
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
        ));
  }
}
