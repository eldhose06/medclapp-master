import 'package:flutter/widgets.dart';
import 'package:medclapp/utils/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

logout(BuildContext context) async {
  globals.loggedStatus = 'false';
  globals.customerId = '';
  globals.customerPhone = '';
  globals.customerEmail = '';
  globals.customerName = '';
  globals.customerPicture = '';

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  // SharedPreferences prefs_new = await SharedPreferences.getInstance();
  // await prefs_new.setString('completedProfile', 'yes');
  globals.globalTabIndex = 0;
  // Navigator.pushNamed(context, '/dashboard');
  Navigator.pushReplacementNamed(context, '/login');
}
