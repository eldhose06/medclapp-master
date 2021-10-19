import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/vaccine_centres/listing.dart';
import 'package:medclapp/screens/widgets/footer/bottom_navbar.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/screens/widgets/search/search.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidVaccineCentres extends StatefulWidget {
  @override
  _CovidVaccineCentresState createState() => _CovidVaccineCentresState();
}

class _CovidVaccineCentresState extends State<CovidVaccineCentres> {
  List vaccineCentresList = [];
  Future<void> _launched;
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    getServiceProviderListing();
  }

  getServiceProviderListing() async {
    vaccineCentresList = await getVaccineCentreList();
    print('vaccineCentresList: $vaccineCentresList');

    if (this.mounted) {
      setState(() {
        vaccineCentresList = vaccineCentresList[2];
        dataLoaded = true;
      });
    }

    print('vaccineCentresList: $vaccineCentresList');
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
        preferredSize: Size.fromHeight(120.0),
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
            SearchWidget()
          ],
        ),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(
              children: dataLoaded == false
                  ? List.generate(1, (index) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                            child: SpinKitFadingCircle(
                          color: Styles.secondaryColor,
                          size: 50.0,
                        )),
                      );
                    })
                  : vaccineCentresList == []
                      ? List.generate(1, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'No Listing Details Available',
                                          style: Styles.normalgeneralText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        })
                      : List.generate(vaccineCentresList.length, (index) {
                          return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vaccineCentresList[index]
                                                  ['center_name']
                                              .toString(),
                                          style: Styles.categoryTitleText,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          vaccineCentresList[index]
                                                  ['center_email']
                                              .toString(),
                                          style: Styles.smallgeneralText,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FlatButton(
                                          // color: Styles.secondaryColor,
                                          onPressed: () {
                                            setState(() {
                                              _launched = _makePhoneCall(
                                                  'tel:${vaccineCentresList[index]['center_phone']}');
                                            });
                                          },
                                          child: Icon(
                                            Icons.call,
                                            color: Styles.secondaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        // FlatButton(
                                        //   // color: Styles.secondaryColor,
                                        //   onPressed: () {
                                        //     if (vaccineCentresList[index]
                                        //             ['address'] !=
                                        //         null) {
                                        //       MapsLauncher.launchQuery(
                                        //         vaccineCentresList[index]
                                        //             ['address'],
                                        //       );
                                        //     }
                                        //   },
                                        //   child: Icon(
                                        //     Icons.pin_drop,
                                        //     color: Styles.secondaryColor,
                                        //   ),
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                              ));
                        }))),
      bottomNavigationBar: BottomNavbarWidget(),
    );
  }
}
