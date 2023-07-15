import 'package:flutter/material.dart';
import 'package:newsly/theme/constant.dart';

class SmallLine extends StatelessWidget {
  final String urlToImage;
  final String title;
  final String author;
  final String name;
  final String publishedAt;
  const SmallLine(
      {super.key,
      required this.urlToImage,
      required this.title,
      required this.author,
      required this.name,
      required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
          elevation: 0,
          backgroundColor: Colors.transparent),
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(urlToImage), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: MediaQuery.sizeOf(context).height * .07,
                    width: 160,
                    child: Text(title, style: Constant.homeNewsHeaderText)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(author, style: Constant.homeSubHeaderText),
                    Text("  •  ", style: Constant.homeSubHeaderText),
                    Text(name, style: Constant.homeSubHeaderText),
                  ],
                ),
                Text(publishedAt, style: Constant.homeSubHeaderText),
              ],
            )
          ],
        ),
      ),
    );
  }
}
