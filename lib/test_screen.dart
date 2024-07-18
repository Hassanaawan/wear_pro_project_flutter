import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:wear_pro/widgets/rounded_button.dart';

import 'buyer_screens/home_screen.dart';
import 'constants.dart';

class MyApp extends StatefulWidget {
  static const String id = 'MyApp';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> options = ['book1', 'book2', 'book3', 'book4'];
  var _emailController = TextEditingController();
  String email;
  final _formKey = GlobalKey<FormState>();
  bool _savingg = false;

  @override
  Widget build(BuildContext context) {
    String gender;
    return Scaffold(
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Text1',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(4),
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              // Text(
                              //   'Text1',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold, fontSize: 20),
                              // ),
                              Expanded(
                                child: DropdownButton<String>(
                                  // focusColor: Colors.red,
                                  dropdownColor: Colors.white,
                                  // itemHeight: ,
                                  hint: Text(
                                    'Select',
                                    style:
                                        kBodyText.copyWith(color: Colors.black87),
                                  ),
                                  value: gender,
                                  icon: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 90.0),
                                    child: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  underline: SizedBox(),
                                  iconSize: 25.0,
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold,color: Colors.black87),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      gender = newValue;
                                    });
                                  },

                                  items: options.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Text2',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(4),
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              // Text(
                              //   'Text1',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold, fontSize: 20),
                              // ),
                              Expanded(
                                child: DropdownButton<String>(
                                  // focusColor: Colors.red,
                                  dropdownColor: Colors.white,
                                  // itemHeight: ,
                                  hint: Text(
                                    'Select',
                                    style:
                                    kBodyText.copyWith(color: Colors.black87),
                                  ),
                                  value: gender,
                                  icon: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 90.0),
                                    child: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  underline: SizedBox(),
                                  iconSize: 25.0,
                                  style: kBodyText.copyWith(
                                      fontWeight: FontWeight.bold,color: Colors.black87),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      gender = newValue;
                                    });
                                  },

                                  items: options.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                    child: TextFormField(
                      controller: _emailController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        final bool _isValid =
                            EmailValidator.validate(_emailController.text);
                        if (!_isValid) {
                          return 'Invalid Email Format';
                        }
                        setState(() {
                          email = value;
                        });
                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[500].withOpacity(0.5),
                        filled: false,
                        hoverColor: kOrange,
                        // helperText: 'Add Text',
                        hintStyle: TextStyle(fontSize: 18.0),

                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 18.0, color: Colors.black87),
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
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  RoundedButton(
                    buttonName: 'Login',
                    onPress: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _savingg=true;
                        });

                        // try {

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('invalid user')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

