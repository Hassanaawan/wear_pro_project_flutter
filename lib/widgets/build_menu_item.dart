import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';

class BuildMenuItem extends StatelessWidget {
  const BuildMenuItem({@required this.icon, @required this.text,this.onPressed}) ;
  final IconData icon;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
      ),
      hoverColor: Colors.orange.shade700,
      onTap: onPressed,
    );
  }
}
