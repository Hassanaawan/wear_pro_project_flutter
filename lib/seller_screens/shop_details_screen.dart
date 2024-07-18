import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/auth_provider.dart';
import 'package:wear_pro/providers/product_provider.dart';
import 'package:wear_pro/seller_screens/seller_shop_screen.dart';
import 'package:wear_pro/seller_screens/seller_tailor_screen.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../providers/tailor_provider.dart';

class ShopDetailsScreen extends StatefulWidget {
  static const String id = 'ShopDetailsScreen';

  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  TailorProvider tailorProvider;
  final _formKey = GlobalKey<FormState>();
  File _image;
  File _sampleImage;
  var _shopCategoryController = TextEditingController();
  var _addressController = TextEditingController();
  var _cityController = TextEditingController();
  var _countryController = TextEditingController();
  var _shopNameController = TextEditingController();
  var _shopDescriptionController = TextEditingController();
  String shopName;
  String shopDescription;
  String mobileNo;
  String shopCategory;
  String shopLocation;
  bool isLoading = false;
  List<String> options = ['Cloth Seller', 'Tailor'];

  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(filePath) async {
    File file = File(filePath);

    try {
      await _storage
          .ref('uploads/shopPosters/${_shopNameController.text}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
    String downloadURL = await _storage
        .ref('uploads/shopPosters/${_shopNameController.text}')
        .getDownloadURL();
    return downloadURL;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  Future<String> uploadProductImage(filePath) async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    File file = File(filePath); //need file path to upload
    var timeStamp = Timestamp.now();
    try {
      await _storage.ref('TailorSamplesImages/$timeStamp').putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
    String downloadImage =
        await _storage.ref('TailorSamplesImages/$timeStamp').getDownloadURL();
    return downloadImage;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    final _productProvider = Provider.of<ProductProvider>(context);
    tailorProvider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Center(
            child: Column(
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kOrange),
                  ),
                ),
                Text('This might take several minutes...'),
              ],
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _authData.getImage().then((image) {
                            setState(() {
                              _image = image;
                            });
                          }).then((value) {
                            _authData.isPicAvail = true;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: size.height * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: _image == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.white,
                                      size: size.width * 0.1,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Add Shop Image',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.01,
                                        ),
                                        GestureDetector(
                                          child: Icon(
                                            FontAwesomeIcons.edit,
                                            color: Colors.blue,
                                            size: size.width * 0.06,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 25.0),
                            child: TextFormField(
                              controller: _shopNameController,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Shop Name';
                                }
                                setState(() {
                                  shopName = value;
                                });
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hoverColor: kOrange,
                                // helperText: 'Add Text',
                                hintStyle: TextStyle(fontSize: 18.0),
                                prefixIcon: Icon(
                                  Icons.add_business,
                                ),
                                labelText: 'Business Name',
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
                              // maxLines: 18,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Mobile Number';
                                }
                                setState(() {
                                  mobileNo = value;
                                });
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hoverColor: kOrange,
                                // helperText: 'Add Text',
                                hintStyle: TextStyle(fontSize: 18.0),
                                // prefixText: '+92',
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                ),
                                labelText: 'Mobile Number',
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
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          //drop down menu
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 25.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: Container(
                                width: size.width,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  // color: Colors.grey[500].withOpacity(0.5),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.category_outlined,
                                        color: Colors.grey,
                                        size: 25.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: DropdownButton<String>(
                                        // focusColor: Colors.red,
                                        dropdownColor:
                                            Colors.grey.withOpacity(0.9),
                                        itemHeight: 50.0,
                                        hint: Text(
                                          'Select Shop Category',
                                          style: kBodyText.copyWith(
                                              color: Colors.grey.shade600,
                                              fontSize: 18.0),
                                        ),
                                        value: shopCategory,
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 70),
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        underline: SizedBox(),
                                        iconSize: 25.0,
                                        style: kBodyText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _shopCategoryController.text =
                                                newValue;
                                            shopCategory = newValue;
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
                          //sample add button
                          shopCategory == 'Tailor'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 25.0),
                                  child: Center(
                                    child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: kOrange,
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          _productProvider
                                              .getProductImage()
                                              .then((img) {
                                            setState(() {
                                              _sampleImage = img;
                                              // this.shopName=snapshot.data.get('shopName');
                                            });
                                            //uploadimages...
                                            uploadProductImage(
                                                    _sampleImage.path)
                                                .then((url) {
                                              //tailor provider
                                              print(
                                                  '+++++++++++++++++++++++++++++++++++++$url');
                                              tailorProvider
                                                  .addTailorSampleImage(
                                                      tailorSampleImage: url);
                                            });
                                          });
                                          // Navigator.pushNamed(
                                          //     context, MeasurementScreen.id);
                                        },
                                        child: Text(
                                          'Upload Sample Design *',
                                          style: kBodyText.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          //shop description
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 25.0),
                            child: TextFormField(
                              controller: _shopDescriptionController,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Shop Description';
                                }
                                setState(() {
                                  shopDescription = value;
                                });
                                return null;
                              },
                              maxLines: 6,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hoverColor: kOrange,
                                // helperText: 'Add Text',
                                hintStyle: TextStyle(fontSize: 18.0),
                                prefixIcon: Icon(
                                  Icons.add_business,
                                ),
                                labelText: 'Description',
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
                              controller: _addressController,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please press Navigator Button.';
                                }
                                if (_authData.shopLatitude == null) {
                                  return 'Please Enter Address.';
                                }
                                shopLocation = value;
                                return null;
                              },
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hoverColor: kOrange,
                                // helperText: 'Add Text',
                                hintStyle: TextStyle(fontSize: 18.0),
                                prefixIcon: Icon(
                                  Icons.contact_mail_outlined,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.location_searching),
                                  onPressed: () {
                                    _addressController.text =
                                        'Locating...\nPlease wait...';
                                    _authData
                                        .getCurrentAddress()
                                        .then((address) {
                                      if (address != null) {
                                        setState(() {
                                          _addressController.text =
                                              '${_authData.shopAddress}';
                                          _cityController.text =
                                              '${_authData.locality}';
                                          _countryController.text =
                                              '${_authData.countryName}';
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Couldn\'t find location... Try again')),
                                        );
                                      }
                                    });
                                  },
                                ),
                                labelText: 'Business Location',
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
                              maxLines: 5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 25.0),
                            child: TextFormField(
                              controller: _cityController,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter City Name';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hoverColor: kOrange,
                                // helperText: 'Add Text',
                                hintStyle: TextStyle(fontSize: 18.0),
                                prefixIcon: Icon(
                                  Icons.add_location_outlined,
                                ),
                                labelText: 'City',
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
                              controller: _countryController,
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Country Name';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hoverColor: kOrange,
                                // helperText: 'Add Text',
                                hintStyle: TextStyle(fontSize: 18.0),
                                prefixIcon: Icon(
                                  Icons.add_location_outlined,
                                ),
                                labelText: 'Country',
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
                          RoundedButton(
                            buttonName: 'Create',
                            onPress: () {
                              if (_authData.isPicAvail == true) {
                                print(
                                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                                if (_formKey.currentState.validate()) {
                                  print(
                                      'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
                                  setState(() {
                                    isLoading = true;
                                  });
                                  // you'd often call a server or save the information in a database.
                                  uploadFile(_authData.newImage.path)
                                      .then((url) {
                                    print(
                                        'url=================================$url');
                                    //save vendor details to firebase
                                    if (shopCategory == 'Cloth Seller') {
                                      print(
                                          '-------------------------------------------------$shopCategory');
                                      _authData.saveShopDetailsToDB(
                                        url: url,
                                        shopDescription: shopDescription,
                                        shopName: shopName,
                                        shopCategory: shopCategory,
                                        mobileNo: mobileNo,
                                        shopAddress: shopLocation,
                                      );
                                      _authData.updateBuyerDataToDB(
                                          shopCreated: true,
                                          shopCategory: shopCategory);
                                      Navigator.pushReplacementNamed(
                                          context, SellerShopScreen.id);
                                    } else {
                                      print(
                                          '+++++++++++++++++++++++++++++++++++++++++');
                                      _authData.saveTailorDetailsToDB(
                                          url: url,
                                          shopAddress: shopLocation,
                                          shopName: shopName,
                                          shopDescription: shopDescription,
                                          shopCategory: shopCategory,
                                          mobileNo: mobileNo);
                                      _authData.updateBuyerDataToDB(
                                          shopCategory: shopCategory,
                                          shopCreated: true);

                                      Navigator.pushReplacementNamed(
                                          context, SellerTailorScreen.id);
                                    }
                                  }).then((value) {
                                    setState(() {
                                      _formKey.currentState.reset();
                                      isLoading = false;
                                    });
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Failed to upload shop poster!')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Shop Poster need to be added.')),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

// child: TextFieldInput(
//   icon: FontAwesomeIcons.user,
//   hint: 'Business Name',
//   inputType: TextInputType.name,
//   inputAction: TextInputAction.next,
// ),
