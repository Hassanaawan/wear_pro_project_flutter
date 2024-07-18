import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/seller_screens/seller_shop_screen.dart';
import '../constants.dart';
import 'package:wear_pro/widgets/widgets.dart';

class SellerProfileScreen extends StatefulWidget {
  static const String id = 'SellerProfileScreen';

  @override
  _SellerProfileScreenState createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  bool convert = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final user = UserPreferences.myUser;

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Buyers')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              color: kOrange,
            ));
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.white,
                ),
              ),
              backgroundColor: kOrange,
              elevation: 5,
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade500.withOpacity(0.5),
                        radius: size.width * 0.14,
                        foregroundImage:
                            AssetImage('assets/images/image_8.jpeg'),
                        child: Icon(
                          FontAwesomeIcons.user,
                          color: Colors.white,
                          size: size.width * 0.1,
                        ),
                      ),
                    ),
                    Center(
                      child: CircleAvatar(
                        // radius: 50,
                        radius: size.width * 0.17,
                        backgroundColor: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            // upload user image
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: size.height * 0.13,
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                color: kOrange,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1.0),
                              ),
                              child: Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                                size: size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 24),
                Column(
                  children: [
                    Text(
                      snapshot.data.get('fName'),
                      style: kBodyTextBlack,
                    ),
                    SizedBox(height: 5),
                    Text(
                      FirebaseAuth.instance.currentUser.email,
                      style: kBodyTextGrey,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'EditProfileScreen');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Edit Profile',
                            style: kBodyTextBlack.copyWith(
                                color: Colors.blue, fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 22,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                // buildName(user),
                SizedBox(height: 20),
                // NumbersWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                      title: Text(
                        'Buyer Mode',
                        style: kBodyTextBlack,
                      ),
                      subtitle: Text(
                        'Turn switch on to go to buyer mode.',
                        style: kBodyTextGrey,
                      ),
                      activeColor: kOrange,
                      value: convert,
                      onChanged: (selected) {
                        setState(() {
                          convert = !convert;
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.id);
                        });
                        // convert = convert;
                      }),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pushNamed(context, 'WelcomeScreen');
                //   },
                //   child: ProfileListItem(
                //       name: 'Switch To Seller',
                //       icon: Icons.shopping_cart_outlined,
                //       secondIcon: Icons.arrow_forward_ios),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SellerShopScreen.id);
                  },
                  child: ProfileListItem(
                      name: 'My Products',
                      icon: Icons.shopping_cart_outlined,
                      secondIcon: Icons.arrow_forward_ios),
                ),
                SizedBox(height: size.height * 0.015),
                ProfileListItem(
                    name: 'My Orders',
                    icon: Icons.shopping_cart_outlined,
                    secondIcon: Icons.arrow_forward_ios),
                SizedBox(height: size.height * 0.015),
                ProfileListItem(
                    name: 'Help',
                    icon: Icons.shopping_cart_outlined,
                    secondIcon: Icons.arrow_forward_ios),
                SizedBox(height: size.height * 0.015),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  },
                  child: ProfileListItem(
                    name: 'Log Out',
                    icon: Icons.logout,
                    secondIcon: Icons.arrow_forward_ios,
                  ),
                ),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          );
        });
  }
}
