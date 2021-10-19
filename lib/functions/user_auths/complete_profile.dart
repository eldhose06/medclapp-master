import 'dart:io';
import 'package:http/http.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:medclapp/utils/globals.dart' as globals;

Client client = Client();
String messageResponse = '';
List messageResponseList = [];

Future<List> completeProfile(
    String fullName,
    String bloodGroup,
    String gender,
    String dob,
    String height,
    String weight,
    String address,
    File profilepicture) async {
  print('INSIDE completeProfile function');
  print(
      '${globals.customerId}, $fullName, $bloodGroup, $gender, $dob, $height, $weight, $address, ${globals.currentLatitude}, ${globals.currentLongitude}, $profilepicture');

  String fileName = '';
  String resultMessage = '';
  List responseList = [];

  String _uri = APIData.baseApiUrl + 'customer';

  if (profilepicture != null) {
    final mimeTypeData =
        lookupMimeType(profilepicture.path, headerBytes: [0xFF, 0xD8])
            .split('/');

    // var request = new http.MultipartRequest("POST", Uri.parse(_uri));
    MultipartRequest request = MultipartRequest("POST", Uri.parse(_uri));

    // sendRequest.fields['Userid'] = userId;
    request.fields['user'] = globals.customerId;
    request.fields['fullname'] = fullName;
    request.fields['bloodgroup'] = bloodGroup;
    request.fields['gender'] = gender;
    request.fields['dOB'] = dob;
    request.fields['height'] = height;
    request.fields['weight'] = weight;
    request.fields['address'] = address;
    request.fields['latitude'] =
        double.parse(globals.currentLatitude).toStringAsFixed(6);
    request.fields['longitude'] =
        double.parse(globals.currentLongitude).toStringAsFixed(6);

    request.files.add(
      await MultipartFile.fromPath(
        'profilepicture',
        profilepicture.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        filename: basename(profilepicture.path),
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
        messageResponse = 'Profile UPdated Successfully';
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
