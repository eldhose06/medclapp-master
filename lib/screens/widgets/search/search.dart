import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medclapp/utils/styles.dart';
import 'package:medclapp/utils/globals.dart' as globals;

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _searchController = TextEditingController();
  List finalSearchResultList = [];
  String searchTerm = '';

  _onSearchChanged() async {
    print('Search Changed: ${_searchController.text.length}');
    if (_searchController.text.length > 2) {
      setState(() {
        globals.searchTerm = _searchController.text;
      });
    }
    print('globals.searchTerm: ${globals.searchTerm}');
  }

  @override
  void initState() {
    _onSearchChanged();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
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
    );
  }
}
