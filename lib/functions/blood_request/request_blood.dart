import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/globals.dart' as globals;

Client client = Client();

Future<List> requestBlood(
    String group,
    String name,
    String age,
    String location,
    String phone,
    String reqDate,
    String reqTime,
    String priority) async {
  print('INSIDE requestBlood function ${globals.customerId}');

  String resultMessage = '';
  List responseList = [];

  String _uri = APIData.baseApiUrl + 'request';

  Map<String, dynamic> body = {
    'user': '${globals.customerId}',
    'bloodgrouprequest': group,
    'patientname': name,
    'age': age,
    'location': location,
    'phonenumber': phone,
    'date': reqDate,
    'time': reqTime,
    'priority': priority
  };

  print('body: $body');

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  final response = await client.post(_uri, body: body);

  var result = json.decode(utf8.decode(response.bodyBytes));
  // print('result: ' + result.toString());
  resultMessage = result['message'];
  responseList.add(response.statusCode);
  responseList.add(resultMessage);
  try {
    if (response.statusCode == 200) {
      print('In response statusCode 200');

      // print('TOKEN: ' + result['data']['authToken']);
    } else {
      print('Not in response statusCode 200');
    }
  } catch (e) {
    print('INSIDE CATCH');
  }
  return responseList;
}
