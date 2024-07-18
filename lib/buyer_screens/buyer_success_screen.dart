import 'package:flutter/material.dart';
import 'package:wear_pro/buyer_screens/buyer_rating_screen.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/rounded_button.dart';

class BuyerSuccessScreen extends StatelessWidget {
  static const String id = 'BuyerSuccessScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/success.png',
            fit: BoxFit.contain,
          ),
          // Center(
          //   child: Text(
          //     'Added Successfully!',
          //     style: kHeadTextBlack.copyWith(
          //         color: kOrange, fontWeight: FontWeight.bold,fontSize: 40),
          //   ),
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Added Successfully!',
                  style: kHeadTextBlack.copyWith(
                      color: kOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Your product is on the way :)',
                      textAlign: TextAlign.center,
                      style: kBodyTextGrey.copyWith(fontSize: 22,height: 1.1)),
                ),
                SizedBox(
                  height: 160,
                ),
                RoundedButton(
                  buttonName: 'Give Feedback',
                  onPress: () =>
                      Navigator.pushNamed(context, BuyerRatingScreen.id),
                ),
                RoundedButton(
                  buttonName: 'Thanks',
                  onPress: () =>
                      Navigator.pushNamed(context, HomeScreen.id),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
