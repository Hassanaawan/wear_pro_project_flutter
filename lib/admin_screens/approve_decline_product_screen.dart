import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/admin_screens/admin_dashboard_screen.dart';
import 'package:wear_pro/admin_screens/admin_success_screen.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../constants.dart';

class ApproveDeclineProductScreen extends StatefulWidget {
  static const String id = 'ApproveDeclineProductScreen';

  const ApproveDeclineProductScreen({required Key key}) : super(key: key);

  @override
  _ApproveDeclineProductScreenState createState() =>
      _ApproveDeclineProductScreenState();
}

class _ApproveDeclineProductScreenState
    extends State<ApproveDeclineProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('images/boys.jpeg'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(70),
                      bottomLeft: Radius.circular(70),
                    ),
                    child: Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/women17.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 15,
                      ),
                      child: Text(
                        'Women Summer Dress',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15,
                    ),
                    child: Text(
                      'Rs. 2000',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Details...',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30.0,
                  top: 8,
                  right: 30.0,
                ),
                child: Text(
                  'This product is highly recommended by customer.'
                  'Fabric of this product is guaranteed for washing with cold water.'
                  'When you try this product, you will definitely order'
                  'again from our store and hopefully give us good feedback. ',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 30.0,
              //         vertical: 15,
              //       ),
              //       child: Container(
              //         height: 40,
              //         width: 40,
              //         child: Center(
              //           child: Icon(
              //             Icons.add,
              //             color: Colors.white,
              //             size: 30.0,
              //           ),
              //         ),
              //         decoration: BoxDecoration(
              //           color: Colors.grey.shade300,
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(10),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Text(
              //       '01',
              //       style: TextStyle(
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 30.0,
              //         vertical: 15,
              //       ),
              //       child: Container(
              //         height: 40,
              //         width: 40,
              //         child: Center(
              //           child: Icon(
              //             Icons.add,
              //             color: Colors.white,
              //             size: 30.0,
              //           ),
              //         ),
              //         decoration: BoxDecoration(
              //           color: Colors.grey.shade300,
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(10),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Text(
              //       'Total : ',
              //       style: TextStyle(
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Text(
              //       r'$48.05',
              //       style: TextStyle(
              //         fontSize: 26,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AdminDashboardScreen.id);
                          },
                          child: Text(
                            'Rejected',
                            style:
                                kBodyText.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.42,
                      child: RoundedButton(
                        buttonName: 'Accepted',
                        onPress: () {
                          Navigator.pushNamed(context, AdminSuccessScreen.id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
