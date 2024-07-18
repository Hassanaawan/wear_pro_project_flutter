import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_success_screen.dart';
import 'package:wear_pro/buyer_screens/delivery_details_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/modules/review_cart_model.dart';
import 'package:wear_pro/providers/review_cart_provider.dart';
import 'package:wear_pro/widgets/rounded_button.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 0;
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
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
              "Your Cart",
              style: kBodyText,
            ),
            Text(
              "${reviewCartProvider.reviewCartDataList.length} items",
              style: kBodyText.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: reviewCartProvider.reviewCartDataList.length,
            itemBuilder: (context, index) {
              ReviewCartModel data =
                  reviewCartProvider.reviewCartDataList[index];
              // totalAmount=reviewCartProvider.reviewCartDataList[index].cartPrice;
              // double total = double.parse(
              //     data.cartPrice);
              // totalAmount += total;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(reviewCartProvider.reviewCartDataList[index].cartId
                      .toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      reviewCartProvider.reviewCartDataDelete(data.cartId);
                      reviewCartProvider.reviewCartDataList.removeAt(index);
                    });
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
                            data.cartImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.cartName,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                          SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text: "Rs ${data.cartPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, color: kOrange),
                              children: [
                                TextSpan(
                                    text: " x${data.cartQuantity}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: 'Rs: ${reviewCartProvider.getTotalPrice().toString()}',
                          style: TextStyle(
                              fontSize: 16,
                              color: kOrange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    child: RoundedButton(
                      buttonName: 'Check Out',
                      onPress: () {
                        if(reviewCartProvider.getReviewCartDataList.isEmpty){
                          return Fluttertoast.showToast(msg: "No Cart Data Found");
                        }
                        else{
                          Navigator.pushNamed(context, DeliveryDetailsScreen.id);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}