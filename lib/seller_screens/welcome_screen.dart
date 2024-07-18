import 'package:flutter/material.dart';
import 'package:wear_pro/widgets/rounded_button.dart';

import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Wear Pro, \nLet’s start your business today!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text":
          "We help people connect with store \naround Pakistan to grow their business.",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to sell. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Container(
              width: double.infinity,
              height: size.height *0.12,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo1.png'),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        splashData[index]['text'],
                        style: kBodyTextGrey.copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Image.asset(
                      splashData[index]['image'],
                      height: size.height*0.4,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                splashData.length,
                (index) => buildDot(index: index),
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            GestureDetector(
              onTap: () {},
              child: RoundedButton(buttonName: 'Create  Store',onPress: () =>Navigator.pushReplacementNamed(context, 'ShopDetailsScreen'),),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kOrange : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
