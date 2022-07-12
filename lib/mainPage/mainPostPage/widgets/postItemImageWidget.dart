import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/pictureDetailPage.dart';

class PostItemImage extends StatefulWidget {
  final String imageUrl;
  PostItemImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<PostItemImage> createState() => _PostItemImageState();
}

class _PostItemImageState extends State<PostItemImage>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() => controller.value = animation!.value);
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
            PictureDetailPage.routeName,
            arguments: {"pictureUrl": widget.imageUrl}),
        child: buildImage());
  }

  Widget buildImage() {
    return Hero(
        tag: widget.imageUrl,
        child: InteractiveViewer(
          onInteractionEnd: (details) {
            resetAnimation();
          },
          transformationController: controller,
          panEnabled: false,
          clipBehavior: Clip.none,
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ));
  }

  void resetAnimation() {
    animation = Matrix4Tween(begin: controller.value, end: Matrix4.identity())
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward(from: 0);
  }
}
