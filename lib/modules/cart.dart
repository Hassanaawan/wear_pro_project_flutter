import 'package:flutter/material.dart';
import 'package:wear_pro/modules/product_des.dart';

class Cart {
final ProductDescription product;
final int numOfItem;

Cart({@required this.product, @required this.numOfItem});

}

List<Cart> myCarts = [

  Cart(product: myProducts[0], numOfItem: 2),
  Cart(product: myProducts[1], numOfItem: 1),
  Cart(product: myProducts[3], numOfItem: 1),
  Cart(product: myProducts[3], numOfItem: 3),

];
