import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/screens/widgets/loading_banner.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/styles.dart';

class HealthRecordDetailScreen extends StatefulWidget {
  final Map recordDetail;

  HealthRecordDetailScreen({this.recordDetail});

  @override
  _HealthRecordDetailScreenState createState() =>
      _HealthRecordDetailScreenState(recordDetail: recordDetail);
}

class _HealthRecordDetailScreenState extends State<HealthRecordDetailScreen> {
  final Map recordDetail;

  _HealthRecordDetailScreenState({this.recordDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.normalBgColor,
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
        body: SafeArea(
            child: ListView(children: <Widget>[
          SizedBox(
            height: 35,
          ),

          // Sign in Text Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Text(
                'Medical Record Detail',
                style: Styles.healthRecordTitleText,
              ))
            ],
          ),
          // Medical Record Details
          Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(children: [
                Text(
                  recordDetail['description'].toString(),
                  style: Styles.normalgeneralBlackText,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  recordDetail['date'].toString(),
                  style: Styles.smallgeneralText,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: CachedNetworkImage(
                    // width: 100,
                    imageUrl: APIData.baseUrl + recordDetail['file'],
                    placeholder: (context, url) => LoadingBanner(),
                    errorWidget: (context, url, error) => LoadingBanner(),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                Text(
                  'Member Name: ${recordDetail['name'].toString()}',
                  style: Styles.normalgeneralBlackText,
                ),

                SizedBox(
                  height: 15,
                ),

                Text(
                  'Hospital Name: ${recordDetail['hospitalname'].toString()}',
                  style: Styles.normalgeneralBlackText,
                ),

                SizedBox(
                  height: 15,
                ),

                // FlatButton(
                //   onPressed: () async {
                //     if (recordDetail['file'] != null &&
                //         recordDetail['file'] != '') {
                //       try {
                //         var imageId = await ImageDownloader.downloadImage(
                //             APIData.baseUrl + recordDetail['file']);
                //         if (imageId == null) {
                //           return;
                //         }
                //         print(imageId.toString());

                //         var path = await ImageDownloader.findPath(imageId);
                //         await ImageDownloader.open(path);
                //       } on PlatformException catch (error) {
                //         print(error);
                //       }
                //     }
                //   },
                //   child: Text('DOWNLOAD'),
                // )
              ]))
        ])));
  }
}
