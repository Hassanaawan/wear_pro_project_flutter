import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';

class TextFieldInput extends StatefulWidget {
  const TextFieldInput(
      {@required this.icon,
      @required this.inputType,
      @required this.inputAction,
      this.labelText,
      this.maxLines,
      this.maxWords,

      this.controller,
      this.validator});

  // final String hint;
  // final ValueChanged<String> onChange;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final IconData icon;
  final String labelText;
  final int maxLines;
  final int maxWords;
  final controller;
  final Function validator;

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        maxLines: widget.maxLines,
        controller: widget.controller,
        // The validator receives the text that the user has entered.
        validator: widget.validator,
        // (value) {
        // if (value == null || value.isEmpty) {
        //   return 'Please Enter Shop Name';
        // }
        // setState(() {
        //   shopName = value;
        // });
        // return null;
        // },
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          fillColor: Colors.grey[500].withOpacity(0.5),
          filled: true,
          hoverColor: kOrange,
          // helperText: 'Add Text',
          hintStyle: TextStyle(fontSize: 18.0,color: Colors.white),
          prefixIcon: Icon(
            widget.icon,color: Colors.white,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(fontSize: 18.0,color: Colors.white),
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            // gapPadding: 12.0,
            borderSide: BorderSide(
              width: 2,
              color: kOrange,
            ),
          ),
          focusColor: Theme.of(context).primaryColor,
        ),
        keyboardType: widget.inputType,
        textInputAction: widget.inputAction,
        textAlign: TextAlign.left,
        maxLength: widget.maxWords,
      ),
    );
  }
}

//
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 10.0),
// child: Container(
// // height: size.height * 0.08,
// width: size.width * 0.8,
// decoration: BoxDecoration(
// color: Colors.grey[500].withOpacity(0.5),
// borderRadius: BorderRadiusDirectional.circular(16),
// ),
// child: TextFormField(
// onChanged: widget.onChange,
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: widget.hint,
//
// hintStyle: kBodyText.copyWith(color: Colors.white70,),
// prefixIcon: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 10.0),
// child: Icon(
// widget.icon,
// color: Colors.white,
// size: 25.0,
// ),
// ),
// ),
// keyboardType: widget.inputType,
// style: kBodyText.copyWith(
// fontWeight: FontWeight.bold,
// ),
// // autofocus: true,
//
// textInputAction: widget.inputAction,
// maxLines: widget.maxLines,
// ),
// ),
// );
