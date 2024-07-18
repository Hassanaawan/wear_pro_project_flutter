import 'package:flutter/material.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../constants.dart';

class ShopProduct extends StatelessWidget {
  const ShopProduct({this.imagePath, this.title, this.des, this.price});

  final String imagePath;
  final String title;
  final String des;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            // border: Border.all(color: Colors.red,width: 1.0)
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 5,
                  color: Colors.grey.withOpacity(0.6))
            ]),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 200,
                        height: 25,
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.red,width: 1.0)
                            ),
                        child: Text(
                          title,
                          style: kBodyTextBlack,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 200,
                        height: 45,
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.red,width: 1.0)
                            ),
                        child: Text(
                          des,
                          style: kBodyTextGrey,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: 200,
                        height: 20,
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.red,width: 1.0)
                            ),
                        child: Text(
                          'Rs: $price',
                          style: kBodyTextGrey.copyWith(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: kOrange),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          imagePath,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, top: 8.0, right: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey,
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Reject',
                        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 8.0, right: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: kOrange,
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Accept',
                        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
