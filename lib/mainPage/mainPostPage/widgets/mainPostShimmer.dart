import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class MainPostShimmer extends StatelessWidget {
  const MainPostShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmerContener(true, 55, 55, 0),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      buildShimmerContener(false, 15, 70, 20),
                      SizedBox(height: 8),
                      buildShimmerContener(false, 15, 60, 20)
                    ],
                  )
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(width: 6),
                  buildShimmerContener(false, 40, 50, 15),
                  SizedBox(width: 10),
                  buildShimmerContener(false, 15, 100, 20),
                  SizedBox(width: 10),
                  buildShimmerContener(false, 15, 100, 20)
                ],
              ),
              SizedBox(height: 8),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: buildShimmerContener(false, 250, double.infinity, 8)),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: buildShimmerContener(false, 15, double.infinity, 20),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: buildShimmerContener(false, 15, double.infinity, 20),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildShimmerContener(false, 15, 70, 20),
                  buildShimmerContener(false, 15, 70, 20)
                ],
              ),
              SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmerContener(true, 55, 55, 0),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      buildShimmerContener(false, 15, 70, 20),
                      SizedBox(height: 8),
                      buildShimmerContener(false, 15, 60, 20)
                    ],
                  )
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(width: 6),
                  buildShimmerContener(false, 40, 50, 15),
                  SizedBox(width: 10),
                  buildShimmerContener(false, 15, 100, 20),
                  SizedBox(width: 10),
                  buildShimmerContener(false, 15, 100, 20)
                ],
              ),
              SizedBox(height: 8),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: buildShimmerContener(false, 250, double.infinity, 8)),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: buildShimmerContener(false, 15, double.infinity, 20),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: buildShimmerContener(false, 15, double.infinity, 20),
              )
            ],
          ),
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
