import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class FetchUserBottomSheetShimmer extends StatelessWidget {
  const FetchUserBottomSheetShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            buildShimmerContener(true, 120, 120, 0),
            SizedBox(
              height: 17,
            ),
            buildShimmerContener(false, 23, 70, 20),
            SizedBox(
              height: 8,
            ),
            buildShimmerContener(false, 20, 50, 20),
            SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildShimmerContener(false, 20, 80, 20),
                buildShimmerContener(false, 20, 80, 20)
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ));
  }

  Widget buildShimmerContener(
      bool isCircle, double height, double width, double radius) {
    if (!isCircle) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.all(Radius.circular(radius))),
      );
    } else {
      return Container(
        height: height,
        width: width,
        decoration:
            ShapeDecoration(color: Colors.grey.shade400, shape: CircleBorder()),
      );
    }
  }
}
