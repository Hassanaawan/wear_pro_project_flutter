import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

import '../modules/delivery_address_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  // TextEditingController alternateMobileNo = TextEditingController();
  // TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  // TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  // TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  // LocationData setLocation;

  void validator(context) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "First name is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "Last name is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Mobile Number is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Street is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "City is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pin code is empty");
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        "firstName": firstName.text,
        "lastName": lastName.text,
        "mobileNo": mobileNo.text,
        // "alternateMobileNo": alternateMobileNo.text,
        // "scoiety": scoiety.text,
        "street": street.text,
        // "landmark": landmark.text,
        "city": city.text,
        // "area": area.text,
        "pinCode": pincode.text,
        // "addressType": myType.toString(),
        "longitude": 'setLoaction.longitude',
        "latitude": 'setLoaction.latitude',
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Added your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    if (db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: db.get("firstName"),
        lastName: db.get("lastName"),
        // addressType: db.get("addressType"),
        // aera: db.get("aera"),
        // alternateMobileNo: db.get("alternateMobileNo"),
        city: db.get("city"),
        // landMark: db.get("landmark"),
        mobileNo: db.get("mobileNo"),
        pinCode: db.get("pinCode"),
        // scoirty: db.get("scoiety"),
        street: db.get("street"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }


  //delete Address data from firebase
  deliveryAddressDataDelete() {
    FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser.uid)
        // .doc(addressId)
        .delete();
    notifyListeners();
  }

////// Order /////////
//
//   addPlaceOderData({
//     List<ReviewCartModel> oderItemList,
//     var subTotal,
//     var address,
//     var shipping,
//   }) async {
//     FirebaseFirestore.instance
//         .collection("Order")
//         .doc(FirebaseAuth.instance.currentUser.uid)
//         .collection("MyOrders")
//         .doc()
//         .set(
//       {
//         "subTotal": "1234",
//         "Shipping Charge": "",
//         "Discount": "10",
//         "orderItems": oderItemList
//             .map((e) => {
//                   "orderTime": DateTime.now(),
//                   "orderImage": e.cartImage,
//                   "orderName": e.cartName,
//                   // "orderUnit": e.cartUnit,
//                   "orderPrice": e.cartPrice,
//                   "orderQuantity": e.cartQuantity
//                 })
//             .toList(),
        // "address": address
        //     .map((e) => {
        //           "orderTime": DateTime.now(),
        //           "orderImage": e.cartImage,
        //           "orderName": e.cartName,
        //           "orderUnit": e.cartUnit,
        //           "orderPrice": e.cartPrice,
        //           "orderQuantity": e.cartQuantity
        //         })
        //     .toList(),
      // },
    // );
  // }
}
