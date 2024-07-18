import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/providers/location_provider.dart';
import 'package:wear_pro/widgets/rounded_button.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';

class OnBoardScreen extends StatefulWidget {
  static const String id = 'OnBoardScreen';

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Wear Pro, \nPlace order from your favourite shop!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text":
          "We help people connect with store \naround globe to grow their business.",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to buy. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final locationData= Provider.of<LocationProvider>(context,listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.12,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo1.png'),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
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
                    Text(
                      splashData[index]['text'],
                      style: kBodyTextGrey.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Image.asset(
                      splashData[index]['image'],
                      height: size.height *0.3,
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
              height: size.height * 0.1,
            ),
            RoundedButton(
              buttonName: 'Set Delivery Location',
              onPress: () async{
                LocationPermission permission = await Geolocator.requestPermission();
                await locationData.getCurrentLocation();
                if(locationData.permit==true){
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }else{
                  print('Permission not allowed!');
                }
              }
            ),
            SizedBox(
              height: size.height * 0.04,
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
