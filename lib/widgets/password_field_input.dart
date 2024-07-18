import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';

class PasswordFieldInput extends StatelessWidget {
  const PasswordFieldInput({@required this.icon,@required this.hint, this.inputType, this.inputAction, this.onChanged});

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadiusDirectional.circular(16),
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: kBodyText,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
          keyboardType: inputType,
          obscureText: true,
          style: kBodyText,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
