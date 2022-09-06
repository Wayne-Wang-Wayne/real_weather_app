import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/authPage/screens/ForgotPasswordPage.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/screens/createPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/providers/mainPostPageProvider.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/screens/EditNotifyPage.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/screens/allMedalScreen.dart';
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
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

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
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {}
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

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
      case AllMedalScreen.routeName:
        return CustomPageRoute(
            child: AllMedalScreen(),
            settings: settings,
            direction: AxisDirection.up);
      case ForgotPasswordPage.routeName:
        return CustomPageRoute(
            child: ForgotPasswordPage(),
            settings: settings,
            direction: AxisDirection.up);
      default:
        return CustomPageRoute(child: CreatePostScreen(), settings: settings);
    }
  }
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState>? navigatorKey;
  // This widget is the root of your application.

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    navigatorKey?.currentState?.pushNamedAndRemoveUntil(
      '/',
      (r) => false,
      arguments: message,
    );
  }

  @override
  void initState() {
    super.initState();
    navigatorKey = new GlobalKey<NavigatorState>();
    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                .copyWith(secondary: Colors.white)),
        initialRoute: "/",
        navigatorKey: navigatorKey,
        home: Scaffold(
            body: WillPopScope(
                child: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser == null) return AuthScreen();
                        if (ModalRoute.of(context) == null) return MainScreen();
                        if (ModalRoute.of(context)!.settings.arguments == null)
                          return MainScreen();
                        final RemoteMessage notifyData = ModalRoute.of(context)!
                            .settings
                            .arguments as RemoteMessage;
                        return MainScreen(notifyData: notifyData);
                      } else if (snapshot.hasData) {
                        if (ModalRoute.of(context) == null) return MainScreen();
                        if (ModalRoute.of(context)!.settings.arguments == null)
                          return MainScreen();
                        final RemoteMessage notifyData = ModalRoute.of(context)!
                            .settings
                            .arguments as RemoteMessage;
                        return MainScreen(notifyData: notifyData);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Oops!有東西出錯了。"),
                        );
                      } else {
                        return AuthScreen();
                      }
                    }),
                onWillPop: onWillPop)),
        onGenerateRoute: (route) => MyApp.onGenerateRoute(route),
        builder: EasyLoading.init(),
      ),
    );
  }
}
