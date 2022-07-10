import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildShimmerContener(true, 120, 120, 0),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            buildShimmerContener(false, 20, 80, 20),
            SizedBox(
              height: 20,
            ),
            buildShimmerContener(false, 30, 100, 20),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: buildShimmerContener(false, 25, 100, 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: buildShimmerContener(false, 60, double.infinity, 20),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: buildShimmerContener(false, 25, 100, 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: buildShimmerContener(false, 120, double.infinity, 20),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: buildShimmerContener(false, 25, 100, 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: buildShimmerContener(false, 40, double.infinity, 20),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            buildShimmerContener(false, 40, 60, 20)
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
