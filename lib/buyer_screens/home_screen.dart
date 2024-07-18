import 'package:search_page/search_page.dart';
import 'package:wear_pro/buyer_screens/tailor_details_screen.dart';
import 'package:wear_pro/buyer_screens/wish_list_screen.dart';
import 'package:wear_pro/modules/product_model.dart';
import 'package:wear_pro/providers/tailor_provider.dart';
import 'package:wear_pro/widgets/skeleton.dart';
import '../providers/review_cart_provider.dart';
import 'buyer_screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/providers/product_provider.dart';
import 'package:wear_pro/widgets/widgets.dart';
import '../constants.dart';
import 'package:badges/badges.dart' as badge;
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/local_auth_api.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  late String productId;
  late String productName;
  late String productDescription;
  late String productPrice;
  late String productURL;
  late String productRating;
  late bool productPublished;
  late bool productVerified;
  late String vendorId;
  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TailorProvider tailorProvider;
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    ProductScreen(),
    WishListScreen(),
    ProfileScreen()
  ];
  final _auth = FirebaseAuth.instance;

  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];

  // User loggedInUser;

  // StoreServices _storeServices = StoreServices();
  List imageURL = []; //fetching store posters
  List storeName = []; //fetching store name
  List storeStatus = [];
  List storeLatitude = []; //fetching store lat
  List storeLongitude = []; //fetching store long
  late double userLatitude;
  late double userLongitude;
  bool permit = false;

  // final locationData = Provider.of<LocationProvider>(context, listen: false);

  Future<void> getCurrentUserLocation() async {
    try {
      // print('111111111111111111');
      final user = _auth.currentUser;
      // print('222222222222222222222');
      if (user != null) {
        // print('3333333333333333333333');
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if (position != null) {
          setState(() {
            // print('555555555555555555555555555');
            this.userLatitude = position.latitude;
            this.userLongitude = position.longitude;
            this.permit = true;
            // print('666666666666666666666666');
            FirebaseFirestore.instance
                .collection('Buyers')
                .doc(user.uid)
                .update({
              'userLatitude': userLatitude,
              'userLongitude': userLongitude,
            }).then((value) => print('Location Updated!'));
          });
          // print('777777777777777777777777');
          //update location in fire store...
        } else {
          print('Permission not granted');
          LocationPermission permission = await Geolocator.requestPermission();
          // print('8888888888888888888888');
        }
      } else {
        // print('9999999999999999999999');
        // Navigator.pushNamed(context, LoginScreen.id);
        //navigate to login screen or welcome screen
      }
    } catch (e) {
      print(e);
    }
    // print('10 10 10 10 10 10 10 10');
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation();
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchProductData();
    // TailorProvider tailorProvider = Provider.of(context, listen: false);
    // tailorProvider.fetchTailorData();
    // productProvider.fetchRecentlyViewedProducts();
  }

  //
  String getDistance(shopLatitude, shopLongitude) {
    var distance = Geolocator.distanceBetween(
        userLatitude, userLongitude, shopLatitude, shopLongitude);
    var distanceInKm = distance / 1000;
    return distanceInKm.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    tailorProvider = Provider.of(context);
    tailorProvider.fetchTailorData();
    ProductProvider productProvider = Provider.of(context);
    productProvider.fetchRecentlyViewedProducts();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Size size = MediaQuery.of(context).size;
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    // TailorProvider tailorProvider = Provider.of(context);
    productProvider.getProductModelList.map((e) {
      this.widget.productId = e.productId;
      this.widget.productName = e.productName;
      this.widget.productPrice = e.productPrice;
      this.widget.productDescription = e.productDescription;
      this.widget.productURL = e.productURL;
      this.widget.productVerified = e.productVerified;
      this.widget.productPublished = e.productPublished;
      this.widget.productRating = e.productRating;
      this.widget.vendorId = e.vendorId;
      // print('thisssssssssssssssssssssssss${e.productId},${e.productName},${e.productPrice},${e.productDescription},${e.productVerified}, ${e.productPublished}');
    }).toList();

    // final locationData = Provider.of<LocationProvider>(context, listen: false);

    final ref = FirebaseStorage.instance.ref().child('testimage');
// no need of the file extension, the name will do fine.
    var url = ref.getDownloadURL();

    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection('Vendors').snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //   snapshot.data.docs.forEach((element) {
    //     // print(element.get('imageURL'));
    //     imageURL.add(element.get('imageURL'));
    //     storeName.add(element.get('shopName'));
    //     // storeLatitude.add(element.get('shopLatitude'));
    //   });
    //
    //   if (snapshot.hasError) {
    //     return Text('${snapshot.error}');
    //   }
    //   if (!snapshot.hasData) return CircularProgressIndicator();
    //   List shopsDistance = [];
    //   snapshot.data.docs.forEach((ele) {
    //     // print('thisss${snapshot.data.docs[i].get('shopLatitude')}');
    //     // print(snapshot.data.docs[i].get('shopLongitude'));
    //     var distance = Geolocator.distanceBetween(userLatitude, userLongitude,
    //         ele.get('shopLatitude'), ele.get('shopLongitude'));
    //     var distanceInKm = distance / 1000;
    //     shopsDistance.add(distanceInKm.toStringAsFixed(2));
    //     // print(snapshot.data.docs[i].get('shopLatitude'));
    //   });
    // shopsDistance.sort();
    return Scaffold(
      extendBody: true,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: kOrange),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: TextField(
            onTap: () {
              //Show search bar
              // return showSearch(
              //   context: context,
              //   delegate: SearchPage<ProductModel>(
              //     // barTheme: ThemeData(backgroundColor: kOrange,focusColor: kOrange),
              //     items: productProvider.getProductModelList,
              //     searchLabel: 'search products',
              //     suggestion: SingleChildScrollView(
              //       scrollDirection: Axis.vertical,
              //       child: Column(
              //         children: productProvider.getProductModelList.map(
              //           (productData) {
              //             return GestureDetector(
              //               onTap: () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             ProductDetailsScreen(
              //                               pID: productData.productId,
              //                               productName:
              //                                   productData.productName,
              //                               productPrice:
              //                                   productData.productPrice,
              //                               productImage:
              //                                   productData.productURL,
              //                               productDescription:
              //                                   productData.productDescription,
              //                               vendorId: productData.vendorId,
              //                             )));
              //               },
              //               child: Padding(
              //                 padding: const EdgeInsets.only(left: 8.0),
              //                 child: Column(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(18.0),
              //                       child: Container(
              //                         width: size.width,
              //                         height: 170.0,
              //                         child: Stack(
              //                           children: [
              //                             Container(
              //                               decoration: BoxDecoration(
              //                                   image: DecorationImage(
              //                                       image: NetworkImage(
              //                                           productData.productURL),
              //                                       fit: BoxFit.cover),
              //                                   borderRadius:
              //                                       BorderRadius.circular(5)),
              //                             ),
              //                             // Positioned(
              //                             //   bottom: 1,
              //                             //   child: Container(
              //                             //     child: Padding(
              //                             //       padding: const EdgeInsets.only(left: 8.0),
              //                             //       child: Text(
              //                             //         title,
              //                             //         style: kBodyText.copyWith(fontWeight: FontWeight.bold,fontSize: 18.0),
              //                             //       ),
              //                             //     ),
              //                             //     height: 35.0,
              //                             //     width: 180,
              //                             //     decoration: BoxDecoration(
              //                             //         color: Colors.black45.withOpacity(0.3),
              //                             //         borderRadius: BorderRadius.circular(5)),
              //                             //   ),
              //                             // ),
              //                             // Container(
              //                             //   width: 140,
              //                             //   child: Column(
              //                             //     crossAxisAlignment: CrossAxisAlignment.start,
              //                             //     children: [
              //                             //       Text('Black Shirt',
              //                             //         style: kBodyTextBlack,
              //                             //       ),
              //                             //       SizedBox(
              //                             //         height: 5,
              //                             //       ),
              //                             //       Text(
              //                             //         'Rs 1600',
              //                             //         style: kBodyTextGrey,
              //                             //       ),
              //                             //     ],
              //                             //   ),
              //                             // ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 5.0,
              //                     ),
              //                     Container(
              //                       width: 240,
              //                       child: Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             productData.productName,
              //                             style: kBodyTextBlack.copyWith(
              //                                 fontSize: 20),
              //                             // overflow: TextOverflow.ellipsis,
              //                           ),
              //                           SizedBox(
              //                             height: 5,
              //                           ),
              //                           Text(
              //                             'Rs: ${productData.productPrice}',
              //                             style: kBodyTextGrey.copyWith(
              //                                 fontSize: 18),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         ).toList(),
              //       ),
              //     ),
              //     failure: Center(
              //       child: Text('No product found:( '),
              //     ),
              //     filter: (product) => [
              //       product.productName,
              //       // person.surname,
              //       product.productPrice,
              //       product.productURL,
              //     ],
              //     builder: (productData) => GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => ProductDetailsScreen(
              //                       pID: productData.productId,
              //                       productName: productData.productName,
              //                       productPrice: productData.productPrice,
              //                       productImage: productData.productURL,
              //                       productDescription:
              //                           productData.productDescription,
              //                   vendorId: productData.vendorId,
              //                     )));
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(18.0),
              //               child: Container(
              //                 width: size.width,
              //                 height: 170.0,
              //                 child: Stack(
              //                   children: [
              //                     Container(
              //                       decoration: BoxDecoration(
              //                           image: DecorationImage(
              //                               image: NetworkImage(
              //                                   productData.productURL),
              //                               fit: BoxFit.cover),
              //                           borderRadius: BorderRadius.circular(5)),
              //                     ),
              //                     // Positioned(
              //                     //   bottom: 1,
              //                     //   child: Container(
              //                     //     child: Padding(
              //                     //       padding: const EdgeInsets.only(left: 8.0),
              //                     //       child: Text(
              //                     //         title,
              //                     //         style: kBodyText.copyWith(fontWeight: FontWeight.bold,fontSize: 18.0),
              //                     //       ),
              //                     //     ),
              //                     //     height: 35.0,
              //                     //     width: 180,
              //                     //     decoration: BoxDecoration(
              //                     //         color: Colors.black45.withOpacity(0.3),
              //                     //         borderRadius: BorderRadius.circular(5)),
              //                     //   ),
              //                     // ),
              //                     // Container(
              //                     //   width: 140,
              //                     //   child: Column(
              //                     //     crossAxisAlignment: CrossAxisAlignment.start,
              //                     //     children: [
              //                     //       Text('Black Shirt',
              //                     //         style: kBodyTextBlack,
              //                     //       ),
              //                     //       SizedBox(
              //                     //         height: 5,
              //                     //       ),
              //                     //       Text(
              //                     //         'Rs 1600',
              //                     //         style: kBodyTextGrey,
              //                     //       ),
              //                     //     ],
              //                     //   ),
              //                     // ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5.0,
              //             ),
              //             Container(
              //               width: 240,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     productData.productName,
              //                     style: kBodyTextBlack.copyWith(fontSize: 20),
              //                     // overflow: TextOverflow.ellipsis,
              //                   ),
              //                   SizedBox(
              //                     height: 5,
              //                   ),
              //                   Text(
              //                     'Rs: ${productData.productPrice}',
              //                     style: kBodyTextGrey.copyWith(fontSize: 18),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       // ListContainer(
              //       //   imagePath: productData.productURL,
              //       //   title: productData.productName,
              //       //   price: productData.productPrice,
              //       // ),
              //     ),
              //   ),
              // );
            },
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: kOrange,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    FontAwesomeIcons.user,
                    color: kOrange,
                    size: 20.0,
                  ),
                  // backgroundImage: AssetImage('assets/images/image_2.jpeg',),
                  foregroundImage: AssetImage('assets/images/image_8.jpeg'),
                  radius: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
      drawer: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Buyers')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something Wrong Happens');
            }
            if (snapshot.hasData) {
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
                                snapshot.data!.get('fName'),
                                style: kBodyText.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.data!.get(
                                  'email',
                                ),
                                style: kBodyText.copyWith(fontSize: 18.0),
                              ),
                              Text(
                                FirebaseAuth.instance.currentUser!.uid,
                                style: kBodyText.copyWith(fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        // buildAuthenticate(context),
                        BuildMenuItem(
                          icon: Icons.account_circle_outlined,
                          text: 'Profile',
                          onPressed: () async {
                            // final isAuthenticated = await LocalAuthApi.authenticate();
                            //
                            // if (isAuthenticated) {
                            //   Navigator.pushNamed(context, ProfileScreen.id);
                            // }
                            // else{
                            //   print('could not authenticated!');
                            // }
                            Navigator.pushNamed(context, ProfileScreen.id);
                          },
                        ),
                        BuildMenuItem(
                          icon: Icons.shopping_cart_outlined,
                          text: 'My Cart',
                          onPressed: () =>
                              Navigator.pushNamed(context, CartScreen.id),
                        ),
                        BuildMenuItem(
                          onPressed: () {
                            Navigator.pushNamed(context, WishListScreen.id);
                          },
                          icon: FontAwesomeIcons.heart,
                          text: 'Wish List',
                        ),
                        BuildMenuItem(
                          icon: Icons.error_outline,
                          text: 'About',
                        ),
                        SizedBox(height: 35),
                        Divider(color: Colors.white, thickness: 1.4),
                        SizedBox(
                          height: 35.0,
                        ),
                        BuildMenuItem(
                          icon: Icons.help_outline,
                          text: 'Help',
                        ),
                        BuildMenuItem(
                          icon: Icons.logout,
                          text: 'Log Out',
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.remove('email');
                            _auth.signOut();
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              color: kOrange,
            ));
          }),
      // backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.015,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: size.height * 0.3,
              autoPlay: true,
            ),
            items: [
              SliderImage(
                imagePath: 'assets/images/adds_2.png',
              ),
              SliderImage(
                imagePath: 'assets/images/adds_1.png',
              ),
              SliderImage(
                imagePath: 'assets/images/adds_2.png',
              ),
              SliderImage(
                imagePath: 'assets/images/add_4.jpg',
              ),
              SliderImage(
                imagePath: 'assets/images/adds_2.png',
              ),
              SliderImage(
                imagePath: 'assets/images/adds_1.png',
              ),
              SliderImage(
                imagePath: 'assets/images/add_4.jpg',
              ),
              SliderImage(
                imagePath: 'assets/images/adds_2.png',
              ),
            ],
          ),
          SizedBox(height: 25.0),
          SizedBox(
            height: size.height * 0.02,
            // child: Column(
            //   children: [
            //     Text('${locationData.longitude}'),
            //     Text('${locationData.latitude}'),
            //   ],
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style:
                      kBodyTextBlack.copyWith(fontSize: 20.0, color: kOrange),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductScreen.id);
                  },
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MenClothScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Container(
                          width: 160.0,
                          height: 180.0,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/men2.jpg'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Positioned(
                                bottom: 1,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Men',
                                      style: kBodyText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  height: 35.0,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.black45.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, WomenClothScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: 160.0,
                      height: 180.0,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/women17.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Positioned(
                            bottom: 1,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Women',
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                              height: 35.0,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.black45.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, KidsClothScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 160.0,
                      height: 180.0,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/kid1.jpeg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Positioned(
                            bottom: 1,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Kids',
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                              height: 35.0,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.black45.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, HomemadeClothScreen.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: 160.0,
                      height: 180.0,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/GharKkapry1.jpeg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          Positioned(
                            bottom: 1,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Home Made Cloth',
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                              height: 35.0,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.black45.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),

          // StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collectionGroup('products')
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData)
          //         return Center(
          //           child: CircularProgressIndicator(
          //             color: kOrange,
          //           ),
          //         );
          //       final List productID = snapshot.data.docs.map((e) {
          //         return e.id;
          //       }).toList();
          //       final List productTitle = snapshot.data.docs.map((e) {
          //         return e['productName'];
          //       }).toList();
          //       final List productDes = snapshot.data.docs.map((e) {
          //         return e['productDescription'];
          //       }).toList();
          //       final List productPrice = snapshot.data.docs.map((e) {
          //         return e['productPrice'];
          //       }).toList();
          //       final List productURL = snapshot.data.docs.map((e) {
          //         return e['productURL'];
          //       }).toList();
          //       return SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: List.generate(snapshot.data.size, (index) {
          //             return GestureDetector(
          //               onTap: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => ProductDetailsScreen(
          //                               pID: productID[index],
          //                             )));
          //               },
          //               child: ListContainer(
          //                 imagePath: productURL[index],
          //                 title: productTitle[index],
          //                 price: productPrice[index],
          //               ),
          //             );
          //           }),
          //         ),
          //       );
          //     }),
          // SizedBox(
          //   height: 35,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Arrival",
                  style:
                      kBodyTextBlack.copyWith(fontSize: 20.0, color: kOrange),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                  pID: widget.productId,
                                  productName: widget.productName,
                                  productPrice: widget.productPrice,
                                  productImage: widget.productURL,
                                  productDescription: widget.productDescription,
                                )));
                  },
                  child: Row(
                    children: [
                      Text("View All",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productProvider.getProductModelList.map(
                (productData) {
                  return GestureDetector(
                    onTap: () {
                      productProvider.saveProductPatternToFB(
                          pName: productData.productName,
                          pDescription: productData.productDescription,
                          pPrice: productData.productPrice,
                          productURL: productData.productURL,
                          pId: productData.productId,
                          pCategory: productData.productCategory);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    pID: productData.productId,
                                    productName: productData.productName,
                                    productPrice: productData.productPrice,
                                    productImage: productData.productURL,
                                    productDescription:
                                        productData.productDescription,
                                    vendorId: productData.vendorId,
                                  )));
                    },
                    child: ListContainer(
                      imagePath: productData.productURL,
                      title: productData.productName,
                      price: productData.productPrice,
                    ),
                  );
                },
              ).toList(),
            ),
          ),

          SizedBox(
            height: 30,
          ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: productProvider.getProductModelList.map(
          //           (productData) {
          //         return GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) =>
          //                         ProductDetailsScreen(
          //                           pID: productData.productId,
          //                           productName: productData.productName,
          //                           productPrice: productData.productPrice,
          //                           productImage: productData.productURL,
          //                           productDescription: productData
          //                               .productDescription,
          //                         )));
          //           },
          //           child: ListContainer(
          //             imagePath: productData.productURL,
          //             title: productData.productName,
          //             price: productData.productPrice,
          //           ),
          //         );
          //       },
          //     ).toList(),
          //     // children: List.generate(4, (index) {
          //     //   return GestureDetector(
          //     //     onTap: (){
          //     //       Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productID[index])));
          //     //     },
          //     //     child: ListContainer(
          //     //       imagePath: productURL[index],
          //     //       title: productTitle[index],
          //     //       price: productPrice[index],
          //     //     ),
          //     //   );
          //     // }),
          //     // child: ListContainer(
          //     //   imagePath:imageURL,
          //     //   title: 'Women',
          //     // ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recently View",
                  style:
                      kBodyTextBlack.copyWith(fontSize: 20.0, color: kOrange),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          pID: widget.productId,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                          productImage: widget.productURL,
                          productDescription: widget.productDescription,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text("View All",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productProvider.getRecentlyViewDataList.map(
                (recentProducts) {
                  return GestureDetector(
                    onTap: () {
                      productProvider.saveProductPatternToFB(
                        pName: recentProducts.productName,
                        pDescription: recentProducts.productDescription,
                        pPrice: recentProducts.productPrice,
                        productURL: recentProducts.productURL,
                        pId: recentProducts.productId,
                        pCategory: recentProducts.productCategory,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    pID: recentProducts.productId,
                                    productName: recentProducts.productName,
                                    productPrice: recentProducts.productPrice,
                                    productImage: recentProducts.productURL,
                                    productDescription:
                                        recentProducts.productDescription,
                                  )));
                    },
                    child: ListContainer(
                      imagePath: recentProducts.productURL,
                      title: recentProducts.productName,
                      price: recentProducts.productPrice,
                    ),
                  );
                },
              ).toList(),
            ),
          ),

          //  StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance
          //       .collection('Pattern')
          //       .doc(FirebaseAuth.instance.currentUser.uid)
          //       .collection('YourPattern')
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData)
          //       return Center(
          //         child: CircularProgressIndicator(
          //           color: kOrange,
          //         ),
          //       );
          //     final List productID = snapshot.data.docs.map((e) {
          //       return e.id;
          //     }).toList();
          //     final List productTitle = snapshot.data.docs.map((e) {
          //       return e['productName'];
          //     }).toList();
          //     final List productPrice = snapshot.data.docs.map((e) {
          //       return e['productPrice'];
          //     }).toList();
          //     final List productURL = snapshot.data.docs.map((e) {
          //       return e['productURL'];
          //     }).toList();
          //     final List productDescription = snapshot.data.docs.map((e) {
          //       return e['productDescription'];
          //     }).toList();
          //     return SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: List.generate(
          //           snapshot.data.docs.length,
          //           (index) {
          //             return GestureDetector(
          //               onTap: () {
          //                 // Navigator.push(ic
          //               },
          //               child: ListContainer(
          //                 imagePath: productURL[index],
          //                 title: productTitle[index],
          //                 price: productPrice[index],
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //
          //       // productProvider.getRecentlyViewDataList.map(
          //       // (productDataa) {
          //       // return GestureDetector(
          //       // onTap: () {
          //       //
          //       // Navigator.push(
          //       // context,
          //       // MaterialPageRoute(
          //       // builder: (context) => ProductDetailsScreen(
          //       // pID: productDataa.productId,
          //       // productName: productDataa.productName,
          //       // productPrice: productDataa.productPrice,
          //       // productImage: productDataa.productURL,
          //       // productDescription:
          //       // productDataa.productDescription,
          //       // )));
          //       // },
          //       // child: ListContainer(
          //       // imagePath: productDataa.productURL,
          //       // title: productDataa.productName,
          //       // price: productDataa.productPrice,
          //       // ),
          //       // );
          //       // },
          //       // ).toList(),
          //       // children: List.generate(4, (index) {
          //       //   return GestureDetector(
          //       //     onTap: (){
          //       //       Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productID[index])));
          //       //     },
          //       //     child: ListContainer(
          //       //       imagePath: productURL[index],
          //       //       title: productTitle[index],
          //       //       price: productPrice[index],
          //       //     ),
          //       //   );
          //       // }),
          //       // child: ListContainer(
          //       //   imagePath:imageURL,
          //       //   title: 'Women',
          //       // ),
          //     );
          //   },
          // ),
          Divider(
            color: Colors.grey.withOpacity(0.8),
            indent: 10,
            endIndent: 10,
            height: 1,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "All Tailors",
              style: kBodyTextBlack,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Tailors')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        color: kOrange,
                      ),
                    );
                  final List shopID = snapshot.data!.docs.map((e) {
                    return e.id;
                  }).toList();
                  final List tailorName = snapshot.data!.docs.map((e) {
                    return e['shopName'];
                  }).toList();
                  final List tailorAddress = snapshot.data!.docs.map((e) {
                    return e['address'];
                  }).toList();
                  final List tailorURL = snapshot.data!.docs.map((e) {
                    return e['imageURL'];
                  }).toList();
                  final List tailorCity = snapshot.data!.docs.map((e) {
                    return e['city'];
                  }).toList();
                  final List tailorMobileNo = snapshot.data!.docs.map((e) {
                    return e['mobileNo'];
                  }).toList();
                  final List tailorRating = snapshot.data!.docs.map((e) {
                    return e['rating'];
                  }).toList();
                  final List tailorOpen = snapshot.data!.docs.map((e) {
                    return e['shopOpen'];
                  }).toList();
                  return Row(
                    children: List.generate(snapshot.data!.size, (index) {
                      return GestureDetector(
                        onTap: () {
                          // print(
                          //     'tailor dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$tailorData');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TailorDetailScreen(shopID[index])));
                        },
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
                                  height: 200,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      // image: Image.network(document['imageURL']),
                                      image: DecorationImage(
                                          image: NetworkImage(tailorURL[index]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.black87.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              tailorCity[index],
                                              // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
                                              style: kBodyText.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          children: [
                                            Icon(FontAwesomeIcons.store,
                                                size: 18, color: Colors.white),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(tailorName[index],
                                                  style: kBodyText.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
          ),

          // Row(
          //   children: tailorProvider.getTailorModelList.map(
          //           (tailorData) {
          // return GestureDetector(
          //   onTap: () {
          //     print(
          //         'tailor dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$tailorData');
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 TailorDetailScreen(tailorData.tailorID)));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       height: size.height * 0.3,
          //       width: size.width * 0.6,
          //       // color: Colors.red,
          //       child: Stack(
          //         children: [
          //           // Image.network(snapshot.data['imageURL']),
          //           Container(
          //             height: 200,
          //             width: size.width,
          //             decoration: BoxDecoration(
          //               // image: Image.network(document['imageURL']),
          //                 image: DecorationImage(
          //                     image: NetworkImage(tailorData.tailorImage),
          //                     fit: BoxFit.cover),
          //                 borderRadius: BorderRadius.circular(10)),
          //           ),
          //           Container(
          //             height: 200,
          //             width: double.infinity,
          //             decoration: BoxDecoration(
          //                 color: Colors.black87.withOpacity(0.3),
          //                 borderRadius: BorderRadius.circular(10)),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Padding(
          //                     padding: const EdgeInsets.all(18.0),
          //                     child: Align(
          //                       alignment: Alignment.topRight,
          //                       child: Text(
          //                         '5Km',
          //                         // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
          //                         style: kBodyText.copyWith(
          //                             fontSize: 14, color: Colors.white),
          //                       ),
          //                     )),
          //                 Padding(
          //                   padding: const EdgeInsets.all(18.0),
          //                   child: Row(
          //                     children: [
          //                       Icon(FontAwesomeIcons.store,
          //                           size: 18, color: Colors.white),
          //                       SizedBox(
          //                         width: 10,
          //                       ),
          //                       Expanded(
          //                         child: Text(tailorData.tailorName,
          //                             style: kBodyText),
          //                       ),
          //                       SizedBox(
          //                         width: size.width * 0.02,
          //                       ),
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
          // }).toList(),
          // )

          // children: List.generate(
          //   3,
          //   (index) {
          //     return GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) =>
          //                     TailorDetailScreen(vendorID[index])));
          //       },
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
          //                         image: NetworkImage(imageURL[index]),
          //                         fit: BoxFit.cover),
          //                     borderRadius: BorderRadius.circular(10)),
          //               ),
          //               Container(
          //                 height: 200,
          //                 width: double.infinity,
          //                 decoration: BoxDecoration(
          //                     color: Colors.black87.withOpacity(0.3),
          //                     borderRadius: BorderRadius.circular(10)),
          //                 child: Column(
          //                   mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Padding(
          //                         padding: const EdgeInsets.all(18.0),
          //                         child: Align(
          //                           alignment: Alignment.topRight,
          //                           child: Text(
          //                             '5Km',
          //                             // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
          //                             style: kBodyText.copyWith(
          //                                 fontSize: 14,
          //                                 color: Colors.white),
          //                           ),
          //                         )),
          //                     Padding(
          //                       padding: const EdgeInsets.all(18.0),
          //                       child: Row(
          //                         children: [
          //                           Icon(FontAwesomeIcons.store,
          //                               size: 18, color: Colors.white),
          //                           SizedBox(
          //                             width: 10,
          //                           ),
          //                           Expanded(
          //                             child: Text(storeName[index],
          //                                 style: kBodyText),
          //                           ),
          //                           SizedBox(
          //                             width: size.width * 0.02,
          //                           ),
          //                         ],
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),

          // child: StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collection('Vendors')
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       snapshot.data.docs.forEach((element) {
          //         // print(element.get('imageURL'));
          //         imageURL.add(element.get('imageURL'));
          //         storeName.add(element.get('shopName'));
          //         // storeLatitude.add(element.get('shopLatitude'));
          //       });
          //       final List vendorID = snapshot.data.docs.map((e) {
          //         return e.id;
          //       }).toList();
          //       if (snapshot.hasError) {
          //         return Text('${snapshot.error}');
          //       }
          //       if (!snapshot.hasData) return CircularProgressIndicator();
          //       List shopsDistance = [];
          //       snapshot.data.docs.forEach((ele) {
          //         // print('thisss${snapshot.data.docs[i].get('shopLatitude')}');
          //         // print(snapshot.data.docs[i].get('shopLongitude'));
          //         var distance = Geolocator.distanceBetween(
          //             userLatitude,
          //             userLongitude,
          //             ele.get('shopLatitude'),
          //             ele.get('shopLongitude'));
          //         var distanceInKm = distance / 1000;
          //         shopsDistance.add(distanceInKm.toStringAsFixed(2));
          //         // print(snapshot.data.docs[i].get('shopLatitude'));
          //       });
          // shopsDistance.sort();
          // return

          // }),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "All Stores",
              style: kBodyTextBlack,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Vendors')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something Wrong Happens');
                  }
                  if (snapshot.hasData) {
                    snapshot.data!.docs.forEach((element) {
                      // print(element.get('imageURL'));
                      imageURL.add(element.get('imageURL'));
                      storeName.add(element.get('shopName'));
                      storeStatus.add(element.get('shopOpen'));
                      // print('-------------->>>>>>>>>>>>>>$storeStatus');
                      // storeLatitude.add(element.get('shopLatitude'));
                    });
                    final List vendorID = snapshot.data!.docs.map((e) {
                      return e.id;
                    }).toList();
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    List shopsDistance = [];
                    snapshot.data!.docs.forEach((ele) {
                      // print('thisss${snapshot.data.docs[i].get('shopLatitude')}');
                      // print(snapshot.data.docs[i].get('shopLongitude'));
                      double distance = Geolocator.distanceBetween(
                          userLatitude,
                          userLongitude,
                          ele.get('shopLatitude'),
                          ele.get('shopLongitude'));
                      double distanceInKm = distance / 1000;
                      shopsDistance.add(distanceInKm.toStringAsFixed(2));
                      // print(snapshot.data.docs[i].get('shopLatitude'));
                    });
                    // shopsDistance.sort();
                    return Column(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StoresScreen(vendorID[index])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.height * 0.3,
                                width: double.infinity,
                                // color: Colors.red,
                                child: Stack(
                                  children: [
                                    // Image.network(snapshot.data['imageURL']),
                                    Container(
                                      height: 200,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          // image: Image.network(document['imageURL']),
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(imageURL[index]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.black87.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: 65,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: storeStatus[index] ==
                                                        false
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            "CLOSE",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Container(
                                                            width: 8,
                                                            height: 8,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .redAccent,
                                                                shape: BoxShape
                                                                    .circle),
                                                          )
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            "OPEN",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Container(
                                                            width: 8,
                                                            height: 8,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    shape: BoxShape
                                                                        .circle),
                                                          )
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.start,
                                          //     children: [
                                          //       Text(
                                          //         "Attock City",
                                          //         style: kBodyText,
                                          //       ),
                                          //       SizedBox(
                                          //         width: 10,
                                          //       ),
                                          //       Icon(
                                          //         FontAwesomeIcons.mapMarkerAlt,
                                          //         size: 20,
                                          //         color: kOrange,
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(
                                              children: [
                                                Icon(FontAwesomeIcons.store,
                                                    size: 18,
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    storeName[index],
                                                    style:
                                                        kHeadTextBlack.copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.02,
                                                ),
                                                Text(
                                                  '${shopsDistance[index]}Km',
                                                  // '${getDistance(snapshot.data.docs[index].get('shopLatitude'), snapshot.data.docs[index].get('shopLongitude'))}Km',
                                                  style: kBodyText.copyWith(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: kOrange,
                  ));
                }),
          ),
          SizedBox(
            height: 20,
          ),
          // List.generate(itemBuilder: itemBuilder)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _animationController.reset();
          // _animationController.forward();
          Navigator.pushNamed(context, CartScreen.id);
        },
        child: Container(
          child: badge.Badge(
            badgeContent: Text(
                reviewCartProvider.reviewCartDataList.length.toString(),
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            position: badge.BadgePosition.topStart(start: 25, top: -20),
            showBadge: true,
            // toAnimate: true,
            badgeAnimation: badge.BadgeAnimation.scale(),
            // borderSide: BorderSide(color: Colors.white),
            // padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, HomeScreen.id);
          } else if (index == 1) {
            // Navigator.pushNamed(context, ProductScreen.id);
          } else if (index == 2) {
            Navigator.pushNamed(context, WishListScreen.id);
          } else if (index == 3) {
            Navigator.pushNamed(context, ProfileScreen.id);
          }
          setState(() {
            screens[index];
            currentIndex = index;
          });
        },
        // {
        //   setState(
        //     () => currentIndex = index,
        //   ),
        // },
        activeColor: Colors.black87,
        inactiveColor: Colors.white,
        icons: [
          Icons.home,
          Icons.production_quantity_limits,
          Icons.favorite,
          Icons.account_circle_outlined,
        ],
        iconSize: 28.0,
        // activeIndex: currentIndex,
        backgroundColor: kOrange,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,

        //new
        // backgroundColor: HexColor('#373A36'),
        activeIndex: _bottomNavIndex,
        splashColor: Colors.black,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        // notchSmoothness: NotchSmoothness.defaultEdge,
        // gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        // onTap: (index) => setState(() => _bottomNavIndex = index),
        //new
      ),
    );
  }
}

Widget buildAuthenticate(BuildContext context) => buildButton(
      text: 'Authenticate',
      icon: Icons.lock_open,
      onClicked: () async {
        final isAuthenticated = await LocalAuthApi.authenticate();

        if (isAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
    );

Widget buildButton({
  required String text,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
      ),
      icon: Icon(icon, size: 26),
      label: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: onClicked,
    );
