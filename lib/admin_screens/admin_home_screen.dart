import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/admin_screens/admin_login_screen.dart';
import 'package:wear_pro/admin_screens/approval_list_screen.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants.dart';

class AdminHomeScreen extends StatefulWidget {
  static const String id = 'AdminHomeScreen';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: Material(
          color: kOrange,
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/image_8.jpeg'),
                          ),
                        ),
                      ),
                      Text(
                        'Hamza Khan',
                        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'mhamzakhan317@gmail.com',
                        style: kBodyText.copyWith(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                BuildMenuItem(
                  icon: Icons.account_circle_outlined,
                  text: 'Dashboard',
                ),
                BuildMenuItem(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Banner',
                  onPressed: ()=> Navigator.pushNamed(context, AdminHomeScreen.id),
                ),
                BuildMenuItem(
                  icon: FontAwesomeIcons.shoppingBag,
                  text: 'Order',
                ),
                BuildMenuItem(
                  icon: Icons.error,
                  text: 'Categories',
                ),
                SizedBox(height: 35),
                Divider(color: Colors.white, thickness: 1.4),
                SizedBox(
                  height: 35.0,
                ),
                BuildMenuItem(
                  icon: Icons.help,
                  text: 'Help',
                ),
                BuildMenuItem(
                  icon: Icons.logout,
                  text: 'Log Out',
                  onPressed: () {
                    Navigator.pushNamed(context, AdminLoginScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 3,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Add / Delete Banner',
          style: kBodyText,
        ),
        centerTitle: true,
        backgroundColor: kOrange,
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: size.height * 0.45,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: [
              AdminBannerImage(
                imagePath: 'assets/images/image_4.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              AdminBannerImage(
                imagePath: 'assets/images/image_6.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              AdminBannerImage(
                imagePath: 'assets/images/image_8.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              AdminBannerImage(
                imagePath: 'assets/images/image_10.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              AdminBannerImage(
                imagePath: 'assets/images/image_12.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              AdminBannerImage(
                imagePath: 'assets/images/image_13.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              AdminBannerImage(
                imagePath: 'assets/images/image_5.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              AdminBannerImage(
                imagePath: 'assets/images/image_3.jpeg',
                icon: Icons.delete,
                onPressed: () {
                  var snackBar =
                      SnackBar(content: Text('Banner Deleted Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
              buttonName: 'Upload New Banner',
              onPress: () {
                var snackBar =
                    SnackBar(content: Text('Banner Uploaded Successfully'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ),
        ],
      ),
    );
  }
}
