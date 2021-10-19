import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/globals.dart' as globals;

Client client = Client();

Future<List> addVaccineReminder(
    String centreName, String additionalInfo, String date) async {
  print('INSIDE addVaccineReminder function ${globals.customerId}');

  List responseList = [];
  String messageResponse = '';
  List messageResponseList = [];

  String _uri = APIData.baseApiUrl + 'covidvaccine';

  Map<String, dynamic> body = {
    'user': '${globals.customerId}',
    'vaccinecentre': centreName,
    'additionalinfo': additionalInfo,
    'date': date
  };

  final response = await client.post(_uri, body: body);

  var result = json.decode(utf8.decode(response.bodyBytes));
  // print('result: ' + result.toString());
  responseList.add(response.statusCode);
  try {
    if (response.statusCode == 200) {
      messageResponse = 'Reminder Added Successfully';
      print('In response statusCode 200');
      messageResponseList.add(messageResponse);
      messageResponseList.add(response.statusCode);

      print('=== messageResponseList === : ' + messageResponseList.toString());
      return messageResponseList;
    } else {
      messageResponse = 'Issue in sending...';
      messageResponseList.add(messageResponse);
      messageResponseList.add(response.statusCode);
      // 'Some Issue In Sending Message';
      print('Not in response statusCode 200');
      return messageResponseList;
    }
    // return messageResponseList;
  } catch (e) {
    print('INSIDE CATCH');
    return messageResponseList;
  }
}
