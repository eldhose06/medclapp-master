import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medclapp/functions/blog/blog.dart';
import 'package:medclapp/screens/blog/blog_detail.dart';
import 'package:medclapp/screens/widgets/footer/bottom_navbar.dart';
import 'package:medclapp/screens/widgets/header/common_header.dart';
import 'package:medclapp/screens/widgets/loading_banner.dart';
import 'package:medclapp/screens/widgets/search/search.dart';
import 'package:medclapp/utils/api_details.dart';
import 'package:medclapp/utils/styles.dart';

class BlogList extends StatefulWidget {
  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  List blogList = [];
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    getServiceProviderListing();
  }

  getServiceProviderListing() async {
    blogList = await getBlogList();
    print('blogList: $blogList');

    if (this.mounted) {
      setState(() {
        blogList = blogList[2]['data'];
        dataLoaded = true;
      });
    }

    print('blogList: $blogList');
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
                  : blogList == []
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
                      : List.generate(blogList.length, (index) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        BlogDetails(
                                            listingDetail: blogList[index])));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: CachedNetworkImage(
                                            width: 100,
                                            imageUrl: APIData.baseUrl +
                                                blogList[index]['blog_image'],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          // color: Colors.yellow,
                                          width: 200,
                                          child: Text(
                                            blogList[index]['blog_title']
                                                .toString(),
                                            style: Styles.categoryTitleText,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          // color: Colors.yellow,
                                          width: 200,
                                          child: Text(
                                            blogList[index]['blog_description']
                                                .toString(),
                                            style: Styles.categoryTitleText,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Read More',
                                          style: Styles.smallgeneralText,
                                        ),
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
