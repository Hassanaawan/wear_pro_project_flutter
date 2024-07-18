import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/modules/product_des.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../constants.dart';

class ApprovalListScreen extends StatefulWidget {
  static const String id = 'ApprovalScreen';

  @override
  _ApprovalListScreenState createState() => _ApprovalListScreenState();
}

class _ApprovalListScreenState extends State<ApprovalListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Approval',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collectionGroup('products')
              .snapshots(),
          // stream: FirebaseFirestore.instance
          //     .collection('Vendors')
          //     .doc()
          //     .collection('products')
          //     .where('productPublished', isEqualTo: false)
          //     .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something Wrong Happens');
            }
            if (snapshot.hasData) {
              final List productId = snapshot.data!.docs.map((e) {
                return e.id;
              }).toList();
              final List productName = snapshot.data!.docs.map((e) {
                return e['productName'];
              }).toList();
              final List productPrice = snapshot.data!.docs.map((e) {
                return e['productPrice'];
              }).toList();
              final List productDescription = snapshot.data!.docs.map((e) {
                return e['productDescription'];
              }).toList();
              final List productURL = snapshot.data!.docs.map((e) {
                return e['productURL'];
              }).toList();
              return SingleChildScrollView(
                child: Column(
                    children: List.generate(
                  snapshot.data!.size,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, ProductDetailsScreen.id);
                      },
                      child: ShopProduct(
                        title: productName[index],
                        des: productDescription[index],
                        price: productPrice[index],
                        imagePath: productURL[index],
                      ),
                    );
                  },
                )),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              color: kOrange,
            ));
          }),
    );
  }
}
