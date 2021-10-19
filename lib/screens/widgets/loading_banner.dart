import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width,
      // height: 135.0,
      width: 100,
      child: Shimmer.fromColors(
        child: Card(
          color: Colors.grey[200],
        ),
        baseColor: Colors.grey[200],
        highlightColor: Colors.white,
        // period: Duration(seconds: 3),
        direction: ShimmerDirection.ltr,
      ),
    );
  }
}
