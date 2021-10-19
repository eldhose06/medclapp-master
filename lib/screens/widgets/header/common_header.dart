import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medclapp/utils/globals.dart' as globals;
import 'package:medclapp/utils/styles.dart';

class CommonHeaderWidget extends StatefulWidget {
  @override
  _CommonHeaderWidgetState createState() => _CommonHeaderWidgetState();
}

class _CommonHeaderWidgetState extends State<CommonHeaderWidget> {
  String latitude = '';
  String longitude = '';
  List addresses = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    if (this.mounted) {
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        globals.currentLatitude = latitude;
        globals.currentLongitude = longitude;
        globals.currentLocation = addresses.first.featureName;
      });
    }

    print('globals.currentLatitude: ${globals.currentLatitude}');
    print('globals.currentLongitude: ${globals.currentLongitude}');

    print('addresses: ${addresses.first.featureName}');
    print('addresses: ${addresses.first.addressLine}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            globals.currentLocation,
            style: Styles.smallgeneralText,
          ),
          InkWell(
            onTap: () async {
              print('Tapped Add Location');
              await getCurrentLocation();
            },
            child: Stack(children: <Widget>[
              Container(
                width: 55,
                child: FlatButton(
                  child: Image.asset(
                    'lib/assets/images/icons/location.png',
                    width: 20,
                  ),
                  onPressed: () async {
                    print('Tapped Add Location');
                    await getCurrentLocation();
                  },
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
