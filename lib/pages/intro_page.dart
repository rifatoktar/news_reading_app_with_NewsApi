import 'package:flutter/material.dart';

import '../theme/constant.dart';
import 'home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset("assets/images/intro.png"),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              'Newsly',
              style: Constant.mainHeader,
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                  elevation: 0,
                  backgroundColor: Colors.transparent),
              onPressed: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor),
                child: Center(
                  child: Text(
                    'Sign In',
                    style: Constant.signInText,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              child: Text(
                'Continue without sing in',
                style: Constant.signInText2,
              ),
            )
          ],
        ),
      )),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
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
