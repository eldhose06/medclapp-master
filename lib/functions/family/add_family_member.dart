import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/globals.dart' as globals;

Client client = Client();

Future<List> addFamilyMember(String fullName, String gender, String dob,
    String relation, String phone) async {
  print('INSIDE addFamilyMember function ${globals.customerId}');

  List responseList = [];

  String _uri = APIData.baseApiUrl + 'family';

  Map<String, dynamic> body = {
    'user': '${globals.customerId}',
    'fullname': fullName,
    'gender': gender,
    'dob': dob,
    'relationship': relation,
    'phone': phone
  };

  print('body: $body');

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  final response = await client.post(_uri, body: body);

  var result = json.decode(utf8.decode(response.bodyBytes));
  // print('result: ' + result.toString());
  responseList.add(response.statusCode);
  try {
    if (response.statusCode == 200) {
      print('In response statusCode 200');
      responseList.add('Member Added Successfully');
      // print('TOKEN: ' + result['data']['authToken']);
    } else {
      print('Not in response statusCode 200');
      responseList.add('Issue in Adding New Member');
    }
  } catch (e) {
    print('INSIDE CATCH');
  }
  return responseList;
}
