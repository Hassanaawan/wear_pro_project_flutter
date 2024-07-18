import 'package:flutter/material.dart';
import 'package:wear_pro/admin_screens/admin_dashboard_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/rounded_button.dart';

class AdminSuccessScreen extends StatelessWidget {
  static const String id = 'AdminSuccessScreen';

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
                  'Approved Successfully!',
                  style: kHeadTextBlack.copyWith(
                      color: kOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Product will be displayed soon :)',
                      textAlign: TextAlign.center,
                      style: kBodyTextGrey.copyWith(fontSize: 22,height: 1.1)),
                ),
                SizedBox(
                  height: 160,
                ),
                RoundedButton(
                  buttonName: 'Dashboard',
                  onPress: () =>
                      Navigator.pushNamed(context, AdminDashboardScreen.id),
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
