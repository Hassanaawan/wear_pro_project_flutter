import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wear_pro/modules/review_cart_model.dart';

class ReviewCartProvider extends ChangeNotifier {
  //save cart data to firebase
  Future<void> saveReviewCartDataToFB({
    String cartId,
    String cartName,
    String cartPrice,
    String cartImage,
    String cartQuantity,
    String vendorId,
  }) async {
    try {
      final addToCart = await FirebaseFirestore.instance
          .collection('ReviewCart')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('YourReviewCart')
          .doc(cartId)
          .set({
            'cartId': cartId,
            'cartName': cartName,
            'cartPrice': cartPrice,
            'cartImage': cartImage,
            'cartQuantity': cartQuantity,
            'vendorId': vendorId,
          })
          .then((value) => print('Product Added to cart Successfully!'))
          .catchError((onError) {
            print('Product Not added to cart Successfully!!');
          });
    } catch (e) {
      print('...................>>>>>>>>>>>>>>>>>>>>>$e');
    }
    return null;
  }

  //get cart data from firebase
  List<ReviewCartModel> reviewCartDataList = [];

  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourReviewCart')
        .get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get('cartId'),
        cartName: element.get('cartName'),
        cartPrice: element.get('cartPrice'),
        cartImage: element.get('cartImage'),
        cartQuantity: element.get('cartQuantity'),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

  //// TotalPrice  ///

  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      total += double.parse(element.cartPrice);
    });
    return total;
  }

  //delete cart data from firebase
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourReviewCart')
        .doc(cartId)
        .delete();
    notifyListeners();
  }
}
