import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class MessageListShimmer extends StatelessWidget {
  const MessageListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200,
        child: ListView.builder(
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildShimmerContener(true, 40, 40, 0),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        buildShimmerContener(false, 10, 70, 20),
                        SizedBox(height: 8),
                        buildShimmerContener(false, 10, 200, 20)
                      ],
                    )
                  ],
                ),
              )),
          itemCount: 10,
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
