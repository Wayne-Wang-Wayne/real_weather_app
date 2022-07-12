import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PictureDetailPage extends StatelessWidget {
  PictureDetailPage({Key? key}) : super(key: key);
  static const routeName = "/detail-picture";
  @override
  Widget build(BuildContext context) {
    final String pictureUrl =
        (ModalRoute.of(context)!.settings.arguments as Map)["pictureUrl"];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero(
            tag: pictureUrl,
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        child: Image.network(pictureUrl, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            height: 130,
            left: 15,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
