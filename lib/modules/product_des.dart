

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductDescription  extends StreamBuilder{
  final int id;
  final String title, description;
  final String images;
  final double rating, price;
  final bool isFavourite, isPopular;

  ProductDescription({
    this.id,
    this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.title,
    this.price,
    this.description,
  });
  StreamBuilder abc(BuildContext context){

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('User').doc().snapshots(),
        builder: (context, snapshot) {
        return Column();
    });
  }
}

// Our demo Products

List<ProductDescription> myProducts = [
  // StreamBuilder<QuerySnapshot>(
  //   stream: FirebaseFirestore.instance.collection('Vendors').snapshots(),
  //   builder: (BuildContext context,
  //       AsyncSnapshot<QuerySnapshot> snapshot) {
  //     snapshot.data.docs.forEach((element) {
  //       var imageURL = element.get('imageURL');
  //     });
  //     if (!snapshot.hasData) {
  //       return CircularProgressIndicator();
  //     }
  //     return Container(
  //         width: 200,
  //         height: 200,
  //         child: Image.network(imageURL,fit: BoxFit.cover,),
  //       );
  //   },
  // ),
  ProductDescription(
    id: 1,
    images: "assets/images/image_3.jpeg",
    title: "Black Shirt For Men",
    price: 1200,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  ProductDescription(
    id: 2,
    images: "assets/images/image_8.jpeg",
    title: "Nike Man Pant",
    price: 500.00,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  ProductDescription(
    id: 3,
    images: "assets/images/image_6.jpeg",
    title: "Gloves XC Omega - Polygon",
    price: 3600.00,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  ProductDescription(
    id: 4,
    images: "assets/images/image_11.jpeg",
    title: "Kiddy Grey Shirt ",
    price: 2000.00,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Cotton Black Shirt for... Comfort and gives you what you want in your gaming "
    "from over precision control your games to sharing …";
