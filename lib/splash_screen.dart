import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/local_auth_api.dart';

String finalEmail;

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(() => Timer(Duration(seconds: 2), () async{
      // print('ababbababbab');
      // final isAuthenticated = await LocalAuthApi.authenticate();
      // print('313113133131');
      // if (isAuthenticated) {
      //   print('sssssssssssss');
      //   Navigator.pushReplacementNamed(
      //
      //           context, finalEmail == null ? LoginScreen.id : HomeScreen.id);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) =>  finalEmail == null ? LoginScreen() : HomeScreen()),
        // );
      // }
          Navigator.pushReplacementNamed(

              context, finalEmail == null ? LoginScreen.id : HomeScreen.id);
        }));
    super.initState();
  }

  Future getValidationData() async {
    final prefs = await SharedPreferences.getInstance();
    var obtainedEmail = prefs.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print('final Email:$finalEmail');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo1.png'),
                  ),
                ),
              ),
            ),
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kOrange)),
          ],
        ),
      ),
    );
    ;
  }
}
