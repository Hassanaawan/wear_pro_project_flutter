import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/buyer_screens/product_details_screen.dart';
import 'package:wear_pro/buyer_screens/profile_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:badges/badges.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class ProductScreen extends StatefulWidget {
  final String pID;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDescription;
  static const String id = 'ProductScreen';

  const ProductScreen(
      {this.pID,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productDescription});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey.shade300;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kOrange,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: TextField(
            maxLines: 1,
            // keyboardAppearance: Brightness.dark,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_sharp),
          color: Colors.white,
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "All Products",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // ListView.builder(
          //     itemBuilder: (context, index){
          //   return Container();
          // }),
          StreamBuilder<QuerySnapshot>(
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
                final List productID = snapshot.data.docs.map((e) {
                  return e.id;
                }).toList();
                final List productTitle = snapshot.data.docs.map((e) {
                  return e['productName'];
                }).toList();
                final List productPrice = snapshot.data.docs.map((e) {
                  return e['productPrice'];
                }).toList();
                final List productURL = snapshot.data.docs.map((e) {
                  return e['productURL'];
                }).toList();

                // FirebaseFirestore.instance.collectionGroup('products').snapshots().map((event) => event.docs.map((e) => print(e.id)));
                return GridView.count(
                  padding: EdgeInsets.only(top: 15.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 5,
                  children: List.generate(snapshot.data.size, (index) {
                    return GestureDetector(
                      onTap: () {
                        //print(productID[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    pID: productID[index])));
                      },
                      child: Hero(
                        tag: widget.productName,
                        transitionOnUserGestures: true,
                        child: ListContainer(
                          imagePath: productURL[index],
                          title: productTitle[index],
                          price: productPrice[index],
                        ),
                      ),
                    );
                  }),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          child: Badge(
            badgeContent: Text('4',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            position: BadgePosition.topStart(start: 25, top: -20),
            showBadge: true,
            toAnimate: true,
            animationType: BadgeAnimationType.scale,
            borderSide: BorderSide(color: Colors.white),
            padding: EdgeInsets.all(8.0),
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
