import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:medclapp/screens/widgets/footer/bottom_navbar.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/screens/widgets/loading_banner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medclapp/utils/styles.dart';

class ServiceProviderDetail extends StatefulWidget {
  final Map listingDetail;

  ServiceProviderDetail({this.listingDetail});

  @override
  _ServiceProviderDetailState createState() =>
      _ServiceProviderDetailState(listingDetail: listingDetail);
}

class _ServiceProviderDetailState extends State<ServiceProviderDetail> {
  final Map listingDetail;
  bool dataLoaded = false;
  Future<void> _launched;
  _ServiceProviderDetailState({this.listingDetail});

  @override
  void initState() {
    super.initState();
    print('listingDetail: $listingDetail');
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Column(
          children: <Widget>[
            AppBar(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Image.asset(
                'lib/assets/images/header.png',
                height: 25,
              ),
              actions: <Widget>[CommonHeaderWidget()],
            ),
          ],
        ),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(children: [
            Container(
              child: CachedNetworkImage(
                width: 100,
                imageUrl: listingDetail['coverpicture'],
                placeholder: (context, url) => LoadingBanner(),
                errorWidget: (context, url, error) => LoadingBanner(),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Text(
                    listingDetail['fullname'].toString(),
                    style: Styles.categoryTitleText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    listingDetail['address'].toString(),
                    style: Styles.smallgeneralText,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: Styles.secondaryColor,
                    onPressed: () {
                      setState(() {
                        _launched =
                            _makePhoneCall('tel:${listingDetail['phone']}');
                      });
                    },
                    child: Text(
                      'Call Hospital',
                      style: Styles.btnWhiteText,
                    ),
                  ),
                  FlatButton(
                    color: Styles.secondaryColor,
                    onPressed: () {
                      if (listingDetail['address'] != null) {
                        MapsLauncher.launchQuery(
                          listingDetail['address'],
                        );
                      }
                    },
                    child: Text(
                      'View Location',
                      style: Styles.btnWhiteText,
                    ),
                  )
                ],
              ),
            ),
          ])),
      bottomNavigationBar: BottomNavbarWidget(),
    );
  }
}
