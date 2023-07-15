import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/api_services.dart';
import '../theme/constant.dart';

//enum ConnectionState { none, waiting, active, done }

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  // String getStatus(ConnectionState state, bool hasData, bool hasError) {
  //   final status = (state, hasData, hasError);
  //   return switch (status) {
  //     (ConnectionState.waiting, _, _) => 'Loading',
  //     (_, true, _) => 'Got data',
  //     (_, _, true) => 'Got error',
  //     _ => 'Unknown status',
  //   };
  // }

  late Future<News> futureTNews;
  late Future<News> futureWSNews;
  late Future<News> futureUSNews;
  late Future<News> futureSPNews;
  late Future<News> futureDCNews;

  @override
  void initState() {
    super.initState();
    futureTNews = fetchTNews();
    futureWSNews = fetchWSNews();
    futureUSNews = fetchUSNews();
    futureSPNews = fetchSPNews();
    futureDCNews = fetchDCNews();
  }

  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/arrow-left.svg",
              height: 24,
              width: 24,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isClick = !isClick;
                });
              },
              icon: isClick
                  ? SvgPicture.asset(
                      "assets/icons/bookmark-slash.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      height: 24,
                      width: 24,
                    )
                  : SvgPicture.asset(
                      "assets/icons/bookmark.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      height: 24,
                      width: 24,
                    ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            FutureBuilder(
              future: futureTNews,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          snapshot.data!.title ?? '?',
                          style: Constant.detailHeaderText,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 200,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data!.urlToImage ??
                                    'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(snapshot.data!.author ?? '?',
                                style: Constant.detailAuthorText),
                            Text(
                              "  •  ",
                              style: Constant.detailAuthorText,
                            ),
                            Text(snapshot.data!.name ?? '?',
                                style: Constant.detailAuthorText),
                            Spacer(),
                            Text('3 min', style: Constant.detailAuthorText),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          snapshot.data!.description ?? '?',
                          style: Constant.detailSubHeaderText,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).height,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          snapshot.data!.content ?? '?',
                          style: Constant.detailMainText,
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 175),
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
              },
            )
          ],
        ),
      )),
    );
  }
}
