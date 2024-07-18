import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/review_cart_provider.dart';
import 'package:wear_pro/providers/wishlist_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  String pID;
  String productName;
  String productImage;
  String productPrice;
  String productDescription;
  String vendorId;

  ProductDetailsScreen({
    this.pID,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productDescription,
    this.vendorId,
  });

  static const String id = 'ProductDetailsScreen';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedImage = 0;
  bool isFavourite = false;
  bool isTrue = false;
  getWishtListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourWishList")
        .doc(widget.pID)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          isFavourite = value.get("wishList");
                        },
                      ),
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    WishListProvider wishListProvider = Provider.of(context);
    getWishtListBool();

    // print('/////////////////////${widget.pID}');
    return SafeArea(
        child:
            // print('product price ${snapshot.data.get('productPrice')}');
            // final List productTitle = snapshot.data.docs.map((e) {
            //   return e['productName'];
            // }).toList();
            // final List productPrice = snapshot.data.docs.map((e) {
            //   return e['productPrice'];
            // }).toList();
            // final List productURL = snapshot.data.docs.map((e) {
            //   return e['productURL'];
            // }).toList();
            //
            // final List productID = snapshot.data.docs.map((e) {
            //   return e.id;
            // }).toList();
            Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      // appBar: CustomAppBar(rating: 4.8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Stack(children: [
                Container(
                  // margin: EdgeInsets.only(top: 20),
                  // padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SizedBox(
                    width: size.width,
                    child: AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        widget.productImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Container(
                          height: 35,
                          width: 35,
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: kOrange,
                              size: 22.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Container(
                          height: 35,
                          width: 35,
                          child: Center(
                            child: Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: kOrange,
                              size: 22.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            // SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      3,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.all(8),
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: kOrange.withOpacity(
                                        selectedImage == index ? 1 : 0)),
                              ),
                              child: Image.network(widget.productImage),
                            ),
                          )),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.productName,
                        style: kHeadTextBlack.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavourite = !isFavourite;
                        });
                        if (isFavourite == true) {
                          wishListProvider.addWishListData(
                            wishListId: widget.pID,
                            wishListImage: widget.productImage,
                            wishListName: widget.productName,
                            wishListPrice: widget.productPrice,
                            wishListDescription: widget.productDescription,
                          );
                        } else {
                          wishListProvider.deleteWishList(widget.pID);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: 60,
                        decoration: BoxDecoration(
                          color: isFavourite
                              ? Color(0xFFFFE6E6)
                              : Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.favorite,
                            color: isFavourite
                                ? Color(0xFFFF4848)
                                : Colors.grey.shade400,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
                  child: Text(
                    'Rs:${widget.productPrice}',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: kOrange,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
                  child: Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 64,
                  ),
                  child: Text(
                    '${widget.productDescription}',
                    // maxLines: 3,
                    style: kBodyTextGrey,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.15,
            right: size.width * 0.15,
            bottom: 10,
            top: 10,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: kOrange,
              onPressed: () {
                setState(() {
                  isTrue = true;
                });
                reviewCartProvider.saveReviewCartDataToFB(
                    cartId: widget.pID,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    cartQuantity: '1',
                    vendorId: widget.vendorId);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Add To Cart',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  isTrue
                      ? AnimatedContainer(
                          duration: Duration(seconds: 2),
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                          ))
                      : Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        )
                ],
              ),
            ),
          ),
          // DefaultButton(
          //   text: "Add To Cart",
          //   press: () {},
          // ),
        ),
        color: Color(0xFFF5F6F9),
        elevation: 2,
      ),
    ));
  }
}
