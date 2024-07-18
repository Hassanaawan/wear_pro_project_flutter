import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/tailor_provider.dart';
import 'measurement_screen.dart';

class TailorDetailScreen extends StatefulWidget {
  static const String id = 'TailorDetailScreen';
  final String vID;

  const TailorDetailScreen(this.vID);

  @override
  _TailorDetailScreenState createState() => _TailorDetailScreenState();
}

class _TailorDetailScreenState extends State<TailorDetailScreen> {
  TailorProvider tailorProvider;

  int label = 1;

  @override
  Widget build(BuildContext context) {
    tailorProvider = Provider.of(context);
    tailorProvider.fetchTailorSampleDataUser(tailorID: widget.vID);
    tailorProvider.fetchTailorSampleData();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Tailors')
                .doc(widget.vID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    color: kOrange,
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
                                      color: Colors.white,
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

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 25.0),
                                child: Container(
                                  height: 50.0,
                                  width: size.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: kOrange,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, MeasurementScreen.id);
                                    },
                                    child: Text(
                                      'Proceed To Measurements >',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
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
                              children: tailorProvider.getTailorSampleListUser
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

                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //       children: List.generate(
                          //     5,
                          //     (index) {
                          //       return GestureDetector(
                          //         onTap: () {},
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Container(
                          //             height: size.height * 0.3,
                          //             width: size.width * 0.6,
                          //             // color: Colors.red,
                          //             child: Stack(
                          //               children: [
                          //                 // Image.network(snapshot.data['imageURL']),
                          //                 Container(
                          //                   height: 200,
                          //                   width: size.width,
                          //                   decoration: BoxDecoration(
                          //                       // image: Image.network(document['imageURL']),
                          //                       image: DecorationImage(
                          //                           image: AssetImage(
                          //                               'assets/images/men9.jpeg'),
                          //                           fit: BoxFit.cover),
                          //                       borderRadius:
                          //                           BorderRadius.circular(10)),
                          //                 ),
                          //                 Container(
                          //                   height: 200,
                          //                   width: double.infinity,
                          //                   decoration: BoxDecoration(
                          //                       // color: Colors.black87.withOpacity(0.3),
                          //                       borderRadius:
                          //                           BorderRadius.circular(10)),
                          //                   child: Column(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       // Padding(
                          //                       //     padding: const EdgeInsets.all(18.0),
                          //                       //     child: Align(
                          //                       //       alignment: Alignment.topRight,
                          //                       //       child: Text(
                          //                       //         '${shopsDistance[index]}Km',
                          //                       //         // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
                          //                       //         style: kBodyText.copyWith(
                          //                       //             fontSize: 14,
                          //                       //             color: Colors.white),
                          //                       //       ),
                          //                       //     )),
                          //                       // Padding(
                          //                       //   padding: const EdgeInsets.all(18.0),
                          //                       //   child: Row(
                          //                       //     children: [
                          //                       //       Icon(FontAwesomeIcons.store,
                          //                       //           size: 18,
                          //                       //           color: Colors.white),
                          //                       //       SizedBox(
                          //                       //         width: 10,
                          //                       //       ),
                          //                       //       Expanded(
                          //                       //         child: Text('Men\'s Kurta',
                          //                       //             style: kBodyText),
                          //                       //       ),
                          //                       //       SizedBox(
                          //                       //         width: size.width * 0.02,
                          //                       //       ),
                          //                       //     ],
                          //                       //   ),
                          //                       // )
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   )),
                          // ),
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
                            'Shop Address',
                            style: kBodyTextBlack,
                          ),
                          Container(
                            width: size.width,
                            height: size.height * 0.1,
                            // color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.all(8.0),
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
            Navigator.pushNamed(context, MeasurementScreen.id);
          },
          tooltip: 'Give measurements',
          // enableFeedback: true,
        ),
      ),
    );
  }
}
