import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/providers/tailor_provider.dart';
import 'package:wear_pro/seller_screens/seller_profile.dart';
import '../buyer_screens/login_screen.dart';
import '../buyer_screens/measurement_screen.dart';
import '../constants.dart';
import '../providers/product_provider.dart';
import '../widgets/build_menu_item.dart';

class SellerTailorScreen extends StatefulWidget {
  static const String id = 'SellerTailorScreen';
  final String vID;

  const SellerTailorScreen(this.vID);

  @override
  _SellerTailorScreenState createState() => _SellerTailorScreenState();
}

class _SellerTailorScreenState extends State<SellerTailorScreen> {
  bool convert = false;
  TailorProvider tailorProvider;
  int label = 1;
  File _image;
  String shopName;

  Future<String> uploadProductImage(filePath) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    File file = File(filePath); //need file path to upload
    var timeStamp = Timestamp.now();
    try {
      await _storage.ref('TailorSamplesImages/$timeStamp').putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
    String downloadURL =
        await _storage.ref('TailorSamplesImages/$timeStamp').getDownloadURL();
    return downloadURL;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    tailorProvider = Provider.of(context);
    tailorProvider.fetchTailorSampleData();
    final _productProvider = Provider.of<ProductProvider>(context);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Buyers')
                .doc(FirebaseAuth.instance.currentUser.uid)
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          // leading: GestureDetector(
          //   onTap: () {
          //     // Navigator.pop(context);
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       decoration:
          //           BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Tailors')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: kOrange,
                        semanticsLabel: 'Kindly Wait',
                        semanticsValue: '...',
                      ),
                      // Timer(Duration(seconds: 4)),
                      Text('kindly wait...'),
                    ],
                  ),
                );
              return Column(
                // scrollDirection: Axis.vertical,
                // addAutomaticKeepAlives: true,
                children: [
                  Stack(
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
                                      color: Color(0xffFF9529),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      snapshot.data.get('rating'),
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
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  // Divider(
                  //   color: Colors.grey.withOpacity(0.8),
                  //   thickness: 0.7,
                  // indent: 10,
                  // endIndent: 10,
                  // ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Column(
                              children: [
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
                                          tailorProvider.updateTailorData(
                                              shopStatus: true);
                                        } else {
                                          tailorProvider.updateTailorData(
                                              shopStatus: false);
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
                                Container(
                                  height: 50.0,
                                  width: size.width * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kOrange,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      _productProvider
                                          .getProductImage()
                                          .then((img) {
                                        setState(() {
                                          _image = img;
                                          this.shopName =
                                              snapshot.data.get('shopName');
                                        });
                                        //uploadimages...
                                        uploadProductImage(_image.path)
                                            .then((url) {
                                          //tailor provider
                                          // print('+++++++++++++++++++++++++++++++++++++$url');
                                          tailorProvider.addTailorSampleImage(
                                              tailorSampleImage: url);
                                        });
                                      });
                                      // Navigator.pushNamed(
                                      //     context, MeasurementScreen.id);
                                    },
                                    child: Text(
                                      'Add Samples >',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.8),
                            // thickness: 0.7,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Text(
                            'Feature Designs',
                            style: kBodyTextBlack,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: tailorProvider.getTailorSampleList
                                  .map((samples) {
                                // print('.........................................${samples.tailorImage}');
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: size.height * 0.3,
                                      width: size.width * 0.6,
                                      // color: Colors.red,
                                      child: Stack(
                                        children: [
                                          // Image.network(snapshot.data['imageURL']),
                                          Container(
                                            height: 350,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                // image: Image.network(document['imageURL']),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        samples.tailorImage),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          Container(
                                            height: 200,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                // color: Colors.black87.withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Padding(
                                                //     padding: const EdgeInsets.all(18.0),
                                                //     child: Align(
                                                //       alignment: Alignment.topRight,
                                                //       child: Text(
                                                //         '${shopsDistance[index]}Km',
                                                //         // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
                                                //         style: kBodyText.copyWith(
                                                //             fontSize: 14,
                                                //             color: Colors.white),
                                                //       ),
                                                //     )),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(18.0),
                                                //   child: Row(
                                                //     children: [
                                                //       Icon(FontAwesomeIcons.store,
                                                //           size: 18,
                                                //           color: Colors.white),
                                                //       SizedBox(
                                                //         width: 10,
                                                //       ),
                                                //       Expanded(
                                                //         child: Text('Men\'s Kurta',
                                                //             style: kBodyText),
                                                //       ),
                                                //       SizedBox(
                                                //         width: size.width * 0.02,
                                                //       ),
                                                //     ],
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              //     children: List.generate(
                              //   tailorProvider.getTailorModelList.length,
                              //   (index) {
                              //     return GestureDetector(
                              //       onTap: () {},
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Container(
                              //           height: size.height * 0.3,
                              //           width: size.width * 0.6,
                              //           // color: Colors.red,
                              //           child: Stack(
                              //             children: [
                              //               // Image.network(snapshot.data['imageURL']),
                              //               Container(
                              //                 height: 200,
                              //                 width: size.width,
                              //                 decoration: BoxDecoration(
                              //                     // image: Image.network(document['imageURL']),
                              //                     image: DecorationImage(
                              //                         image: AssetImage(
                              //                             'assets/images/men9.jpeg'),
                              //                         fit: BoxFit.cover),
                              //                     borderRadius:
                              //                         BorderRadius.circular(10)),
                              //               ),
                              //               Container(
                              //                 height: 200,
                              //                 width: double.infinity,
                              //                 decoration: BoxDecoration(
                              //                     // color: Colors.black87.withOpacity(0.3),
                              //                     borderRadius:
                              //                         BorderRadius.circular(10)),
                              //                 child: Column(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     // Padding(
                              //                     //     padding: const EdgeInsets.all(18.0),
                              //                     //     child: Align(
                              //                     //       alignment: Alignment.topRight,
                              //                     //       child: Text(
                              //                     //         '${shopsDistance[index]}Km',
                              //                     //         // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
                              //                     //         style: kBodyText.copyWith(
                              //                     //             fontSize: 14,
                              //                     //             color: Colors.white),
                              //                     //       ),
                              //                     //     )),
                              //                     // Padding(
                              //                     //   padding: const EdgeInsets.all(18.0),
                              //                     //   child: Row(
                              //                     //     children: [
                              //                     //       Icon(FontAwesomeIcons.store,
                              //                     //           size: 18,
                              //                     //           color: Colors.white),
                              //                     //       SizedBox(
                              //                     //         width: 10,
                              //                     //       ),
                              //                     //       Expanded(
                              //                     //         child: Text('Men\'s Kurta',
                              //                     //             style: kBodyText),
                              //                     //       ),
                              //                     //       SizedBox(
                              //                     //         width: size.width * 0.02,
                              //                     //       ),
                              //                     //     ],
                              //                     //   ),
                              //                     // )
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // )
                            ),
                          ),
                          Text(
                            'Our Services',
                            style: kBodyTextBlack,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data.get('shopDescription'),
                              style: kBodyTextGrey,
                              maxLines: 15,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            'Address',
                            style: kBodyTextBlack,
                          ),
                          Container(
                            width: size.width,
                            height: size.height * 0.1,
                            // color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                snapshot.data.get('address'),
                                style: kBodyTextGrey,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Text(
                            'Contact:',
                            style: kBodyTextBlack,
                          ),
                          Container(
                            width: size.width,
                            height: size.height * 0.1,
                            // color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                snapshot.data.get('mobileNo'),
                                style: kBodyTextGrey,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // StreamBuilder<QuerySnapshot>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('Vendors')
                  //         .doc(widget.vID)
                  //         .collection('products')
                  //         .where('productPublished', isEqualTo: true)
                  //         .snapshots(),
                  //     builder: (context, snapshot) {
                  //       if (!snapshot.hasData)
                  //         return Center(
                  //             child: CircularProgressIndicator(
                  //               color: kOrange,
                  //             ));
                  //       final List productID = snapshot.data.docs.map((e) {
                  //         return e.id;
                  //       }).toList();
                  //       final List productTitle = snapshot.data.docs.map((e) {
                  //         return e['productName'];
                  //       }).toList();
                  //       final List productDescription = snapshot.data.docs.map((e) {
                  //         return e['productDescription'];
                  //       }).toList();
                  //       final List productPrice = snapshot.data.docs.map((e) {
                  //         return e['productPrice'];
                  //       }).toList();
                  //       final List productURL = snapshot.data.docs.map((e) {
                  //         return e['productURL'];
                  //       }).toList();
                  //       return Expanded(
                  //         child: SingleChildScrollView(
                  //           child: Column(
                  //               children: List.generate(
                  //                 snapshot.data.docs.length,
                  //                     (index) {
                  //                   return GestureDetector(
                  //                     onTap: () {
                  //                       Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                               builder: (context) =>
                  //                                   ProductDetailsScreen(
                  //                                       productImage: productURL[index],
                  //                                       productName: productTitle[index],
                  //                                       productPrice: productPrice[index],
                  //                                       productDescription: productDescription[index],
                  //                                       pID: productID[index])));
                  //                     },
                  //                     child: snapshot.data.docs == null
                  //                         ? Text(
                  //                       'No Product Found!',
                  //                       style: TextStyle(
                  //                           color: Colors.black87,
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: 22),
                  //                     )
                  //                         : ShopProduct(
                  //                       title: productTitle[index],
                  //                       des: productDescription[index],
                  //                       price: 'Rs. ${productPrice[index]}',
                  //                       imagePath: productURL[index],
                  //                     ),
                  //                   );
                  //                 },
                  //               )),
                  //         ),
                  //       );
                  //     }),
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kOrange,
          child: Icon(Icons.add),
          onPressed: () {
            // Navigator.pushNamed(context, MeasurementScreen.id);
          },
          tooltip: 'Add Samples',
          // enableFeedback: true,
        ),
      ),
    );
  }
}
