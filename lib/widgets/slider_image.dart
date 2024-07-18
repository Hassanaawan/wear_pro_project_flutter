import 'package:flutter/material.dart';

class SliderImage extends StatelessWidget {
  const SliderImage({@required this.imagePath}) ;
  final imagePath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }
}