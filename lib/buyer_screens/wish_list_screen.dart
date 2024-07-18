import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/product_details_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/wishlist_provider.dart';

import '../modules/product_model.dart';

class WishListScreen extends StatefulWidget {
  static const String id = 'WishListScreen';
  final String pID;

  const WishListScreen({this.pID});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  WishListProvider wishListProvider;

  // showAlertDialog(BuildContext context, ProductModel delete) {
  //   // set up the buttons
  //   Widget cancelButton = MaterialButton(
  //     child: Text("No"),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );
  //   Widget continueButton = MaterialButton(
  //     child: Text("Yes"),
  //     onPressed: () {
  //       wishListProvider.deleteWishList(delete.productId);
  //       Navigator.of(context).pop();
  //     },
  //   );
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("WishList Product"),
  //     content: Text("Are you devete on wishList Product?"),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    wishListProvider = Provider.of(context);
    wishListProvider.getWishtListData();
    return Scaffold(
      appBar: AppBar(
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
        title: Column(
          children: [
            Text(
              "Wish List",
              style: kBodyText,
            ),
            Text(
              "${wishListProvider.getWishList.length} items",
              style: kBodyText.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: wishListProvider.getWishList.length,
            itemBuilder: (context, index) {
              ProductModel data = wishListProvider.wishList[index];
              // totalAmount=reviewCartProvider.reviewCartDataList[index].cartPrice;
              // double total = double.parse(
              //     data.cartPrice);
              // totalAmount += total;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(
                      wishListProvider.getWishList[index].productId.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      wishListProvider.deleteWishList(data.productId);
                      wishListProvider.getWishList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Deleted Successfully'),
                        GestureDetector(
                            onTap: () {
                              wishListProvider.addWishListData(
                                wishListId: data.productId,
                                wishListImage: data.productURL,
                                wishListName: data.productName,
                                wishListPrice: data.productPrice,
                                wishListDescription: data.productDescription,
                              );
                            },
                            child: Text(
                              'Undo',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    )));
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(
                          FontAwesomeIcons.trash,
                          color: kOrange,
                        ),
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // print('-----------------------------------------------${wishListProvider.getWishList[index].productId}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    pID: wishListProvider
                                        .getWishList[index].productId,
                                    productImage: wishListProvider
                                        .getWishList[index].productURL,
                                    productPrice: wishListProvider
                                        .getWishList[index].productPrice,
                                    productDescription: wishListProvider
                                        .getWishList[index].productDescription,
                                    productName: wishListProvider
                                        .getWishList[index].productName,
                                  )));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 88,
                          height: 120,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // border: Border.all(color: kOrange),
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network(
                              data.productURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.productName,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text: "Rs ${data.productPrice}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kOrange),
                                children: [
                                  // TextSpan(
                                  //     text: " x${data.cartQuantity}",
                                  //     style:
                                  //     Theme.of(context).textTheme.bodyText1),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: size.width * 0.5,
                              child: Text("${data.productDescription}",
                                  maxLines: 1,
                                  // textAlign: TextAlign.justify,
                                  overflow: TextOverflow.clip,
                                  style: kBodyTextGrey.copyWith(fontSize: 15)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(
      //     vertical: 15,
      //     horizontal: 30,
      //   ),
      //   // height: 174,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(30),
      //       topRight: Radius.circular(30),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         offset: Offset(0, -15),
      //         blurRadius: 20,
      //         color: Color(0xFFDADADA).withOpacity(0.15),
      //       )
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(height: 20),
      //
      //       ],
      //     ),
      //   ),
      // ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       "WishList",
    //       style: TextStyle(color: kOrange, fontSize: 18),
    //     ),
    //   ),
    //   body: ListView.builder(
    //     itemCount: wishListProvider.getWishList.length,
    //     itemBuilder: (context, index) {
    //       ProductModel data = wishListProvider.getWishList[index];
    //       return Column(
    //         children: [
    //           SizedBox(
    //             height: 10,
    //           ),
    //           SingleItem(
    //             isBool: true,
    //             productImage: data.productImage,
    //             productName: data.productName,
    //             productPrice: data.productPrice,
    //             productId: data.productId,
    //             productQuantity: data.productQuantity,
    //             onDelete: () {
    //               showAlertDialog(context,data);
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}
