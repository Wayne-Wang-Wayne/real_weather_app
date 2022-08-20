import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';

class PictureDetailPage extends StatelessWidget {
  PictureDetailPage({Key? key}) : super(key: key);
  static const routeName = "/detail-picture";
  @override
  Widget build(BuildContext context) {
    final String pictureUrl =
        (ModalRoute.of(context)!.settings.arguments as Map)["pictureUrl"];
    void downLoadImage() async {
      try {
        ImageDownloader.callback(
            onProgressUpdate: ((String? imageId, int progress) {
          EasyLoading.showProgress(0.0, status: '圖片獲取中.. $progress%');
        }));

        var imageId = await ImageDownloader.downloadImage(pictureUrl);
        EasyLoading.dismiss();
        if (imageId == null) {
          return;
        }

        // Below is a method of obtaining saved image information.
        var fileName = await ImageDownloader.findName(imageId);
        var path = await ImageDownloader.findPath(imageId);
        var size = await ImageDownloader.findByteSize(imageId);
        var mimeType = await ImageDownloader.findMimeType(imageId);
      } on PlatformException catch (error) {
        print(error);
      }
    }

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
                size: 30,
              ),
            ),
          ),
          Positioned(
            height: 130,
            right: 15,
            child: GestureDetector(
              onTap: () async {
                final hasInternet = await MyTools.hasInternet(context);
                if (!hasInternet) return;
                downLoadImage();
              },
              child: Icon(
                Icons.download_rounded,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
