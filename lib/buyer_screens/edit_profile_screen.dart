import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/modules/user_preferences.dart';
import 'package:wear_pro/modules/user.dart';
import 'package:wear_pro/widgets/text_field_input.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../constants.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User user = UserPreferences.myUser;
  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(imagePath: 'assets/images/image_11.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Edit Profile'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              ),
            ),
            backgroundColor: kOrange,
            elevation: 5,
            actions: [
              IconButton(
                icon: Icon(FontAwesomeIcons.solidSun),
                onPressed: () {},
              ),
            ],
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade500.withOpacity(0.5),
                      radius: size.width * 0.14,
                      foregroundImage: AssetImage('assets/images/image_8.jpeg'),
                      child: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.white,
                        size: size.width * 0.1,
                      ),
                    ),
                  ),
                  Positioned(
                    // bottom: 0,
                    top: 50,
                    left: size.width * 0.54,
                    child: Container(
                      height: size.height * 0.13,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                        color: kOrange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.0),
                      ),
                      child: Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.white,
                        size: size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: TextFieldInput(
                  // text: user.name,
                  // onChange: (text){},
                  // icon: FontAwesomeIcons.user,
                  // hint: 'Full Name',
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: TextFieldInput(
                  // onChange: (email){},
                  // text: user.email,
                  // icon: FontAwesomeIcons.envelope,
                  // hint: 'Email',
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: TextFieldInput(
                  // onChange: (phoneNo){},
                  // text: user.phoneNumber,
                  // icon: FontAwesomeIcons.phoneAlt,
                  // hint: 'Phone Number',
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: TextFieldInput(
                  // onChange: (address){},
                  // text: user.homeAddress,
                  // icon: FontAwesomeIcons.home,
                  // hint: 'Home Address',
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  maxLines: 2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: RoundedButton(buttonName: 'Save'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
