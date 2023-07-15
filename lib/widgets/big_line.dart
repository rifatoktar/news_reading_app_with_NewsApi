import 'package:flutter/material.dart';

import '../pages/news_detail_page.dart';
import '../theme/constant.dart';

class BigLine extends StatelessWidget {
  final String urlToImage;
  final String title;
  final String author;
  final String name;
  final String publishedAt;
  const BigLine(
      {super.key,
      required this.urlToImage,
      required this.title,
      required this.author,
      required this.name,
      required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(_createRoute());
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
          elevation: 0,
          backgroundColor: Colors.transparent),
      child: Container(
        height: 220,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(urlToImage), fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 35,
                child: Text(title, style: Constant.homeNewsHeaderText),
              ),
              Row(
                children: [
                  Text(author, style: Constant.homeSubHeaderText),
                  Text(
                    "  •  ",
                    style: Constant.homeSubHeaderText,
                  ),
                  Text(name, style: Constant.homeSubHeaderText),
                  Spacer(),
                  Text(publishedAt, style: Constant.homeSubHeaderText),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const NewsDetailPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
