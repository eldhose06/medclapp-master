import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

import 'package:medclapp/utils/api_details.dart';

Client client = Client();

Future<List> signupUser(String phone, String email, String paswd) async {
  print('INSIDE signupUser function');

  String resultMessage = '';
  List responseList = [];

  String _uri = APIData.baseApiUrl + 'userview';

  Map<String, dynamic> body = {
    'phone': phone,
    'email': email,
    'password': paswd
  };

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  final response = await client.post(_uri, body: body);

  var result = json.decode(utf8.decode(response.bodyBytes));
  print('result: ' + result.toString());
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
