import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

import 'package:medclapp/utils/api_details.dart';

Client client = Client();

Future<List> getAdList() async {
  print('INSIDE getAdList function');

  String resultMessage = '';
  int statusCode = 0;
  List responseList = [];

  String _uri = APIData.baseApiUrl + 'ad';
  print('_uri: ' + _uri);

  // final response = await client.post(_uri, headers: headers, body: body);

  // print(json.decode(response.body));

  final response = await client.get(_uri);

  var result = json.decode(utf8.decode(response.bodyBytes));
  // print('result: ' + result.toString());

  responseList.add(statusCode);
  responseList.add(resultMessage);
  responseList.add(result);

  return responseList;
}
