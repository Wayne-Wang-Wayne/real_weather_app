import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/screens/mainPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/showTermsDialog.dart';
import 'package:real_weather_shared_app/mainPage/profilePage/screens/profileScreen.dart';
import 'package:real_weather_shared_app/mainPage/screens/noInternetScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? _currentIndex;
  final _screens = [MainPostScreen(), ProfileScreen()];
  PageController? _pageController;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex!);
    Future.delayed(Duration.zero, () => _showTermsDialog());
    checkInternet();
  }

  Future<void> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternet = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasInternet
          ? PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: _screens,
            )
          : NoInternetScreen(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex!,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _pageController?.jumpToPage(index);
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_rounded), label: "看天氣"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "我的資料")
        ],
      ),
    );
  }

  _showTermsDialog() async {
    showDialog<Null>(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => ShowTermsDialog(),
    );
  }
}
