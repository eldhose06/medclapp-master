import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/globals.dart' as globals;

Client client = Client();

Future<List> getDentalClinics() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId');
  print(
      'INSIDE getServiceProviderDetails function $userId ${globals.searchTerm} ${globals.selectedCategory}');

  String resultMessage = '';
  int statusCode = 0;
  List responseList = [];

  String _uri = APIData.baseApiUrl +
      'list/$userId?search=${globals.searchTerm}&category=1&page=1';
  print('_uri: ' + _uri);

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  final response = await client.get(_uri);

  var result = json.decode(utf8.decode(response.bodyBytes));
  print('result: ' + result.toString());

  responseList.add(statusCode);
  responseList.add(resultMessage);
  responseList.add(result['results']);

  return responseList;
}
