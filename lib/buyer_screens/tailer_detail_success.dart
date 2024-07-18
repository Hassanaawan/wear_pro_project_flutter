import 'package:flutter/material.dart';
import 'package:wear_pro/buyer_screens/home_screen.dart';

class TailorDetailsSuccess extends StatelessWidget {
  static String id = "TailorDetailsSuccess";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7643),
        leading: SizedBox(),
        centerTitle: true,
        titleSpacing: 0,
        title: Text("Tailor Details Success"),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.04),
          Image.asset(
            "assets/images/success.png",
            height: screenHeight * 0.4, //40%
          ),
          SizedBox(height: screenHeight * 0.08),
          Text(
            "Tailor Details Success",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          SizedBox(
            width: screenWidth * 0.6,
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFFF7643),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text(
                  "Back to home",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
