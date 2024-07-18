import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';

import '../modules/delivery_address_model.dart';
import '../providers/review_cart_provider.dart';
import '../widgets/single_delivery_item.dart';

class PaymentSummaryScreen extends StatefulWidget {
  static const String id = 'PaymentSummaryScreen';
  final DeliveryAddressModel deliverAddressList;

  PaymentSummaryScreen({this.deliverAddressList});

  @override
  _PaymentSummaryScreenState createState() => _PaymentSummaryScreenState();
}

enum AddressTypes {
  COD,
  OnlinePayment,
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  var myType = AddressTypes.COD;

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
        title: Text(
          "Payment Summary",
          style: kBodyText,
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "Rs: ${reviewCartProvider.getTotalPrice() + 300}",
          style: TextStyle(
            color: kOrange,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            height: 40,
            onPressed: () {
              //List cart = [];
              myType == AddressTypes.OnlinePayment
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                            // total: total,
                            ),
                      ),
                    )
                  : FirebaseFirestore.instance
                      .collection('ReviewCart')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .delete()
                      .whenComplete(() {
                      final cart = reviewCartProvider.getReviewCartDataList;
                      cart.map((e) {
                        FirebaseFirestore.instance
                            .collection('Vendors')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('Requests')
                            .add({
                          'buyerId':
                              FirebaseAuth.instance.currentUser.uid.toString(),
                          'productId': '${e.cartId}',
                          'orderStatus': 'pending',
                          'vendorId': '${e.vendorId}'
                        });
                      }).toList();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BuyerSuccessScreen(),
                        ),
                      );
                    });
            },
            child: Text(
              "Place Order",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            color: kOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  address:
                      "${widget.deliverAddressList.street}, ${widget.deliverAddressList.city},\nPostal Code: ${widget.deliverAddressList.pinCode}",
                  title:
                      "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                  number: widget.deliverAddressList.mobileNo,
                ),
                // Divider(),
                // ExpansionTile(
                //   children: reviewCartProvider.getReviewCartDataList.map((e) {
                //     return OrderItem(
                //       e: e,
                //     );
                //   }).toList(),
                //   title: Text(
                //       "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                // ),
                // Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "Rs: ${reviewCartProvider.getTotalPrice()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "Rs: 300",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text("Payment Options"),
                ),
                RadioListTile(
                  value: AddressTypes.COD,
                  groupValue: myType,
                  title: Text("Cash On Delivery"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.work,
                    color: kOrange,
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text("OnlinePayment"),
                  onChanged: (AddressTypes value) {
                    setState(() {
                      myType = value;
                    });
                  },
                  secondary: Icon(
                    Icons.devices_other,
                    color: kOrange,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
