import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/auth_provider.dart';
import 'package:wear_pro/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/tailor_provider.dart';
import 'home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TailorProvider tailorProvider;

  String fName, lName, email, password, confirmPassword, gender, age;
  List<String> options = ['Male', 'Female'];
  final _auth = FirebaseAuth.instance;
  bool _saving = false;
  bool _visible = false;
  var _fNameController = TextEditingController();
  var _lNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _cPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    tailorProvider = Provider.of(context);

    Size size = MediaQuery.of(context).size;
    final _authData = Provider.of<AuthProvider>(
      context,
    );
    return Stack(
      children: [
        BackgroundImage(
          imagePath: 'assets/images/registerImage.jpeg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: ModalProgressHUD(
              inAsyncCall: _saving,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Column(
                      children: [
                        TextFieldInput(
                          controller: _fNameController,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your First Name!';
                            }
                            setState(() {
                              fName = value;
                            });
                            return null;
                          },
                          labelText: 'First Name',
                          icon: FontAwesomeIcons.user,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                        ),
                        TextFieldInput(
                          controller: _lNameController,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Last Name!';
                            }
                            setState(() {
                              lName = value;
                            });
                            return null;
                          },
                          labelText: 'Last Name',
                          icon: FontAwesomeIcons.user,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                        ),
                        TextFieldInput(
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Age!';
                            }
                            setState(() {
                              age = value;
                            });
                            return null;
                          },
                          labelText: 'Age',
                          icon: Icons.calendar_today_outlined,
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadiusDirectional.circular(4),
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButton<String>(
                                        // focusColor: Colors.red,
                                        dropdownColor:
                                            Colors.grey.withOpacity(0.7),
                                        // itemHeight: ,
                                        hint: Text(
                                          'Gender',
                                          style: kBodyText.copyWith(
                                              color: Colors.white),
                                        ),
                                        value: gender,
                                        icon: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: .0),
                                          child: Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        underline: SizedBox(),
                                        iconSize: 25.0,
                                        style: kBodyText.copyWith(
                                            fontWeight: FontWeight.bold),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            gender = newValue;
                                          });
                                        },
                                        // selectedItemBuilder: (BuildContext context) {
                                        //   return options.map((String value) {
                                        //     return Text(
                                        //       dropdownValue,
                                        //       style: const TextStyle(color: Colors.black87),
                                        //     );
                                        //   }).toList();
                                        // },
                                        items: options
                                            .map<DropdownMenuItem<String>>(
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
                        // TextFieldInput(
                        //   onChange: (value) {
                        //     email = value;
                        //   },
                        //   icon: FontAwesomeIcons.envelope,
                        //   hint: 'Email',
                        //   inputType: TextInputType.emailAddress,
                        //   inputAction: TextInputAction.next,
                        // ),
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
                              fillColor: Colors.grey[500].withOpacity(0.5),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 25.0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _visible == false ? true : false,

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
                              fillColor: Colors.grey[500].withOpacity(0.5),
                              filled: true,
                              hoverColor: kOrange,
                              // helperText: 'Add Text',
                              hintStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
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
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 25.0),
                          child: TextFormField(
                            controller: _cPasswordController,

                            obscureText: _visible,
                            // maxLines: 18,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password Again!';
                              }
                              if (value.length < 6) {
                                return 'Minimum 6 characters';
                              }
                              // if (_passwordController != _cPasswordController) {
                              //   return 'Password does not match!';
                              // }
                              setState(() {
                                confirmPassword = value;
                              });
                              return null;
                            },
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Colors.grey[500].withOpacity(0.5),
                              filled: true,
                              hoverColor: kOrange,
                              // helperText: 'Add Text',
                              hintStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
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
                              labelText: 'Confirm Password',
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
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        RoundedButton(
                          buttonName: 'Register',
                          onPress: () async {
                            if (_formKey.currentState.validate()) {
                              print('firstttttttttttt');
                              setState(() {
                                _saving = true;
                              });
                              print('seconddddddd');

                              await _authData
                                  .registerVendor(email, password)
                                  .then((credentials) {
                                if (credentials.user.uid != null) {
                                  // print(credentials.user.uid);
                                  _authData
                                      .saveBuyerDataToDB(
                                          email: email,
                                          age: age,
                                          fName: fName,
                                          lName: lName,
                                          gender: gender,
                                          password: password)
                                      .then((value) {
                                        tailorProvider.addTailorSampleImage();
                                        setState(() {
                                          _formKey.currentState.reset();
                                          _saving=false;
                                        });
                                        Navigator.pushReplacementNamed(
                                            context, HomeScreen.id);
                                    print('Fourthhhhhhhhhhhhh');
                                  }).catchError((onError) {
                                    print('not added successfully');
                                  });
                                } else {
                                  setState(() {
                                    _saving = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                        content: Text('User=NULL')),
                                  );
                                }
                                setState(() {
                                  _saving = false;
                                });
                              });
                              setState(() {
                                _saving = false;
                              });
                            } else {
                              setState(() {
                                _saving = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${_authData.error.toString()}')),
                              );
                            }
                            setState(() {
                              _saving = false;

                            });

//...........................................................................................
//                             try {
//                               final newUser =
//                               await _auth.createUserWithEmailAndPassword(
//                                   email: email, password: password);
//                               if (newUser != null) {
//                                 Navigator.pushReplacementNamed(
//                                     context, HomeScreen.id);
//                               }
//                               setState(() {
//                                 _saving = false;
//                               });
//                               final addValueInCollection =
//                               await FirebaseFirestore.instance
//                                   .collection('Buyer')
//                                   .doc(FirebaseAuth
//                                   .instance.currentUser.uid).
//                               set({
//                                 'firstName': fName,
//                                 'lastName': lName,
//                                 'age': age,
//                                 'gender': gender,
//                                 'email': email,
//                                 'password': password,
//                               })
//                                   .then((value) =>
//                                   print('Added Successfully!'))
//                                   .catchError((onError) {
//                                 print('Not Successfully');
//                               });
//                             }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: kBodyText,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                              child: Text(
                                'Login',
                                style: kBodyText.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
