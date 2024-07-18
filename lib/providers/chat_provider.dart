import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  String _buyerEmail = '';
  String _buyerUid = '';
  String _sellerEmail = '';
  String _sellerUid = '';
  String _sellerName = '';
  String _buyerName = '';

  String get buyerEmail => _buyerEmail;
  String get buyerUid => _buyerUid;
  String get sellerEmail => _sellerEmail;
  String get sellerUid => _sellerUid;
  String get sellerName => _sellerName;
  String get buyerName => _buyerName;

  var buyerCollection = FirebaseFirestore.instance.collection('Buyers');
  var sellerCollection = FirebaseFirestore.instance.collection('Vendors');

  setbuyerUidandEmail(String Uid) async {
    _buyerUid = Uid;
    var docSnapshot = await buyerCollection.doc(Uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      _buyerEmail = data['email'];
      _buyerName = data['fName'];
    }
    notifyListeners();
  }

  setsellerUidandEmail(String Uid) async {
    _sellerUid = Uid;
    var docSnapshot = await sellerCollection.doc(Uid).get();
    var doc1Snapshot = await buyerCollection.doc(Uid).get();
    if (docSnapshot.exists && doc1Snapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      Map<String, dynamic> data1 = doc1Snapshot.data();
      _sellerEmail = data['email'];
      _sellerName = data1['fName'];
    }
    notifyListeners();
  }
}
