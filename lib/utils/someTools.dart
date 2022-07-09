import 'package:intl/intl.dart';

class MyTools {
  static String getReadableTime(int timeStamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    var duration = DateTime.now().difference(dt);
    var readableTime = DateFormat('yyyy/MM/dd HH:mm').format(dt);
    if (duration.inDays == 1) {
      readableTime = "昨天 ${DateFormat('HH:mm').format(dt)}";
    }
    if (duration.inDays == 2) {
      readableTime = "前天 ${DateFormat('HH:mm').format(dt)}";
    }
    if (duration.inHours < 24) {
      readableTime = "${duration.inHours}小時前";
    }
    if (duration.inMinutes < 60) {
      readableTime = "${duration.inMinutes}分鐘前";
    }
    if (duration.inSeconds < 60) {
      readableTime = "${duration.inSeconds}秒鐘前";
    }
    return readableTime;
  }
}
