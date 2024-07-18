//home screen code.............................................

//     child: Container(
//       width: 65,
//       height: 25,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius:
//           BorderRadius.circular(5)),
//       child: index % 2 == 1
//           ? Row(
//         mainAxisAlignment:
//         MainAxisAlignment
//             .spaceEvenly,
//         children: [
//           Text(
//             "CLOSE",
//             style: TextStyle(
//                 fontSize: 10,
//                 color: Colors
//                     .black87,
//                 fontWeight:
//                 FontWeight
//                     .bold),
//           ),
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//                 color: Colors
//                     .redAccent,
//                 shape: BoxShape
//                     .circle),
//           )
//         ],
//       )
//           : Row(
//         mainAxisAlignment:
//         MainAxisAlignment
//             .spaceEvenly,
//         children: [
//           Text(
//             "OPEN",
//             style: TextStyle(
//                 fontSize: 10,
//                 color: Colors
//                     .black87,
//                 fontWeight:
//                 FontWeight
//                     .bold),
//           ),
//           Container(
//             width: 8,
//             height: 8,
//             decoration:
//             BoxDecoration(
//                 color: Colors
//                     .green,
//                 shape: BoxShape
//                     .circle),
//           )
//         ],
//       ),
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       Text(
//         "Attock City",
//         style: kBodyText,
//       ),
//       SizedBox(
//         width: 10,
//       ),
//       Icon(
//         FontAwesomeIcons.mapMarkerAlt,
//         size: 20,
//         color: kOrange,
//       )
//     ],
//   ),
// ),




// drawer: StreamBuilder<DocumentSnapshot>(
//     stream: FirebaseFirestore.instance
//         .collection('Buyers')
//         .doc(FirebaseAuth.instance.currentUser.uid)
//         .snapshots(),
//     builder: (context, snapshot) {
//       return Drawer(
//         child: Material(
//           color: kOrange,
//           child: SafeArea(
//             child: ListView(
//               padding: EdgeInsets.symmetric(horizontal: 20.0),
//               children: [
//                 SizedBox(
//                   height: 40.0,
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 90,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: AssetImage(
//                                 'assets/images/image_8.jpeg'),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         snapshot.data.get('fName'),
//                         style: kBodyText.copyWith(
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         FirebaseAuth.instance.currentUser.email,
//                         style: kBodyText.copyWith(fontSize: 18.0),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50.0,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, ProfileScreen.id);
//                   },
//                   child: BuildMenuItem(
//                     icon: Icons.account_circle_outlined,
//                     text: 'Profile',
//                   ),
//                 ),
//                 BuildMenuItem(
//                   icon: FontAwesomeIcons.shoppingBag,
//                   text: 'My Orders',
//                 ),
//                 BuildMenuItem(
//                   icon: Icons.error,
//                   text: 'About',
//                 ),
//                 SizedBox(height: 35),
//                 Divider(color: Colors.white, thickness: 1.4),
//                 SizedBox(
//                   height: 35.0,
//                 ),
//                 BuildMenuItem(
//                   icon: Icons.help,
//                   text: 'Help',
//                 ),
//                 BuildMenuItem(
//                   icon: Icons.logout,
//                   text: 'Log Out',
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(
//                         context, LoginScreen.id);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }),













// children: List.generate(4, (index) {
//   return GestureDetector(
//     onTap: (){
//       Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productID[index])));
//     },
//     child: ListContainer(
//       imagePath: productURL[index],
//       title: productTitle[index],
//       price: productPrice[index],
//     ),
//   );
// }),
// child: ListContainer(
//   imagePath:imageURL,
//   title: 'Women',
// ),











// Padding(
//   padding: const EdgeInsets.symmetric(
//       vertical: 8.0, horizontal: 25.0),
//   child: TextFormField(
//     controller: _emailController,
//     // The validator receives the text that the user has entered.
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Please Enter Email';
//       }
//       final bool _isValid = EmailValidator.validate(
//           _emailController.text);
//       if (!_isValid) {
//         return 'Invalid Email Format';
//       }
//       setState(() {
//         email = value;
//       });
//       return null;
//     },
//     style: TextStyle(
//         fontSize: 18, fontWeight: FontWeight.bold),
//     decoration: InputDecoration(
//       hoverColor: kOrange,
//       // helperText: 'Add Text',
//       hintStyle: TextStyle(fontSize: 18.0),
//       prefixIcon: Icon(
//         Icons.email,
//       ),
//       labelText: 'Email',
//       contentPadding: EdgeInsets.zero,
//       enabledBorder: OutlineInputBorder(),
//       focusedBorder: OutlineInputBorder(
//         // gapPadding: 12.0,
//         borderSide: BorderSide(
//           width: 2,
//           color: kOrange,
//         ),
//       ),
//       focusColor: Theme.of(context).primaryColor,
//     ),
//     keyboardType: TextInputType.emailAddress,
//     textInputAction: TextInputAction.next,
//     textAlign: TextAlign.left,
//   ),
// ),
