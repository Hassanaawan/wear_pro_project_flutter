import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';

class OrderScreen extends StatefulWidget {
  static const String id='OrderScreen';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOrange,
        title: Text('Order Screen',style: TextStyle(
          // color: Colors.red
        ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
