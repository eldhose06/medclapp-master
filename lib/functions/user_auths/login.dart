import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:medclapp/functions/customer_detail/profile_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/globals.dart' as globals;

Client client = Client();

Future<List> loginUser(String phone, String paswd) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print('INSIDE loginUser function');

  print('received phone: ' + phone);
  print('received paswd: ' + paswd);

  String resultMessage = '';
  List responseList = [];
  String userToken = '';
  String userId = '';
  List fullData = [];

  String _uri = APIData.baseApiUrl + 'login';
  print('_uri: ' + _uri);

  Map<String, dynamic> body = {'phone': phone, 'password': paswd};

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  try {
    final response = await client.post(_uri, body: body);

    var result = json.decode(utf8.decode(response.bodyBytes));
    print('result: ' + result.toString());
    resultMessage = result['message'];
    responseList.add(response.statusCode);
    responseList.add(resultMessage);

    userToken = result['token'].toString();
    userId = result['user'].toString();

    if (response.statusCode == 200) {
      print('In response statusCode 200');

      await prefs.setString('userAuthToken', userToken);
      await prefs.setString('userId', userId);
      // prefs.setString('customerPhone', result['phone']);
      // prefs.setString('customerEmail', result['email']);
      // prefs.setString('customerName', result['name']);
      // prefs.setString('customerPicture', result['picture']);

      // globals.customerPhone = result['phone'].toString();
      // globals.customerEmail = result['email'].toString();
      // globals.customerName = result['name'].toString();
      // globals.customerPicture = result['picture'].toString();
      globals.loggedStatus = 'true';
      globals.customerId = userId;

      fullData = await getProfileDetails();
      print('=== fullData ===: $fullData');
      if (fullData[0] == 200) {
        await prefs.setString('completedProfile', 'yes');
        globals.completedProfile = 'yes';
      }

      // print('TOKEN: ' + result['data']['authToken']);
      print('=== globals.customerId ===: ' + globals.customerId.toString());
    } else {
      print('Not in response statusCode 200');

      responseList = [];
      resultMessage = 'Invalid Login Details';
      responseList.add(500);
      responseList.add(resultMessage);
    }
  } catch (e) {
    print('INSIDE CATCH');
    responseList = [];
    resultMessage = 'Invalid Login Details';
    responseList.add(500);
    responseList.add(resultMessage);
  }
  return responseList;
}
