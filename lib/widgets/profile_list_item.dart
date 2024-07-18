import 'package:flutter/material.dart';
import 'package:wear_pro/constants.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:profile_app_ui/constants.dart';

class ProfileListItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final IconData secondIcon;

  const ProfileListItem({this.name, this.icon, this.secondIcon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Container(
        height: size.height * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: kOrange,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              name,
              style: kBodyText.copyWith(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Icon(
                secondIcon,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
