import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserTermsPage extends StatelessWidget {
  UserTermsPage({Key? key}) : super(key: key);
  static const routeName = "/user-terms";

  String terms =
      "於您註冊 滑天氣 服務的帳號前，請您先完整閱讀並確認您同意本協議的全部內容，如有任何不同意之處，請您切勿使用 滑天氣；當您完成成為 滑天氣 會員之註冊程序，作為 滑天氣 服務的用戶時，代表您已瞭解且同意遵守本協議下示條款：\n\n註冊和帳號使用\n1. 本服務管理者認為用戶違反本條款或有違反之虞時，得在不事先通知用戶的情形下對該帳號進行停權或刪除。\n2. 您並非為其他人註冊帳號。\n3. 您理解並同意，任何以您的帳號於 滑天氣 服務中所為行為，均視為您本人或經您授權所為，您可能因此必須負擔相應的法律責任，因此您不會讓其他人透過您的帳號使用 滑天氣，亦不會將您的帳號密碼透露與他人知悉。\n4. 用戶於使用本服務時，如有註冊密碼，應自行負責嚴密保管，以免遭到不當使用。利用該密碼所進行的一切行為均視為用戶本人的行為。\n5. 本服務的帳號專屬於用戶個人。用戶於本服務的所有使用權皆不得轉讓、出借予第三人或使第三人繼承。\n\n天氣發佈貼文規範\n用戶內容不得包含下述資訊：\n\n1. 請勿發佈謾罵留言、不雅文字、垃圾訊息。\n2. 請勿發佈與天氣無直接相關之訊息。\n3. 足以引誘、媒介、暗示或其他促使人為性交易之訊息。\n4. 足以引誘、媒介、暗示或其他使兒童或少年有遭受兒童及少年性交易防制條例第 2 條第 1 項第 1 款至第 3 款之虞之訊息。\n5. 侵害他人智慧財產權、肖像權、隱私權或其他權利之內容。\n6. 違反本協議或鼓吹他人違反本協議之內容。\n7. 違反法律強制或禁止規定之內容。\n8. 違反公共秩序或社會善良風俗之內容。\n9. 其他 滑天氣 認為應刪除，並已通知您刪除之內容。\n\n滑天氣 App為何會使用您資料\n為了讓使用者有更方便的使用體驗，包括定位現在您的位置，以及調用您手機的相機功能，讓使用者之間可以迅速共享資訊，以下將詳細解釋。\n\n1. 您在滑天氣App註冊的使用者資料:\n這包含您願意提供的一些基本資料，包含您上傳的大頭貼、信箱、姓名...等。\n\n2. 地理位置資訊:\n 只要您接受App偵測您手機的位置的權限，App會自動使用您手機提供的位置去做顯示，您將不需要每次都自己手動選位置(建議您開啟，以提升App使用體驗)。\n\n3. 相機及相簿:\n根據App相關規範，App需要此權限以讓使用者調用相機及讀取相簿照片，以讓使用者上傳相片。\n\n4. 您隨時可以去App的設定頁調整App的相關設定，個人資料也可以在App內更新，或刪除帳號以刪除您存在在滑天氣App中的個人資料。\n\n服務的提供\n1. 用戶就本服務的使用，應自費及負責備置必要的個人電腦、手機、通信設備、作業系統、通信方式及電力等。\n2. 本服務得按用戶年齡、用戶有無完成身份確認作業、用戶有無註冊資料、其他本公司判斷為必要的條件，將本服務的全部或部分提供給符合上揭條件的用戶。\n3. 於本服務判斷有必要時，得在不事先通知用戶的情形下隨時變更本服務的全部或部分內容，並中止提供本服務。";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "使用者協議",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(terms),
      )),
    );
  }
}
