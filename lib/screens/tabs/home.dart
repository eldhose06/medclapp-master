import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medclapp/functions/advertisement/ad_list.dart';
import 'package:medclapp/functions/blog/blog.dart';
import 'package:medclapp/functions/service_provider/dental_listing.dart';
import 'package:medclapp/functions/service_provider/hospital_listing.dart';
import 'package:medclapp/functions/service_provider/pharmacy_listing.dart';
import 'package:medclapp/screens/blog/blog_detail.dart';
import 'package:medclapp/screens/listing_detail.dart';
import 'package:medclapp/screens/widgets/loading_banner.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List categoryDetails = [];
  List blogList = [];

  List adList = [];
  List<String> adImagesList = [];
  List<String> adTitleList = [];

  bool dataLoaded = false;
  int _current = 0;

  List hospitalServiceProviderList = [];
  List pharmacyServiceProviderList = [];
  List dentalServiceProviderList = [];

  @override
  void initState() {
    super.initState();
    getBlogListing();
    getAdListing();
    getHospitalServiceProviderListing();
    getPharmacyServiceProviderListing();
    getDentalServiceProviderListing();
  }

  getBlogListing() async {
    blogList = await getBlogList();
    // print('blogList: $blogList');

    if (this.mounted) {
      setState(() {
        blogList = blogList[2]['data'];
        dataLoaded = true;
      });
    }
  }

  getHospitalServiceProviderListing() async {
    hospitalServiceProviderList = await getHospitals();

    if (this.mounted) {
      setState(() {
        hospitalServiceProviderList = hospitalServiceProviderList[2];
      });
    }
  }

  getPharmacyServiceProviderListing() async {
    pharmacyServiceProviderList = await getPharmacies();

    if (this.mounted) {
      setState(() {
        pharmacyServiceProviderList = pharmacyServiceProviderList[2];
      });
    }
  }

  getDentalServiceProviderListing() async {
    dentalServiceProviderList = await getDentalClinics();

    if (this.mounted) {
      setState(() {
        dentalServiceProviderList = dentalServiceProviderList[2];
      });
    }
  }

  getAdListing() async {
    adList = await getAdList();
    // print('adList: $adList');
    adList = adList[2]['data'];
    for (int i = 0; i < adList.length; i++) {
      adImagesList.add(APIData.baseUrl + adList[i]['advert_photo']);
      adTitleList.add(adList[i]['advert_name']);
    }

    if (this.mounted) {
      setState(() {
        adList = adList;
        adImagesList = adImagesList;
        dataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = adImagesList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          // 'Sample Advt. Caption. ${imgList.indexOf(item)}',
                          // adImagesList[adImagesList.indexOf(item)],
                          adTitleList[adImagesList.indexOf(item)],
                          style: Styles.btnWhiteText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child:
          // dataLoaded == false
          //   ? Container(
          //       height: MediaQuery.of(context).size.height,
          //       child: Center(
          //           child: SpinKitFadingCircle(
          //         color: Styles.secondaryColor,
          //         size: 50.0,
          //       )),
          //     )
          //   :

          // Text('')

          Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            // First Row
            Row(
              children: [
                // Hospital Block
                Expanded(
                    child: FlatButton(
                  onPressed: () {
                    globals.selectedCategory = 2;
                    Navigator.pushNamed(context, '/serviceproviderlisting');
                  },
                  child: Container(
                      child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/services/hospital.png',
                        width: 45,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 50,
                        child: Text(
                          'Find Hospital',
                          style: Styles.smallgeneralText,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )),
                )),

                SizedBox(
                  width: 5,
                ),

                // LabTest Block
                Expanded(
                  child: Container(
                      // color: Colors.yellow,
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/services/labtest.png',
                            width: 45,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              'Find Labtest',
                              style: Styles.smallgeneralText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                ),

                SizedBox(
                  width: 5,
                ),

                // Pharmacy Block
                Expanded(
                    child: FlatButton(
                  onPressed: () {
                    globals.selectedCategory = 4;
                    Navigator.pushNamed(context, '/serviceproviderlisting');
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/services/pharmacy.png',
                            width: 43,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              'Find Pharmacy',
                              style: Styles.smallgeneralText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                )),

                SizedBox(
                  width: 5,
                ),

                // Ayurvedha Block
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/services/ayurvedha.png',
                            width: 45,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              'Ayurvedha Centres',
                              style: Styles.smallgeneralText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                ),

                SizedBox(
                  width: 5,
                ),
              ],
            ),

            SizedBox(
              height: 25,
            ),

            // Second Row
            Row(
              children: [
                // Doctors Block
                Expanded(
                  child: Container(
                      // color: Colors.yellow,
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/services/doctor.png',
                            width: 45,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              'Find Doctors',
                              style: Styles.smallgeneralText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                ),

                SizedBox(
                  width: 5,
                ),

                // Insurance Block
                Expanded(
                  child: Container(
                      // color: Colors.yellow,
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/services/insurance.png',
                            width: 45,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              'Find Insurance',
                              style: Styles.smallgeneralText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                ),

                SizedBox(
                  width: 5,
                ),

                // Homeo Block
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/services/homeopathy.png',
                            width: 42,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              'Homeopathi Clinics',
                              style: Styles.smallgeneralText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                ),

                SizedBox(
                  width: 5,
                ),

                // Dental Block
                Expanded(
                    child: FlatButton(
                  onPressed: () {
                    globals.selectedCategory = 1;
                    Navigator.pushNamed(context, '/serviceproviderlisting');
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/services/dental.png',
                            width: 42,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 50,
                            child: Text(
                              'Dental Clinics',
                              style: Styles.smallgeneralText,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                )),

                SizedBox(
                  width: 5,
                ),
              ],
            ),

            SizedBox(
              height: 15,
            ),

            // Advertisement Block
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    // aspectRatio: 2.0,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: adImagesList.map((url) {
                  int index = adImagesList.indexOf(url);
                  return Container(
                    width: 6.0,
                    height: 6.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
            ]),

            SizedBox(
              height: 15,
            ),

            // COVID Sections
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Styles.secondaryColor)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        margin: EdgeInsets.only(right: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              'lib/assets/images/services/vaccine.png',
                              width: 35,
                            ),
                            Expanded(
                              child: Text(
                                'Check COVID Symptoms',
                                style: Styles.smallgeneralText,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/vaccineCentreList');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Styles.secondaryColor)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        margin: EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              'lib/assets/images/services/vaccine.png',
                              width: 35,
                            ),
                            Expanded(
                              child: Text(
                                'COVID Vaccinne Centres Near You',
                                style: Styles.smallgeneralText,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )),
                  ))
                ],
              ),
            ),

            // Blog Section
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Health Feed',
                        style: Styles.categoryTitleText,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            print('Tapped Blog View All');
                            Navigator.pushNamed(context, '/blogList');
                          },
                          child: Text(
                            'View All',
                            style: Styles.categoryTitleText,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Blog Block Starts
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(blogList.length, (int listIndex) {
                        return Container(
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            width: 175,
                            height: 100,
                            margin: EdgeInsets.only(
                                top: 3, bottom: 3, left: 0, right: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: InkWell(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                        // color: Styles.orangeColor,
                                        alignment: Alignment.bottomCenter,
                                        // height: 125,
                                        // width: 225,
                                        child: CachedNetworkImage(
                                          imageUrl: APIData.baseUrl +
                                              blogList[listIndex]['blog_image'],
                                          placeholder: (context, url) =>
                                              LoadingBanner(),
                                          errorWidget: (context, url, error) =>
                                              LoadingBanner(),
                                          fit: BoxFit.fitWidth,
                                        )
                                        // Image.asset(
                                        //     'lib/assets/logo.png',
                                        //     // width: 30,
                                        //   ),
                                        ),
                                    Container(
                                      color: Colors.black26,
                                      // width: double.infinity,
                                      width: 215,
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 5, left: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        blogList[listIndex]['blog_title'],
                                        style: Styles.btnWhiteText,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          BlogDetails(
                                              listingDetail:
                                                  blogList[listIndex])));
                                },
                              ),
                            ));
                      }),
                    ),
                  ),
                  // Blog Block Ends
                ],
              ),
            ),

            // Hospital Section
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hospitals',
                        style: Styles.categoryTitleText,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            globals.selectedCategory = 2;
                            Navigator.pushNamed(
                                context, '/serviceproviderlisting');
                          },
                          child: Text(
                            'View All',
                            style: Styles.categoryTitleText,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Hospital Data Block Starts
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          hospitalServiceProviderList.length, (int listIndex) {
                        return Container(
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            width: 175,
                            height: 100,
                            margin: EdgeInsets.only(
                                top: 3, bottom: 3, left: 0, right: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: InkWell(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                        // color: Styles.orangeColor,
                                        alignment: Alignment.bottomCenter,
                                        // height: 125,
                                        // width: 225,
                                        child: CachedNetworkImage(
                                          imageUrl: hospitalServiceProviderList[
                                              listIndex]['coverpicture'],
                                          placeholder: (context, url) =>
                                              LoadingBanner(),
                                          errorWidget: (context, url, error) =>
                                              LoadingBanner(),
                                          fit: BoxFit.fitWidth,
                                        )
                                        // Image.asset(
                                        //     'lib/assets/logo.png',
                                        //     // width: 30,
                                        //   ),
                                        ),
                                    Container(
                                      color: Colors.black26,
                                      // width: double.infinity,
                                      width: 215,
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 5, left: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        hospitalServiceProviderList[listIndex]
                                            ['fullname'],
                                        style: Styles.btnWhiteText,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          ServiceProviderDetail(
                                              listingDetail:
                                                  hospitalServiceProviderList[
                                                      listIndex])));
                                },
                              ),
                            ));
                      }),
                    ),
                  ),
                  // Hospitals Block Ends
                ],
              ),
            ),

            // Pharmacy Section
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pharmacies',
                        style: Styles.categoryTitleText,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            globals.selectedCategory = 4;
                            Navigator.pushNamed(
                                context, '/serviceproviderlisting');
                          },
                          child: Text(
                            'View All',
                            style: Styles.categoryTitleText,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Pharmacy Data Block Starts
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          pharmacyServiceProviderList.length, (int listIndex) {
                        return Container(
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            width: 175,
                            height: 100,
                            margin: EdgeInsets.only(
                                top: 3, bottom: 3, left: 0, right: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: InkWell(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                        // color: Styles.orangeColor,
                                        alignment: Alignment.bottomCenter,
                                        // height: 125,
                                        // width: 225,
                                        child: CachedNetworkImage(
                                          imageUrl: pharmacyServiceProviderList[
                                              listIndex]['coverpicture'],
                                          placeholder: (context, url) =>
                                              LoadingBanner(),
                                          errorWidget: (context, url, error) =>
                                              LoadingBanner(),
                                          fit: BoxFit.fitWidth,
                                        )
                                        // Image.asset(
                                        //     'lib/assets/logo.png',
                                        //     // width: 30,
                                        //   ),
                                        ),
                                    Container(
                                      color: Colors.black26,
                                      // width: double.infinity,
                                      width: 215,
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 5, left: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        pharmacyServiceProviderList[listIndex]
                                            ['fullname'],
                                        style: Styles.btnWhiteText,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          ServiceProviderDetail(
                                              listingDetail:
                                                  pharmacyServiceProviderList[
                                                      listIndex])));
                                },
                              ),
                            ));
                      }),
                    ),
                  ),
                  // Pharmacy Block Ends
                ],
              ),
            ),

            // Dental Section
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dental Clinics',
                        style: Styles.categoryTitleText,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            globals.selectedCategory = 1;
                            Navigator.pushNamed(
                                context, '/serviceproviderlisting');
                          },
                          child: Text(
                            'View All',
                            style: Styles.categoryTitleText,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Dental Data Block Starts
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(dentalServiceProviderList.length,
                          (int listIndex) {
                        return Container(
                            decoration: BoxDecoration(
                              // color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            width: 175,
                            height: 100,
                            margin: EdgeInsets.only(
                                top: 3, bottom: 3, left: 0, right: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: InkWell(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                        // color: Styles.orangeColor,
                                        alignment: Alignment.bottomCenter,
                                        // height: 125,
                                        // width: 225,
                                        child: CachedNetworkImage(
                                          imageUrl: dentalServiceProviderList[
                                              listIndex]['coverpicture'],
                                          placeholder: (context, url) =>
                                              LoadingBanner(),
                                          errorWidget: (context, url, error) =>
                                              LoadingBanner(),
                                          fit: BoxFit.fitWidth,
                                        )
                                        // Image.asset(
                                        //     'lib/assets/logo.png',
                                        //     // width: 30,
                                        //   ),
                                        ),
                                    Container(
                                      color: Colors.black26,
                                      // width: double.infinity,
                                      width: 215,
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 5, left: 10),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        dentalServiceProviderList[listIndex]
                                            ['fullname'],
                                        style: Styles.btnWhiteText,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          ServiceProviderDetail(
                                              listingDetail:
                                                  dentalServiceProviderList[
                                                      listIndex])));
                                },
                              ),
                            ));
                      }),
                    ),
                  ),
                  // Dental Block Ends
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
