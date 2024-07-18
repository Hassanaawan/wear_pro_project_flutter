import 'package:flutter/material.dart';

const kBodyText = TextStyle(
  fontSize: 19.0,
  color: Colors.white,
  height: 1.5,
);

const kBodyTextBlack =  TextStyle(
  fontSize: 19.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextGrey = TextStyle(
  fontSize: 18.0,
  color: Colors.grey,
);

const kHeadTextBlack = TextStyle(
  fontSize: 23.0,
  color: Colors.black87,
);

const kOrange = Color(0xffff8013);

const kBlack = Color(0xff212529);

const kBackgroundColor = Color(0xFFFFE6E6);


const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);


const List<Map<String, Object>> categories = [
  {
    'title': 'New In',
    'imgPath': 'assets/images/image_1.jpeg',
  },
  {
    'title': 'Clothing',
    'imgPath': 'assets/images/image_2.jpeg',
  },
  {
    'title': 'Men',
    'imgPath': 'assets/images/image_4.jpeg',
  },
  {
    'title': 'Women',
    'imgPath': 'assets/images/girl.jpeg',
  },
  {
    'title': 'Ghar k Kapry',
    'imgPath': 'assets/images/cloth.jpeg',
  },
];
