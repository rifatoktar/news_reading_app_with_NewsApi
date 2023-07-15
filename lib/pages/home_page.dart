import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrollable_list_tabview/scrollable_list_tabview.dart';

import '../main.dart';
import '../services/api_services.dart';
import '../theme/constant.dart';
import '../widgets/big_line.dart';
import '../widgets/small_line.dart';
import 'intro_page.dart';

enum Options { settings, saved, profile, exit }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool light = true;
  var appBarHeight = AppBar().preferredSize.height;
  late Future<News> futureTNews;
  late Future<News> futureWSNews;
  late Future<News> futureUSNews;
  late Future<News> futureSPNews;
  late Future<News> futureDCNews;
  final TextEditingController _searchController = TextEditingController();

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Icon(Icons.check);
      }
      return Icon(Icons.close);
    },
  );

  @override
  void initState() {
    super.initState();
    futureTNews = fetchTNews();
    futureWSNews = fetchWSNews();
    futureUSNews = fetchUSNews();
    futureSPNews = fetchSPNews();
    futureDCNews = fetchDCNews();
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, String iconString, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(iconString,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: Constant.nameText,
          ),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {});

    if (value == Options.settings.index) {
      _settings();
    } else if (value == Options.saved.index) {
      _saved();
    } else if (value == Options.profile.index) {
      _profile();
    } else if (value == Options.exit.index) {
      _exit();
    } else {
      return null;
    }
  }

  _settings() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Settings',
                    style: Constant.mainHeader,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Switch(
                  thumbIcon: thumbIcon,
                  value: light,
                  onChanged: (bool value) {
                    setState(() {
                      light
                          ? MyApp.of(context).changeTheme(ThemeMode.light)
                          : MyApp.of(context).changeTheme(ThemeMode.dark);
                      light = value;
                    });
                  },
                ),
              ],
            ));
      },
    );
  }

  _saved() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Saved News',
                    style: Constant.mainHeader,
                  ),
                ),
              ],
            ));
      },
    );
  }

  _profile() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Profile',
                    style: Constant.mainHeader,
                  ),
                ),
              ],
            ));
      },
    );
  }

  _exit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IntroPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 36,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Mary McMadols',
                style: Constant.nameText,
              ),
              Text(
                'News waiting for you!',
                style: Constant.helloText,
              )
            ],
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: SvgPicture.asset(
              "assets/icons/more.svg",
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            onSelected: (value) {
              _onMenuItemSelected(value as int);
            },
            offset: Offset(0.0, appBarHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            itemBuilder: (ctx) => [
              _buildPopupMenuItem('Settings', "assets/icons/settings.svg",
                  Options.settings.index),
              _buildPopupMenuItem(
                  'Saved', "assets/icons/bookmark.svg", Options.saved.index),
              _buildPopupMenuItem(
                  'Profile', "assets/icons/profile.svg", Options.profile.index),
              _buildPopupMenuItem(
                  'Logout', "assets/icons/sign-out.svg", Options.exit.index),
            ],
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor),
              child: Center(
                child: TextField(
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  cursorColor: primaryColor,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset("assets/icons/search.svg",
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        height: 12,
                        width: 12,
                        fit: BoxFit.scaleDown),
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'Search news...',
                    hintStyle: Constant.searchText,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ScrollableListTabView(
                tabHeight: 48,
                bodyAnimationDuration: const Duration(milliseconds: 150),
                tabAnimationCurve: Curves.easeOut,
                tabAnimationDuration: const Duration(milliseconds: 200),
                tabs: [
                  ScrollableListTab(
                      tab: ListTab(
                          label: Text(
                            'Tech',
                            style: Constant.tabHeaderText,
                          ),
                          activeBackgroundColor: activeTabColor,
                          inactiveBackgroundColor: inactiveTabColor,
                          borderColor: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                          showIconOnList: false),
                      body: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: futureTNews,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        BigLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ]);
                                } else if (snapshot.hasError) {
                                  return Container(
                                    height: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 175),
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error}',
                                      style: Constant.errorText,
                                    ),
                                  );
                                }
                              })
                        ],
                      )),
                  ScrollableListTab(
                      tab: ListTab(
                        label: Text(
                          'Today',
                          style: Constant.tabHeaderText,
                        ),
                        activeBackgroundColor: activeTabColor,
                        inactiveBackgroundColor: inactiveTabColor,
                        borderColor: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      body: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: futureWSNews,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        BigLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ]);
                                } else if (snapshot.hasError) {
                                  return Container(
                                    height: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 175),
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error}',
                                      style: Constant.errorText,
                                    ),
                                  );
                                }
                              })
                        ],
                      )),
                  ScrollableListTab(
                      tab: ListTab(
                        label: Text(
                          'Politic',
                          style: Constant.tabHeaderText,
                        ),
                        activeBackgroundColor: activeTabColor,
                        inactiveBackgroundColor: inactiveTabColor,
                        borderColor: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      body: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: futureUSNews,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        BigLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ]);
                                } else if (snapshot.hasError) {
                                  return Container(
                                    height: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 175),
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error}',
                                      style: Constant.errorText,
                                    ),
                                  );
                                }
                              })
                        ],
                      )),
                  ScrollableListTab(
                      tab: ListTab(
                        label: Text(
                          'Sport',
                          style: Constant.tabHeaderText,
                        ),
                        activeBackgroundColor: activeTabColor,
                        inactiveBackgroundColor: inactiveTabColor,
                        borderColor: primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      body: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: futureSPNews,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        BigLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ]);
                                } else if (snapshot.hasError) {
                                  return Container(
                                    height: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 175),
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error}',
                                      style: Constant.errorText,
                                    ),
                                  );
                                }
                              })
                        ],
                      )),
                  ScrollableListTab(
                      tab: ListTab(
                          label: Text(
                            'Discover',
                            style: Constant.tabHeaderText,
                          ),
                          activeBackgroundColor: activeTabColor,
                          inactiveBackgroundColor: inactiveTabColor,
                          borderColor: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                          showIconOnList: true),
                      body: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: futureDCNews,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        BigLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SmallLine(
                                            urlToImage: snapshot
                                                    .data!.urlToImage ??
                                                'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                                            title: snapshot.data!.title ?? '?',
                                            author:
                                                snapshot.data!.author ?? '?',
                                            name: snapshot.data!.name ?? '?',
                                            publishedAt:
                                                snapshot.data!.publishedAt ??
                                                    '?'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ]);
                                } else if (snapshot.hasError) {
                                  return Container(
                                    height: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 175),
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error}',
                                      style: Constant.errorText,
                                    ),
                                  );
                                }
                              })
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}