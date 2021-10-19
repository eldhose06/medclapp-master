import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/service_provider/listing.dart';
import 'package:medclapp/screens/listing_detail.dart';
import 'package:medclapp/screens/widgets/footer/bottom_navbar.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/screens/widgets/loading_banner.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/styles.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class ServiceProviderListing extends StatefulWidget {
  @override
  _ServiceProviderListingState createState() => _ServiceProviderListingState();
}

class _ServiceProviderListingState extends State<ServiceProviderListing> {
  List serviceProviderList = [];
  bool dataLoaded = false;
  Future<void> _launched;

  int page = 1;
  int lastPage = 0;
  bool isLastPage = false;
  bool isLoading = false;

  Future<List> getServiceProviderDetails() async {
    if (page == lastPage) {
      print('======= //// LAST PAGE REACHED //// ========= $isLoading');
      setState(() {
        isLastPage = true;
        isLoading = false;
      });
    }
    if (isLastPage == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('userId');

      userId == null ? userId = '0' : userId = userId;
      print(
          'INSIDE getServiceProviderDetails function $userId ${globals.searchTerm} ${globals.selectedCategory}');

      String resultMessage = '';
      int statusCode = 0;
      List responseList = [];

      String _uri = APIData.baseApiUrl +
          'list/$userId?search=${globals.searchTerm}&category=${globals.selectedCategory}&page=$page';
      print('_uri: ' + _uri);

      // final response = await client.post(_uri, headers: headers, body: body);

      // print(json.decode(response.body));

      final response = await client.get(_uri);

      var result = json.decode(utf8.decode(response.bodyBytes));
      print('result: ' + result.toString());

      responseList.add(statusCode);
      responseList.add(resultMessage);
      responseList.add(result['results']);

      lastPage = result['count'] != null ? ((result['count']) / 10).round() : 0;

      print('=== lastPage ===: $lastPage');

      if (this.mounted) {
        setState(() {
          page = page + 1;
          lastPage = lastPage;
          isLastPage = isLastPage;
          // subCatId = subCatId;
          isLoading = false;
        });
      }

      return responseList;
    }
  }

  @override
  void initState() {
    super.initState();
    getServiceProviderListing();
    _onSearchChanged();
    _searchController.addListener(_onSearchChanged);
  }

  getServiceProviderListing() async {
    serviceProviderList = await getServiceProviderDetails();
    print('serviceProviderList: $serviceProviderList');

    if (this.mounted) {
      setState(() {
        serviceProviderList = serviceProviderList[2];
        dataLoaded = true;
      });
    }

    print('serviceProviderList: $serviceProviderList');
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final _searchController = TextEditingController();
  List finalSearchResultList = [];
  String searchTerm = '';

  _onSearchChanged() async {
    print('Search Changed: ${searchTerm.length}');

    setState(() {
      searchTerm = _searchController.text;
      page = 1;
      lastPage = 0;
      isLastPage = false;
      isLoading = false;
    });

    // if (searchTerm.length > 3) {
    serviceProviderList = await getServiceProviderDetails();
    print('serviceProviderList: ' + serviceProviderList[2].toString());

    if (this.mounted) {
      setState(() {
        serviceProviderList = serviceProviderList[2];
        finalSearchResultList = finalSearchResultList;
        globals.finalSearchResultList = finalSearchResultList;
        globals.searchTerm = searchTerm;
      });
    }

    // if(globals.searchScreenActive == false) {
    //   _searchController.text = '';
    //   FocusScope.of(context).requestFocus(new FocusNode());
    //   await Navigator.of(context).push(CupertinoPageRoute(
    //     builder: (BuildContext context) => SearchResultWidget()
    //   ));
    // }

    // }
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
            // SearchWidget()
            Container(
              // color: Styles.secondaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              width: MediaQuery.of(context).size.width,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    // controller: searchController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid search term';
                      }
                      return null;
                    },
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 15.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[200],
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        hintText: 'Search',
                        hintStyle: Styles.normalgeneralBlackText,
                        // prefixIcon: Image.asset('lib/assets/images/icons/search.png'),
                        suffixIcon: FlatButton(
                          onPressed: () async {},
                          child: Image.asset(
                            'lib/assets/images/icons/search.png',
                            width: 15,
                          ),
                        )),
                  )),
            )
          ],
        ),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // child: Expanded(
          // child: NotificationListener<ScrollNotification>(
          //     onNotification: (ScrollNotification scrollInfo) {
          //       if (!isLoading &&
          //           scrollInfo.metrics.pixels ==
          //               scrollInfo.metrics.maxScrollExtent) {
          //         // _loadData();
          //         getServiceProviderDetails();
          //         // start loading data
          //         setState(() {
          //           isLoading = true;
          //         });
          //       }
          //     },
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
                  : serviceProviderList == [] || serviceProviderList == null
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
                      : List.generate(serviceProviderList.length, (index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        ServiceProviderDetail(
                                            listingDetail:
                                                serviceProviderList[index])));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: CachedNetworkImage(
                                            width: 100,
                                            imageUrl: serviceProviderList[index]
                                                ['coverpicture'],
                                            placeholder: (context, url) =>
                                                LoadingBanner(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    LoadingBanner(),
                                            fit: BoxFit.cover,
                                          ),

                                          // Image.network(
                                          //   APIData.baseUrl +
                                          //       serviceProviderList[index]['photo'],
                                          //   width: 100,
                                          // ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // color: Colors.yellow,
                                          width: 200,
                                          child: Text(
                                            serviceProviderList[index]
                                                    ['fullname']
                                                .toString(),
                                            style: Styles.categoryTitleText,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          // color: Colors.orange,
                                          width: 200,
                                          child: Text(
                                            serviceProviderList[index]
                                                    ['address']
                                                .toString(),
                                            style: Styles.smallgeneralText,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
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
                                                      'tel:${serviceProviderList[index]['phone']}');
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
                                            FlatButton(
                                              // color: Styles.secondaryColor,
                                              onPressed: () {
                                                if (serviceProviderList[index]
                                                        ['address'] !=
                                                    null) {
                                                  MapsLauncher.launchQuery(
                                                    serviceProviderList[index]
                                                        ['address'],
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                Icons.pin_drop,
                                                color: Styles.secondaryColor,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ));
                        }))),
      // ),
      // ),
      bottomNavigationBar: BottomNavbarWidget(),
    );
  }
}
