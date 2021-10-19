import 'dart:io';
import 'package:http/http.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:medclapp/utils/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

Client client = Client();
String messageResponse = '';
List messageResponseList = [];

Future<List> uploadRecord(String date, String descrip, String memberName,
    String hospitalName, File recordPicture) async {
  print('INSIDE uploadRecord function');
  print('${globals.customerId}, $date, $descrip, $recordPicture');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId');

  String fileName = '';
  String resultMessage = '';
  List responseList = [];

  String _uri = APIData.baseApiUrl + 'medicalrecords';
  print('_uri: $_uri');
  if (recordPicture != null) {
    final mimeTypeData =
        lookupMimeType(recordPicture.path, headerBytes: [0xFF, 0xD8])
            .split('/');

    // var request = new http.MultipartRequest("POST", Uri.parse(_uri));
    MultipartRequest request = MultipartRequest("POST", Uri.parse(_uri));

    // sendRequest.fields['Userid'] = userId;
    request.fields['user'] = globals.customerId;
    request.fields['date'] = date;
    request.fields['description'] = descrip;
    request.fields['name'] = memberName;
    request.fields['hospitalname'] = hospitalName;

    request.files.add(
      await MultipartFile.fromPath(
        'file',
        recordPicture.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        filename: basename(recordPicture.path),
      ),
    );

    StreamedResponse response = await request.send();

    if (response.statusCode < 200 || response.statusCode >= 400) {
      print('There was an error in making the Profile Completion Request');
      print('Status code: ${response.statusCode}');
    } else {
      print('Successfully Updated');
    }

    try {
      if (response.statusCode == 200) {
        messageResponse = 'Record Added Successfully';
        print('In response statusCode 200');
        messageResponseList.add(messageResponse);
        messageResponseList.add(response.statusCode);

        print(
            '=== messageResponseList === : ' + messageResponseList.toString());
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
}
