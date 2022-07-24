import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class CreatePostShimmer extends StatelessWidget {
  const CreatePostShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade200,
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.image_search_rounded,
                            color: Colors.grey.shade400),
                        label: Text("選張照片")),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt_outlined,
                            color: Colors.grey.shade400),
                        label: Text("為天空拍張照")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildShimmerContener(false, 35, 60, 15),
                    SizedBox(
                      width: 10,
                    ),
                    buildShimmerContener(false, 20, 80, 15)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildShimmerContener(false, 35, 100, 6),
                    SizedBox(
                      width: 10,
                    ),
                    buildShimmerContener(false, 35, 100, 6)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                  ),
                ),
              ],
            ),
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
