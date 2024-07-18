import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/providers/chat_provider.dart';
import 'package:wear_pro/widgets/widgets.dart';
import '../chat/buyer_chat_screen.dart';
import '../constants.dart';

class StoresScreen extends StatefulWidget {
  static const String id = 'StoresScreen';
  final String vID;

  const StoresScreen(this.vID);

  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  int label = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // drawer: StreamBuilder<DocumentSnapshot>(
        //     stream: FirebaseFirestore.instance
        //         .collection('Buyers')
        //         .doc(FirebaseAuth.instance.currentUser.uid)
        //         .snapshots(),
        //     builder: (context, snapshot) {
        //       return Drawer(
        //         child: Material(
        //           color: kOrange,
        //           child: SafeArea(
        //             child: ListView(
        //               padding: EdgeInsets.symmetric(horizontal: 20.0),
        //               children: [
        //                 SizedBox(
        //                   height: 40.0,
        //                 ),
        //                 Container(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Container(
        //                         height: 90,
        //                         decoration: BoxDecoration(
        //                           shape: BoxShape.circle,
        //                           image: DecorationImage(
        //                             image: AssetImage(
        //                                 'assets/images/image_8.jpeg'),
        //                           ),
        //                         ),
        //                       ),
        //                       Text(
        //                         snapshot.data.get('fName'),
        //                         style: kBodyText.copyWith(
        //                             fontWeight: FontWeight.bold),
        //                       ),
        //                       Text(
        //                         FirebaseAuth.instance.currentUser.email,
        //                         style: kBodyText.copyWith(fontSize: 18.0),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 50.0,
        //                 ),
        //                 GestureDetector(
        //                   onTap: () {
        //                     Navigator.pushNamed(context, ProfileScreen.id);
        //                   },
        //                   child: BuildMenuItem(
        //                     icon: Icons.account_circle_outlined,
        //                     text: 'Profile',
        //                   ),
        //                 ),
        //                 BuildMenuItem(
        //                   icon: FontAwesomeIcons.shoppingBag,
        //                   text: 'My Orders',
        //                 ),
        //                 BuildMenuItem(
        //                   icon: Icons.error,
        //                   text: 'About',
        //                 ),
        //                 SizedBox(height: 35),
        //                 Divider(color: Colors.white, thickness: 1.4),
        //                 SizedBox(
        //                   height: 35.0,
        //                 ),
        //                 BuildMenuItem(
        //                   icon: Icons.help,
        //                   text: 'Help',
        //                 ),
        //                 BuildMenuItem(
        //                   icon: Icons.logout,
        //                   text: 'Log Out',
        //                   onPressed: () {
        //                     Navigator.pushReplacementNamed(
        //                         context, LoginScreen.id);
        //                   },
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     }),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: kOrange,
                  size: 20,
                ),
              ),
            ),
          ),
          actions: [
            //Todo new widget
            // MaterialButton.icon(onPressed: (){},  icon: Icon(Icons.add,color: kOrange,), label: Text('Add/Remove Products',style: kBodyText,))
          ],
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: Text(
        //     'All Stores',
        //     style: kBodyTextGrey.copyWith(color: kOrange),
        //   ),
        //   centerTitle: true,
        //   // title: Container(
        //   //   decoration: BoxDecoration(
        //   //     color: Colors.orange.shade50,
        //   //     borderRadius: BorderRadius.circular(15.0),
        //   //   ),
        //   //   child: TextField(
        //   //     style: TextStyle(fontSize: 20.0),
        //   //     decoration: InputDecoration(
        //   //       hintText: "Search...",
        //   //       border: InputBorder.none,
        //   //       hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        //   //       prefixIcon: Icon(Icons.search),
        //   //     ),
        //   //   ),
        //   // ),
        //   elevation: 0,
        //   leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.arrow_back_ios_sharp),
        //     color: kOrange,
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: CircleAvatar(
        //         radius: 18.0,
        //         backgroundColor: kOrange,
        //         child: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           child: Icon(
        //             FontAwesomeIcons.user,
        //             color: kOrange,
        //             size: 18.0,
        //           ),
        //           // backgroundImage: AssetImage('assets/images/image_2.jpeg',),
        //           foregroundImage: AssetImage('assets/images/image_8.jpeg'),
        //           radius: 18.0,
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        body: Column(
          // scrollDirection: Axis.vertical,
          // addAutomaticKeepAlives: true,
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Vendors')
                    .doc(widget.vID)
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
            SizedBox(
              height: 20.0,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.8),
              // thickness: 0.7,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'All Products',
                style: kHeadTextBlack.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.8),
              // thickness: 0.7,
              indent: 10,
              endIndent: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Vendors')
                    .doc(widget.vID)
                    .collection('products')
                    .where('productPublished', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                        child: CircularProgressIndicator(
                      color: kOrange,
                    ));
                  final List productID = snapshot.data.docs.map((e) {
                    return e.id;
                  }).toList();
                  final List productTitle = snapshot.data.docs.map((e) {
                    return e['productName'];
                  }).toList();
                  final List productDescription = snapshot.data.docs.map((e) {
                    return e['productDescription'];
                  }).toList();
                  final List productPrice = snapshot.data.docs.map((e) {
                    return e['productPrice'];
                  }).toList();
                  final List productURL = snapshot.data.docs.map((e) {
                    return e['productURL'];
                  }).toList();
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                        snapshot.data.docs.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                              productImage: productURL[index],
                                              productName: productTitle[index],
                                              productPrice: productPrice[index],
                                              productDescription:
                                                  productDescription[index],
                                              pID: productID[index])));
                            },
                            child: snapshot.data.docs == null
                                ? Text(
                                    'No Product Found!',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )
                                : ShopProduct(
                                    title: productTitle[index],
                                    des: productDescription[index],
                                    price: 'Rs. ${productPrice[index]}',
                                    imagePath: productURL[index],
                                  ),
                          );
                        },
                      )),
                    ),
                  );
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kOrange,
          child: Icon(
            Icons.chat,
          ),
          onPressed: () {
            print('uid issssssssssss========== ${widget.vID}');
            context.read<ChatProvider>().setsellerUidandEmail(widget.vID);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BuyerChatScreen()));
          },
        ),
      ),
    );
  }
}
