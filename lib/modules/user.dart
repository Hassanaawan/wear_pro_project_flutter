import 'package:flutter/material.dart';

class User {
  final String imagePath;
  final String name;
  final String email;
  final String phoneNumber;
  final String homeAddress;
  final String about;
  final bool isDarkMode;

  const User({
    @required this.imagePath,
    @required this.name,
    @required this.email,
    this.phoneNumber,
    this.homeAddress,
    this.about,
    this.isDarkMode,
  });
}
