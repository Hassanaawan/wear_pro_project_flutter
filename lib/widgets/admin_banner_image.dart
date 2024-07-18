import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';

class AdminBannerImage extends StatelessWidget {
  const AdminBannerImage({@required this.imagePath, this.icon, this.onPressed});

  final imagePath;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(icon,color: kOrange,size: 27,),
                  onPressed: onPressed,
                ),
              ))
        ],
      ),
    );
  }
}
