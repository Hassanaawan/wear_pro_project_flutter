import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';

class AuthProvider extends ChangeNotifier {
  String pickerError = '';
  bool isPicAvail = false;
  late File newImage;
  late double shopLatitude;
  late double shopLongitude;
  late String shopAddress;
  late String placeName;
  late String countryName;
  late String locality;
  late String featureName;
  late String adminArea;
  late String postalCode;
  late String email;
  late String password;
  String error = '';
  String pickError = '';

  //Register buyer using email
  Future<UserCredential> registerVendor(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.error = 'The password provided is too weak.';
        notifyListeners();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        this.error = 'The account already exists for that email.';
        notifyListeners();
        print('The account already exists for that email.');
      }
    } catch (e) {
      this.error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential;
  }

  //Login buyer using email
  Future<UserCredential> loginVendor(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigator.pushReplacementNamed(context, HomeScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        this.error = 'No user found for that email.';
        notifyListeners();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        this.error = 'Wrong password provided .';
        notifyListeners();
        print('Wrong password .');
        print(error);
      }
    }
    // } catch (e) {
    //   this.error = e.toString();
    //   notifyListeners();
    //   print(e);
    // }
    return userCredential;
  }

  //Save buyer data to DB
  Future<void> saveBuyerDataToDB({
    String fName,
    String lName,
    String age,
    String email,
    String gender,
    String password,
    // bool shopCreated,
  }) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference _buyers =
        FirebaseFirestore.instance.collection('Buyers').doc(user.uid);
    _buyers.set({
      'uid': user.uid,
      'age': age,
      'fName': fName,
      'lName': lName,
      'email': this.email,
      'password': password,
      'gender': gender,
      'userLatitude': '',
      'userLongitude': '',
      'shopCreated': false,
    });
  }

  //Update buyer data to DB
  Future<void> updateBuyerDataToDB({
    String shopCategory,
    bool shopCreated,
  }) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference _buyers =
        FirebaseFirestore.instance.collection('Buyers').doc(user.uid);
    _buyers.update({
      'shopCategory': shopCategory,
      'shopCreated': shopCreated,
    });
  }

  //get image from gallery
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
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

  Future getCurrentAddress() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    this.shopLatitude = _locationData.latitude;
    this.shopLongitude = _locationData.longitude;
    notifyListeners();
    // From coordinates
    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var _addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var shopAddress = _addresses.first;
    this.shopAddress = shopAddress.addressLine;
    this.placeName = shopAddress.featureName;
    this.countryName = shopAddress.countryName;
    this.locality = shopAddress.locality;
    this.postalCode = shopAddress.postalCode;
    this.featureName = shopAddress.featureName;
    this.adminArea = shopAddress.adminArea;
    // print('dekho----------->${shopAddress.}');
    notifyListeners();
    return shopAddress;
  }

  //saving shop details to firebase
  Future<void> saveShopDetailsToDB(
      {String url,
      String shopName,
      String shopDescription,
      String mobileNo,
      String shopCategory,
      String shopAddress}) async {
    // DocumentReference _vendors = FirebaseFirestore.instance.collection('vendors').add(data);
    try {
      final addVendor = await FirebaseFirestore.instance
          .collection('Vendors')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
            'shopId': FirebaseAuth.instance.currentUser.uid,
            'shopName': shopName,
            'mobileNo': mobileNo,
            'shopCategory': shopCategory,
            'shopDescription': shopDescription,
            'email': FirebaseAuth.instance.currentUser.email,
            'shopLatitude': this.shopLatitude,
            'shopLongitude': this.shopLongitude,
            'address': shopAddress,
            'shopOpen': true,
            'rating': '4.8',
            'totalRating': '0',
            'city': this.locality,
            'imageURL': url,
            'accVerified': true,
          })
          .then((value) => print('Cloth Shop Data Added Successfully!'))
          .catchError((onError) {
            print('Cloth Shop Data  Not Successfully');
          });
    } catch (e) {
      print(e);
    }

    return null;
  }

  //saving tailor shop details to firebase

  Future<void> saveTailorDetailsToDB(
      {String url,
      String shopName,
      String shopDescription,
      String mobileNo,
      String shopCategory,
      String shopAddress}) async {
    // DocumentReference _vendors = FirebaseFirestore.instance.collection('vendors').add(data);
    try {
      final addVendor = await FirebaseFirestore.instance
          .collection('Tailors')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
            'shopID': FirebaseAuth.instance.currentUser.uid,
            'shopName': shopName,
            'shopDescription': shopDescription,
            'mobileNo': mobileNo,
            'shopCategory': shopCategory,
            'email': FirebaseAuth.instance.currentUser.email,
            'shopLatitude': this.shopLatitude,
            'shopLongitude': this.shopLongitude,
            'address': shopAddress,
            'shopOpen': true,
            'rating': '4.7',
            'totalRating': '0',
            'city': this.locality,
            'imageURL': url,
            'accVerified': true,
          })
          .then((value) => print('Tailor Added Successfully!'))
          .catchError((onError) {
            print('Tailor Not added Successfully');
          });
    } catch (e) {
      print(e);
    }

    return null;
  }

////////// Update seller shop status  /////
  Future<void> updateSellerStatus({bool shopStatus}) {
    FirebaseFirestore.instance
        .collection("Vendors")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'shopOpen': shopStatus,
    });
  }
}
