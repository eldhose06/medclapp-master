import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:medclapp/utils/api_details.dart';

Client client = Client();

Future<List> getProfileDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId');

  print('INSIDE getProfileDetails function');

  String resultMessage = '';
  List responseList = [];

  String _uri = APIData.baseApiUrl + 'customerdetail/$userId';
  print('_uri: ' + _uri);

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  final response = await client.get(_uri);

  var result = json.decode(utf8.decode(response.bodyBytes));
  // print('result: ' + result.toString());

  responseList.add(response.statusCode);
  responseList.add(resultMessage);
  responseList.add(result);

  return responseList;
}
