import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:real_weather_shared_app/mainPage/createPostPage/screens/createPostScreen.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/providers/mainPostPageProvider.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/screens/postMessageScreen.dart';
import 'package:real_weather_shared_app/mainPage/mainPostPage/widgets/postItem.dart';
import 'package:real_weather_shared_app/mainPage/models/areaData.dart';
import 'package:real_weather_shared_app/utils/customPageRoute.dart';
import 'package:real_weather_shared_app/utils/someTools.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/postModel.dart';
import '../../models/userModel.dart';
import '../widgets/mainPostShimmer.dart';

class MainPostScreen extends StatefulWidget {
  const MainPostScreen({Key? key}) : super(key: key);

  static List<String> staticCurrentLocation = ["臺北市", "中正區"];

  @override
  State<MainPostScreen> createState() => _MainPostScreenState();
}

class _MainPostScreenState extends State<MainPostScreen>
    with
        AutomaticKeepAliveClientMixin<MainPostScreen>,
        SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<Offset>? offset;
  ScrollController? controller;
  var _showedList = [];
  QuerySnapshot? collectionState;
  bool hasReachedBottom = false;
  bool isFirstLoading = false;
  bool isMoreLoading = false;
  bool canLoadMore = true;
  bool hasLeftTop = false;
  List<String> currentLocation = ["臺北市", "中正區"];

  @override
  void initState() {
    super.initState();
    // todo需要初始化currentLocation(看是要用抓定位的還是存sharedPref的)

    controller = ScrollController()..addListener(_scrollListener);
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(animationController!);
    loadFirstData();
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    animationController!.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (controller!.position.atEdge) {
      final isTop = controller!.position.pixels == 0;
      if (isTop) {
        animationController!.reverse();
        hasLeftTop = false;
      }
    } else {
      if (!hasLeftTop) {
        animationController!.forward();
        hasLeftTop = true;
      }
    }

    if (controller!.position.extentAfter < _showedList.length && canLoadMore) {
      canLoadMore = false;
      loadMore();
    }
  }

  Future<void> loadFirstData({bool needToRelocate = true}) async {
    _showedList = [];
    hasReachedBottom = false;
    collectionState = null;
    setState(() {
      isFirstLoading = true;
    });
    if (needToRelocate) {
      currentLocation = await MyTools().getCurrentLocation(context);
      MainPostScreen.staticCurrentLocation = currentLocation;
    }
    await fetchPostData();

    setState(() {
      isFirstLoading = false;
      canLoadMore = true;
    });
  }

  Future<void> fetchPostData() async {
    List<PostModel> tempPostList = [];
    final originData = collectionState == null
        ? await FirebaseFirestore.instance
            .collection("posts")
            .withConverter(
                fromFirestore: PostModel.fromFirestore,
                toFirestore: (PostModel postModel, options) =>
                    postModel.toFirestore())
            .where("postCity", isEqualTo: currentLocation[0])
            .where("postTown", isEqualTo: currentLocation[1])
            .orderBy("postDateTimeStamp", descending: true)
            .limit(5)
            .get()
        : await FirebaseFirestore.instance
            .collection("posts")
            .withConverter(
                fromFirestore: PostModel.fromFirestore,
                toFirestore: (PostModel postModel, options) =>
                    postModel.toFirestore())
            .where("postCity", isEqualTo: currentLocation[0])
            .where("postTown", isEqualTo: currentLocation[1])
            .orderBy("postDateTimeStamp", descending: true)
            .startAfterDocument(
                collectionState!.docs[collectionState!.docs.length - 1])
            .limit(5)
            .get();
    collectionState = originData;
    originData.docs.asMap().forEach((index, post) {
      tempPostList.add(post.data());
    });
    if (tempPostList.isEmpty) {
      setState(() {
        isFirstLoading = false;
        isMoreLoading = false;
        hasReachedBottom = true;
      });
      return;
    }
    if (tempPostList.length < 5) hasReachedBottom = true;
    await fetchUserData(tempPostList);
  }

  Future<void> fetchUserData(List<dynamic> tempPostList) async {
    for (final item in tempPostList) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel userModel, options) =>
                  userModel.toFirestore())
          .doc((item as PostModel).posterUserId);
      final userModel = await docRef.get().then((value) => value.data());
      item.posterImageUrl = userModel!.userImageUrl;
      item.posterName = userModel.userName;
      item.posterExp = userModel.userExp;
      item.posterLikedTimes = userModel.likedTime;
      item.posterPostTimes = userModel.postTime;
      _showedList.add(item);
    }
  }

  Future<void> loadMore() async {
    if (hasReachedBottom) return;
    setState(() {
      isMoreLoading = true;
    });
    await fetchPostData();
    setState(() {
      isMoreLoading = false;
      canLoadMore = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "即時天氣",
                style: TextStyle(color: Colors.black),
              ),
              isFirstLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade200,
                      child: _getChangeLocationWidget())
                  : _getChangeLocationWidget(),
              SizedBox(
                width: 5,
              )
            ],
          ),
          actions: [
            isFirstLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade200,
                    child: _getCreatePostButton())
                : _getCreatePostButton(),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: isFirstLoading
            ? SingleChildScrollView(child: MainPostShimmer())
            : RefreshIndicator(
                onRefresh: loadFirstData,
                child: _showedList.isEmpty
                    ? SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          child: Center(
                            child: Text('不好意思，目前沒有相關資料！'),
                          ),
                          height: MediaQuery.of(context).size.height -
                              kBottomNavigationBarHeight -
                              AppBar().preferredSize.height,
                        ),
                      )
                    : Stack(
                        children: [
                          ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            controller: controller,
                            itemBuilder: ((context, index) {
                              if (index == _showedList.length &&
                                  isMoreLoading) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return Card(
                                key: ValueKey(
                                    (_showedList[index] as PostModel).postId),
                                child: Column(
                                  children: [
                                    PostItem(
                                      postModel: _showedList[index],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton.icon(
                                          icon: Icon(
                                              (_showedList[index] as PostModel)
                                                      .likedPeopleList!
                                                      .contains(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border),
                                          onPressed: () {
                                            if ((_showedList[index]
                                                    as PostModel)
                                                .likedPeopleList!
                                                .contains(FirebaseAuth.instance
                                                    .currentUser!.uid)) {
                                              (_showedList[index] as PostModel)
                                                  .likedPeopleList!
                                                  .remove(FirebaseAuth.instance
                                                      .currentUser!.uid);
                                            } else {
                                              (_showedList[index] as PostModel)
                                                  .likedPeopleList!
                                                  .add(FirebaseAuth.instance
                                                      .currentUser!.uid);
                                            }
                                            setState(() {});
                                            Provider.of<MainPostProvider>(
                                                    context,
                                                    listen: false)
                                                .likePost(_showedList[index]);
                                          },
                                          label: Text(
                                              "${(_showedList[index] as PostModel).likedPeopleList!.length} 讚"),
                                        ),
                                        TextButton.icon(
                                            onPressed: () {
                                              // Navigator.of(context).push(
                                              //     CustomPageRoute(
                                              //         child: PostMessageScreen(),
                                              //         direction: AxisDirection.up));
                                              Navigator.of(context).pushNamed(
                                                  PostMessageScreen.routeName,
                                                  arguments: {
                                                    "postModel":
                                                        _showedList[index]
                                                            as PostModel
                                                  });
                                            },
                                            icon: Icon(Icons.message_outlined),
                                            label: Text("留言"))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                            itemCount: isMoreLoading
                                ? _showedList.length + 1
                                : _showedList.length,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SlideTransition(
                              position: offset!,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 50.0, horizontal: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    scrollToTop();
                                  },
                                  child: Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 50,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ));
  }

  void scrollToTop() {
    final double start = 0;
    controller!.animateTo(start,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  showPicker(BuildContext context) async {
    Picker(
        height: 100,
        itemExtent: 40,
        adapter: PickerDataAdapter<String>(
            pickerdata: AreaData().areaDataForMainPostPicker),
        hideHeader: true,
        title: Text("選擇地點"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          currentLocation = picker.getSelectedValues() as List<String>;
          loadFirstData(needToRelocate: false);
        }).showDialog(context);
  }

  @override
  bool get wantKeepAlive => true;

  Widget _getChangeLocationWidget() {
    return isFirstLoading
        ? TextButton.icon(
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              size: 35,
            ),
            onPressed: () {
              showPicker(context);
            },
            label: Container(
              height: 10,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ))
        : TextButton.icon(
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              size: 35,
            ),
            onPressed: () {
              showPicker(context);
            },
            label: Text("${currentLocation[0]} ${currentLocation[1]}"));
  }

  Widget _getCreatePostButton() {
    return isFirstLoading
        ? TextButton(
            onPressed: () {},
            child: Text(
              "發佈",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 20),
            ))
        : TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(CreatePostScreen.routeName)
                  .then((needToLoad) {
                if (needToLoad != null) {
                  if (needToLoad as bool) loadFirstData();
                }
              });
            },
            child: Text(
              "發佈",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ));
  }
}
