import 'package:flutter/material.dart';

import '../constants.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer(
      {@required this.imagePath,
        @required this.productTitle,
        @required this.productPrice});

  final String imagePath, productTitle, productPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 160.0,
              width: 140.0,
              child: Image.asset(
                imagePath,
                height: 100,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              productTitle,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              productPrice,
              style: kBodyTextBlack,
            ),
          ),
        ],
      ),
    );
  }
}
