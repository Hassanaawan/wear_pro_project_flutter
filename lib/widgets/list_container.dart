import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/modules/product_des.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({@required this.imagePath,@required this.title, this.price});

  final String imagePath;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          Container(
            width: 160.0,
            height: 180.0,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imagePath), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5)),
                ),
                // Positioned(
                //   bottom: 1,
                //   child: Container(
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: Text(
                //         title,
                //         style: kBodyText.copyWith(fontWeight: FontWeight.bold,fontSize: 18.0),
                //       ),
                //     ),
                //     height: 35.0,
                //     width: 180,
                //     decoration: BoxDecoration(
                //         color: Colors.black45.withOpacity(0.3),
                //         borderRadius: BorderRadius.circular(5)),
                //   ),
                // ),
                // Container(
                //   width: 140,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Black Shirt',
                //         style: kBodyTextBlack,
                //       ),
                //       SizedBox(
                //         height: 5,
                //       ),
                //       Text(
                //         'Rs 1600',
                //         style: kBodyTextGrey,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          SizedBox(height: 5.0,),
          Container(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: kBodyTextBlack.copyWith(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rs. $price',
                  style: kBodyTextGrey.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
