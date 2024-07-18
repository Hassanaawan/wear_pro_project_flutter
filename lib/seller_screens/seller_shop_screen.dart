import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/auth_provider.dart';
import 'package:wear_pro/providers/tailor_provider.dart';
import 'package:wear_pro/seller_screens/add_product_screen.dart';
import 'package:wear_pro/seller_screens/seller_profile.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../chat/seller_chat_main_screen.dart';

class SellerShopScreen extends StatefulWidget {
  static const String id = 'ProductApprovalScreen';

  @override
  _SellerShopScreenState createState() => _SellerShopScreenState();
}

class _SellerShopScreenState extends State<SellerShopScreen> {
  bool convert = false;
  final published = FirebaseFirestore.instance
      .collection('Vendors')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('products')
      .where('productPublished', isEqualTo: true)
      .snapshots();
  final approval = FirebaseFirestore.instance
      .collection('Vendors')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('products')
      .where('productPublished', isEqualTo: false)
      .snapshots();
  int label = 1;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    User currentUser = FirebaseAuth.instance.currentUser;
    int currentIndex = 0;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Buyers')
                  .doc(currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      color: kOrange,
                    ),
                  );
                return Drawer(
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
                                      image: AssetImage(
                                          'assets/images/image_8.jpeg'),
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data.get('fName'),
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  FirebaseAuth.instance.currentUser.email,
                                  style: kBodyText.copyWith(fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SellerProfileScreen.id);
                            },
                            child: BuildMenuItem(
                              icon: Icons.account_circle_outlined,
                              text: 'Profile',
                            ),
                          ),
                          BuildMenuItem(
                            icon: FontAwesomeIcons.shoppingBag,
                            text: 'Order',
                          ),
                          GestureDetector(
                            onTap: () {
                              // context.read<ChatProvider>().setbuyerUidandEmail(
                              //     'saMqrgcuMoeJeybe1eBmKHpqflG3');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SellerMainChatScreen()));
                            },
                            child: BuildMenuItem(
                              icon: Icons.chat,
                              text: 'Messages',
                            ),
                          ),
                          BuildMenuItem(
                            icon: Icons.error,
                            text: 'About',
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
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            // leading: GestureDetector(
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.white, shape: BoxShape.circle),
            //       child: Icon(
            //         Icons.arrow_back_ios_sharp,
            //         color: kOrange,
            //         size: 20,
            //       ),
            //     ),
            //   ),
            // ),
            actions: [
              //Todo new widget
              // MaterialButton.icon(onPressed: (){},  icon: Icon(Icons.add,color: kOrange,), label: Text('Add/Remove Products',style: kBodyText,))
            ],
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Column(children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Vendors')
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        color: kOrange,
                      ),
                    );
                  return Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.grey)
                          ],
                          image: DecorationImage(
                              image:
                                  NetworkImage(snapshot.data.get('imageURL')),
                              fit: BoxFit.cover),
                          // borderRadius: BorderRadius.circular(0)
                        ),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.35),
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 65,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: snapshot.data.get('shopOpen') == false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "CLOSE",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  shape: BoxShape.circle),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "OPEN",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Center(
                                  child: Text(
                                    snapshot.data.get('shopName'),
                                    style: kHeadTextBlack.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '3.7 (110)',
                                      style: kBodyText.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwitchListTile(
                  title: Text(
                    'Turn Switch on',
                    style: kBodyTextBlack,
                  ),
                  subtitle: Text(
                    'Turn switch on to open shop.',
                    style: kBodyTextGrey,
                  ),
                  activeColor: kOrange,
                  value: convert,
                  onChanged: (selected) {
                    if (selected) {
                      authProvider.updateSellerStatus(shopStatus: true);
                    } else {
                      authProvider.updateSellerStatus(shopStatus: false);
                    }
                    // if(snapshot.data.get('shopCreated')==true){
                    //   if(snapshot.data.get('shopCategory')=='Tailor'){
                    //     Navigator.pushReplacementNamed(context, SellerTailorScreen.id );
                    //   }else{
                    //     Navigator.pushReplacementNamed(
                    //         context, SellerShopScreen.id);
                    //   }
                    //
                    // }else{
                    //   Navigator.pushReplacementNamed(
                    //       context, WelcomeScreen.id);
                    // }
                    setState(() {
                      convert = !convert;
                    });
                  }),
            ),
            TabBar(
              indicatorColor: kOrange,
              unselectedLabelStyle: kBodyTextGrey.copyWith(fontSize: 14),
              // automaticIndicatorColorAdjustment: true,
              // indicatorWeight: 2.0,
              labelColor: kOrange,
              unselectedLabelColor: kOrange.withOpacity(0.7),
              enableFeedback: true,

              labelStyle: kBodyTextBlack.copyWith(fontSize: 14),
              tabs: [
                Tab(
                  text: 'Published',
                ),
                Tab(
                  text: 'Pending For Approval',
                ),
              ],
            ),
            Expanded(
              child: Card(
                child: TabBarView(children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: published,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                              child: CircularProgressIndicator(
                            color: kOrange,
                          ));
                        final List productTitle = snapshot.data.docs.map((e) {
                          return e['productName'];
                        }).toList();
                        final List productDes = snapshot.data.docs.map((e) {
                          return e['productDescription'];
                        }).toList();
                        final List productPrice = snapshot.data.docs.map((e) {
                          return e['productPrice'];
                        }).toList();
                        final List productURL = snapshot.data.docs.map((e) {
                          return e['productURL'];
                        }).toList();
                        return SingleChildScrollView(
                          child: Column(
                              children: List.generate(
                            snapshot.data.docs.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context, 'ProductDisplayScreen');
                                },
                                child: snapshot.data == null
                                    ? Center(
                                        child: Text(
                                        'No Product Found!',
                                        style: TextStyle(color: Colors.black87),
                                      ))
                                    : ShopProduct(
                                        title: productTitle[index],
                                        des: productDes[index],
                                        price: 'Rs. ${productPrice[index]}',
                                        imagePath: productURL[index],
                                      ),
                              );
                            },
                          )),
                        );
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: approval,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(
                              color: kOrange,
                              // backgroundColor: Colors.red,
                              // strokeWidth: 3.0,
                            ),
                          );
                        final List productTitle = snapshot.data.docs.map((e) {
                          return e['productName'];
                        }).toList();
                        final List productDes = snapshot.data.docs.map((e) {
                          return e['productDescription'];
                        }).toList();
                        final List productPrice = snapshot.data.docs.map((e) {
                          return e['productPrice'];
                        }).toList();
                        final List productURL = snapshot.data.docs.map((e) {
                          return e['productURL'];
                        }).toList();
                        return SingleChildScrollView(
                          child: Column(
                              children: List.generate(
                            snapshot.data.docs.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context, 'ProductDisplayScreen');
                                },
                                child: ShopProduct(
                                  title: productTitle[index],
                                  des: productDes[index],
                                  price: 'Rs. ${productPrice[index]}',
                                  imagePath: productURL[index],
                                ),
                              );
                            },
                          )),
                        );
                      }),
                ]),
              ),
            )
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProductScreen.id);
            },
            child: Container(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            backgroundColor: kOrange,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            onTap: (index) => {
              setState(
                () => currentIndex = index,
              ),
            },
            activeColor: Colors.black87,
            inactiveColor: Colors.white,
            icons: [
              Icons.home,
              Icons.search,
              Icons.favorite,
              Icons.account_circle_outlined,
            ],
            iconSize: 28.0,
            activeIndex: currentIndex,
            backgroundColor: kOrange,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
          ),
        ),
      ),
    );
  }
}
