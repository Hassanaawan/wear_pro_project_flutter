import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/seller_screens/add_product_screen.dart';
import 'package:wear_pro/seller_screens/seller_shop_screen.dart';
import 'package:wear_pro/widgets/rounded_button.dart';

class SuccessScreen extends StatelessWidget {
  static const String id = 'SuccessScreen';

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
                      'Your product is successfully sent for Approval.'
                          '\nIt might take 2-3 working days.'
                          '\n Thanks for your patience :)',
                      textAlign: TextAlign.center,
                      style: kBodyTextGrey.copyWith(fontSize: 22,height: 1.1)),
                ),
                SizedBox(
                  height: 160,
                ),
                RoundedButton(
                  buttonName: 'Return To Add Products Screen',
                  onPress: () =>
                      Navigator.pushReplacementNamed(context,SellerShopScreen.id),
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
