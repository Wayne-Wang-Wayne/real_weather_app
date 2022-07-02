import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/providers/createPostProvider.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/screens/createPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/screens/mainScreen.dart';

import 'firebase_options.dart';
import 'mainPage/authPage/providers/googleSignInProvider.dart';
import 'mainPage/authPage/screens/authScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
            create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider<CreatePostProvider>(
            create: (_) => CreatePostProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                      .copyWith(secondary: Colors.white)),
          home: Scaffold(
            body: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                }),
          ),
          routes: {
            CreatePostScreen.routeName: (context) => CreatePostScreen(),
          }),
    );
  }
}
