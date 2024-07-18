import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'ForgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var _emailController = TextEditingController();
  late String email;

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(imagePath: 'assets/images/cloth.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Forgot Password',
              style: kBodyText,
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Text(
                      'Enter your email where we will send'
                      ' instructions to reset your password.',
                      style: kBodyText,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25.0),
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
                          color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[500]!.withOpacity(0.5),
                        filled: true,
                        hoverColor: kOrange,
                        // helperText: 'Add Text',
                        hintStyle: TextStyle(fontSize: 18.0),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(fontSize: 18.0, color: Colors.white),
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
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  RoundedButton(
                    buttonName: 'Send',
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email);
                          var snackBar = SnackBar(
                              content: Text(
                                  'Password reset email sent Successfully!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
