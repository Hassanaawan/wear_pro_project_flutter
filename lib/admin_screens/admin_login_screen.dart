import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/admin_screens/admin_dashboard_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/widgets.dart';

class AdminLoginScreen extends StatelessWidget {
  static const String id = 'AdminLoginScreen';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(imagePath: 'assets/images/cloth.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
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
                    child: TextFieldInput(
                      icon: FontAwesomeIcons.envelope,
                      // hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                  ),
                  PasswordFieldInput(
                    icon: FontAwesomeIcons.lock,
                    hint: 'Password',
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.done,
                  ),
                  GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'ForgotPasswordScreen'),
                      child: Text(
                        'Forgot Password',
                        style: kBodyText,
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AdminDashboardScreen.id);
                      },
                      child: RoundedButton(buttonName: 'Login')),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
