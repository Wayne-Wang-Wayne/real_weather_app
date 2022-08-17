import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/screens/createPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/providers/mainPostPageProvider.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/screens/EditNotifyPage.dart';
import 'package:real_weather_shared_app/mainPage/screens/mainScreen.dart';
import 'package:real_weather_shared_app/utils/CustomImageCache.dart';
import 'package:real_weather_shared_app/utils/customPageRoute.dart';
import 'package:real_weather_shared_app/utils/pictureDetailPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';
import 'mainPage/authPage/providers/googleSignInProvider.dart';
import 'mainPage/authPage/screens/authScreen.dart';
import 'mainPage/mainPostPage/screens/postMessageScreen.dart';
import 'mainPage/screens/noInternetScreen.dart';

void main() async {
  CustomImageCache();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: "再按一次以離開App");
        return Future.value(false);
      }
      return Future.value(true);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
        ChangeNotifierProvider<MainPostProvider>(
            create: (_) => MainPostProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                .copyWith(secondary: Colors.white)),
        home: Scaffold(
            body: WillPopScope(
                child: StreamBuilder<ConnectivityResult>(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshot) {
                    final conenctivityResult = snapshot.data;
                    if (conenctivityResult == ConnectivityResult.none)
                      return NoInternetScreen();
                    return StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            return MainScreen();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Oops!有東西出錯了。"),
                            );
                          } else {
                            return AuthScreen();
                          }
                        });
                  },
                ),
                onWillPop: onWillPop)),
        onGenerateRoute: (route) => onGenerateRoute(route),
        builder: EasyLoading.init(),
      ),
    );
  }

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreatePostScreen.routeName:
        return CustomPageRoute(
            child: CreatePostScreen(),
            settings: settings,
            direction: AxisDirection.right);
      case PostMessageScreen.routeName:
        return CustomPageRoute(
            child: PostMessageScreen(),
            settings: settings,
            direction: AxisDirection.up);
      case PictureDetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) => PictureDetailPage(), settings: settings);
      case EditNotifyPage.routeName:
        return CustomPageRoute(
            child: EditNotifyPage(),
            settings: settings,
            direction: AxisDirection.up);
      default:
        return CustomPageRoute(child: CreatePostScreen(), settings: settings);
    }
  }
}
