import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

import 'package:medclapp/utils/api_details.dart';

Client client = Client();

Future<List> verifyOtp(String phone, String otp) async {
  print('INSIDE verifyOtp function $phone $otp');

  String resultMessage = '';
  List responseList = [];

  String _uri = APIData.baseApiUrl + 'verifyotp';

  Map<String, dynamic> body = {'phone': phone, 'ph_otp': otp};

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  final response = await client.post(_uri, body: body);

  var result = json.decode(utf8.decode(response.bodyBytes));
  print('result: ' + result.toString());
  resultMessage = result['detail'];
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
