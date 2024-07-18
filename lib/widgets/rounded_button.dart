import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({@required this.buttonName, this.onPress});

  final String buttonName;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
      child: Container(
        height: size.height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: kOrange,
        ),
        child: MaterialButton(
          onPressed: onPress,
          child: Text(
            buttonName,
            style: kBodyText.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
