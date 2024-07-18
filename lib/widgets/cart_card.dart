import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/modules/cart.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    @required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          height: 120,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              // border: Border.all(color: kOrange),
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(
              cart.product.images,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "Rs ${cart.product.price}",
                style: TextStyle(fontWeight: FontWeight.w600, color: kOrange),
                children: [
                  TextSpan(
                      text: " x${cart.numOfItem}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
