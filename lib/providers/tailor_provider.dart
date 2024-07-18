import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wear_pro/modules/tailor_model.dart';

class TailorProvider extends ChangeNotifier {
  bool tailorShopOpen;

//Fetching Tailor Data

  List<TailorModel> tailorModelList = [];
  TailorModel tailorModel;

  fetchTailorData() async {
    List<TailorModel> newTailorModelList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection('Tailors').get();
    value.docs.forEach((element) {
      tailorModel = TailorModel(
        tailorID: element.get('shopID'),
        tailorAddress: element.get('address'),
        tailorImage: element.get('imageURL'),
        tailorMobileNo: element.get('mobileNo'),
        tailorName: element.get('shopName'),
        tailorShopOpen: element.get('shopOpen'),
      );
      newTailorModelList.add(TailorModel());
    });
    tailorModelList = newTailorModelList;
    notifyListeners();
  }

  List<TailorModel> get getTailorModelList {
    return tailorModelList;
  }

//add tailor sample
  addTailorSampleImage({
    // String tailorSampleId,
    // String tailorSampleName,
    String tailorSampleImage,
  }) {
    print(
        '----------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$tailorSampleImage');
    FirebaseFirestore.instance
        .collection("Tailors")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourTailorSamples")
        .add({
      // "tailorSampleId": tailorSampleId,
      // "tailorSampleName": tailorSampleName,
      "tailorSampleImage": tailorSampleImage,
    }).then((value) {
      print('Sample Image Added Successfully!');
    });
  }

///// Get tailor samples for tailors themselves ///////
  List<TailorModel> tailorSampleList = [];

  fetchTailorSampleData() async {
    List<TailorModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("Tailors")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourTailorSamples")
        .get();
    value.docs.forEach(
      (element) {
        TailorModel tailorModel = TailorModel(
          // tailorID:  element.get("tailorSampleId"),
          tailorImage: element.get("tailorSampleImage"),
          // tailorName: element.get("tailorSampleName"),
        );
        newList.add(tailorModel);
      },
    );
    tailorSampleList = newList;
    notifyListeners();
  }

  List<TailorModel> get getTailorSampleList {
    return tailorSampleList;
  }

////////// Update Tailor Sample /////
  Future<void> updateTailorData({bool shopStatus}) {
    FirebaseFirestore.instance
        .collection("Tailors")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'shopOpen': shopStatus,
    });
  }

///// Get tailor samples for users ///////
  List<TailorModel> tailorSampleListUser = [];

  fetchTailorSampleDataUser({
    String tailorID,
  }) async {
    List<TailorModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("Tailors")
        .doc(tailorID)
        .collection("YourTailorSamples")
        .get();
    value.docs.forEach(
      (element) {
        TailorModel tailorModel = TailorModel(
          // tailorID:  element.get("tailorSampleId"),
          tailorImage: element.get("tailorSampleImage"),
          // tailorName: element.get("tailorSampleName"),
        );
        newList.add(tailorModel);
      },
    );
    tailorSampleListUser = newList;
    notifyListeners();
  }

  List<TailorModel> get getTailorSampleListUser {
    return tailorSampleListUser;
  }
}
