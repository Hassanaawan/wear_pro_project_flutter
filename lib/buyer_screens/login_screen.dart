import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wear_pro/admin_screens/admin_dashboard_screen.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/auth_provider.dart';
import 'package:wear_pro/providers/location_provider.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool _savingg = false;
  bool _visible = false;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String email, password;
    final locationData = Provider.of<LocationProvider>(context, listen: false);
    final _authData = Provider.of<AuthProvider>(context);

    return Stack(
      children: [
        BackgroundImage(imagePath: 'assets/images/cloth.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: ModalProgressHUD(
              inAsyncCall: _savingg,
              child: Column(
                children: [
                  Flexible(
                    child: Center(
                      child: Container(
                        child: Text(
                          'Wear Pro',
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 25.0),
                          child: TextFormField(
                            controller: _emailController,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              final bool _isValid = EmailValidator.validate(
                                  _emailController.text);
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
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
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
                      ),
                      // PasswordFieldInput(
                      //   onChanged: (value) {
                      //     password = value;
                      //   },
                      //   icon: FontAwesomeIcons.lock,
                      //   hint: 'Password',
                      //   inputType: TextInputType.name,
                      //   inputAction: TextInputAction.done,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 25.0),
                        child: TextFormField(
                          obscureText: _visible == false ? true : false,
                          controller: _passwordController,
                          // maxLines: 18,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password!';
                            }
                            if (value.length < 6) {
                              return 'Minimum 6 characters';
                            }
                            setState(() {
                              password = value;
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
                            hintStyle:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                            // prefixText: '+92',
                            prefixIcon: Icon(
                              Icons.vpn_key_outlined,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: _visible
                                  ? Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.white,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _visible = !_visible;
                                });
                              },
                            ),
                            labelText: 'Password',
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
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, ForgotPasswordScreen.id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 25.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Forgot Password?',
                                    textAlign: TextAlign.end,
                                    style: kBodyText.copyWith(
                                        fontSize: 17,
                                        wordSpacing: 1,
                                        letterSpacing: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      RoundedButton(
                        buttonName: 'Login',
                        onPress: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _savingg = true;
                            });
                            try {
                              await _authData
                                  .loginVendor(email, password)
                                  .then((credential) async {
                                if (credential.user.uid != null) {
                                  LocationPermission permission =
                                      await Geolocator.requestPermission();
                                  await locationData.getCurrentLocation();
                                  if (locationData.permit == true) {
                                    // print('aaaaaaaaaaaaaa');
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString(
                                        'email', _emailController.text);
                                    // Get.to(HomeScreen());
                                    if (_emailController.text ==
                                        'admin@gmail.com') {
                                      // print('bbbbbbbbbbbbbbbbbbbbbbbb');
                                      Navigator.pushReplacementNamed(
                                          context, AdminDashboardScreen.id);
                                    } else {
                                      // print('ccccccccccccccccccccc');
                                      // GetMaterialApp(home: HomeScreen(),);
                                      Navigator.pushReplacementNamed(
                                          context, HomeScreen.id);
                                    }
                                  } else {
                                    print('Permission not allowed!');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Allow Permission First')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('user=null')));
                                }
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Invalid Password ')));
                              setState(() {
                                _savingg = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'RegisterScreen'),
                    child: Container(
                      child: Text(
                        'Create New Account',
                        style: kBodyText,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
