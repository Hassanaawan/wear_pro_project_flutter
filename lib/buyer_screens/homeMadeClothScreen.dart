import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/product_provider.dart';
import 'package:wear_pro/providers/review_cart_provider.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:badges/badges.dart' as badge;
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomemadeClothScreen extends StatefulWidget {
  static const String id = 'HomemadeClothScreen';

  @override
  _HomemadeClothScreenState createState() => _HomemadeClothScreenState();
}

class _HomemadeClothScreenState extends State<HomemadeClothScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey.shade300;
    Size size = MediaQuery.of(context).size;
    // ReviewCartProvider reviewCartProvider = Provider.of(context);
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: kOrange,
        title: Text(
          'Homemade Clothes',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collectionGroup('products')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  color: kOrange,
                ),
              );
            final List productID = snapshot.data!.docs.map((e) {
              return e.id;
            }).toList();
            final List productTitle = snapshot.data!.docs.map((e) {
              return e['productName'];
            }).toList();
            final List productPrice = snapshot.data!.docs.map((e) {
              return e['productPrice'];
            }).toList();
            final List productURL = snapshot.data!.docs.map((e) {
              return e['productURL'];
            }).toList();
            final List productDescription = snapshot.data!.docs.map((e) {
              return e['productDescription'];
            }).toList();
            // print('->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${productProvider.productModel.productName}');
            return ListView(
              children: [
                GridView.count(
                  padding: EdgeInsets.only(top: 15.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 1,
                  children: List.generate(snapshot.data!.size, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    productImage: productURL[index],
                                    productName: productTitle[index],
                                    productPrice: productPrice[index],
                                    productDescription:
                                        productDescription[index],
                                    pID: productID[index])));
                      },
                      child: ListContainer(
                        imagePath: productURL[index],
                        title: productTitle[index],
                        price: productPrice[index],
                      ),
                    );
                  }),
                )
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          child: badge.Badge(
            badgeContent: Text('4',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            position: badge.BadgePosition.topStart(start: 25, top: -20),
            showBadge: true,
            // toAnimate: true,
            badgeAnimation: badge.BadgeAnimation.scale(),
            // borderSide: BorderSide(color: Colors.white),
            // padding: EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                )),
          ),
        ),
        backgroundColor: kOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    );
  }
}
