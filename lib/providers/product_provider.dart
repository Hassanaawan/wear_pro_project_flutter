import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:wear_pro/modules/product_model.dart';
import 'package:wear_pro/modules/recently_view_model.dart';

import '../modules/review_cart_model.dart';

class ProductProvider extends ChangeNotifier {
  bool isPicAvail = false;
  File newImage;
  String pickError;

  //image picker
  final ImagePicker _picker = ImagePicker();

  Future<File> getProductImage() async {
    final XFile image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      newImage = File(image.path);
      notifyListeners();
      print(newImage);
    } else {
      this.pickError = 'no image selected!';
      print('no image selected!');
      notifyListeners();
    }
    // final file = image.toFile();
    return newImage;
  }

  //alert dialogue
  alertDialog({context, title, content}) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext contxt) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  //Save products to firebase
  Future<void> saveProductDetailsToFB({
    String productId,
    String productURL,
    String pName,
    String pDescription,
    String pPrice,
    String pCategory,
    String vendorId,
  }) async {
    try {
      final addProduct = await FirebaseFirestore.instance

          .collection('Vendors')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('products')
          .add({
        'productId': productId,
        'productURL': productURL,
        'productName': pName,
        'productDescription': pDescription,
        'productPrice': pPrice,
        'productCategory': pCategory,
        'productRating': '0.00',
        'productVerified': true,
        'productPublished': true,
        "vendorId":FirebaseAuth.instance.currentUser.uid.toString(),
      })
          .then((value) => print('Product Added Successfully!!'))
          .catchError((onError) {
        print('Product Not added Successfully!!');
      });
    } catch (e) {
      print("product added exception is:::::::::::::::::: $e");
    }
    return null;
  }


  //Save products Pattern to firebase
  Future<void> saveProductPatternToFB({
    String pId,
    String productURL,
    String pName,
    String pDescription,
    String pPrice,
    String pCategory,
  }) async {
    try {
      final addProduct = await FirebaseFirestore.instance
          .collection('Pattern')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('YourPattern')
          .doc(pId)
          .set({
        'productId': pId,
        'productURL': productURL,
        'productName': pName,
        'productDescription': pDescription,
        'productPrice': pPrice,
        'productCategory': pCategory,
        // 'productRating': '0.00',
        // 'productVerified': true,
        // 'productPublished': true,
      })
          .then((value) => print('Product Pattern Added Successfully!!'))
          .catchError((onError) {
        print('Product Pattern Not added Successfully!!');
      });
    } catch (e) {
      print(e);
    }
    return null;
  }


  //Fetching products ....

  List<ProductModel> productModelList = [];
  ProductModel productModel;

  fetchProductData() async {
    List<ProductModel> newProductModelList = [];

    QuerySnapshot value =
    await FirebaseFirestore.instance.collectionGroup('products').get();
    value.docs.forEach((element) {
      productModel = ProductModel(
        productId: element.get('productId'),
        productName: element.get('productName'),
        productDescription: element.get('productDescription'),
        productURL: element.get('productURL'),
        productCategory: element.get('productCategory'),
        productPrice: element.get('productPrice'),
        productRating: element.get('productRating'),
        productPublished: element.get('productPublished'),
        productVerified: element.get('productVerified'),
        vendorId: element.get('vendorId'),
      );
      newProductModelList.add(productModel);
    });
    productModelList = newProductModelList;
    notifyListeners();
  }

  List<ProductModel> get getProductModelList {
    return productModelList;
  }


//get recently view from firebase
  List<RecentlyViewModel> recentlyViewProductList = [];
  RecentlyViewModel recentlyViewModel;

   fetchRecentlyViewedProducts() async {
    List<RecentlyViewModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection('Pattern')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('YourPattern')
        .get();
    value.docs.forEach((element) {
       recentlyViewModel = RecentlyViewModel(
        productId: element.get('productId'),
        productName: element.get('productName'),
        productPrice: element.get('productPrice'),
        productURL: element.get('productURL'),
        productDescription: element.get('productDescription'),
      );
      newList.add(recentlyViewModel);
    });
    recentlyViewProductList = newList;
    notifyListeners();
  }

  List<RecentlyViewModel> get getRecentlyViewDataList {
    return recentlyViewProductList;
  }
}

