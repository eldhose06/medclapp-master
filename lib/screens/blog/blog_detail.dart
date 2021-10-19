import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medclapp/screens/widgets/footer/bottom_navbar.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/screens/widgets/loading_banner.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/styles.dart';
// import 'package:share/share.dart';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class BlogDetails extends StatefulWidget {
  final Map listingDetail;
  bool dataLoaded = false;

  BlogDetails({this.listingDetail});

  @override
  _BlogDetailsState createState() =>
      _BlogDetailsState(listingDetail: listingDetail);
}

class _BlogDetailsState extends State<BlogDetails> {
  final Map listingDetail;

  _BlogDetailsState({this.listingDetail});

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
                imageUrl: APIData.baseUrl + listingDetail['blog_image'],
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
                    listingDetail['blog_title'].toString(),
                    style: Styles.categoryTitleText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    listingDetail['blog_description'].toString(),
                    style: Styles.smallgeneralText,
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  // Share Action Button
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Styles.brandLightColor,
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                    child: FlatButton(
                      // color: Colors.black,
                      shape: StadiumBorder(),
                      // padding: EdgeInsets.only(left: 0, bottom: 0, top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Share',
                            style: Styles.btnWhiteText,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        print('Clicked SHARE');
                        // Share.share(
                        //   'Get to know about ' +
                        //       listingDetail['blog_title'].toString() +
                        //       ' by downloading Medclapp application from https://play.google.com/',
                        //   // subject: subject,
                        // );
                        var request = await HttpClient().getUrl(Uri.parse(
                            APIData.baseUrl + listingDetail['blog_image']));
                        var response = await request.close();
                        Uint8List bytes =
                            await consolidateHttpClientResponseBytes(response);
                        await Share.files(
                            'esys images',
                            {
                              'blogImage.png': bytes.buffer.asUint8List(),
                            },
                            '*/*',
                            text: 'Get to know about ' +
                                listingDetail['blog_title'].toString() +
                                ' by downloading Medclapp application from https://play.google.com/');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ])),
      bottomNavigationBar: BottomNavbarWidget(),
    );
  }
}
