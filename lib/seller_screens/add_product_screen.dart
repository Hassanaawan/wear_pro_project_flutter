import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/product_provider.dart';
import 'package:wear_pro/seller_screens/seller_shop_screen.dart';
import 'package:wear_pro/seller_screens/success_screen.dart';
import 'package:wear_pro/widgets/widgets.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = 'AddProductScreen';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<String> options = ['Men', 'Women', 'Kids', 'Home Made Clothes'];
  String productCategory, productName, productDescription, productPrice;
  final _formKey = GlobalKey<FormState>();
  File _image;

  Future<String> uploadProductImage(filePath) async {
    FirebaseStorage _storage = FirebaseStorage.instance;

    File file = File(filePath); //need file path to upload

    var timeStamp = Timestamp
        .now();
    try {
      await _storage.ref('productImages/$productName').putFile(
          file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
    String downloadURL = await _storage
        .ref('productImages/$productName')
        .getDownloadURL();
    return downloadURL;

    // Within your widgets:
    // Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Add Product',
            style: TextStyle(color: Colors.white),
          ),
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
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _productProvider.getProductImage().then((image) {
                        setState(() {
                          _image = image;
                        });
                      });
                    },
                    child: Container(
                      width: size.width*0.5,
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: _image == null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                            size: size.width * 0.05,
                          ),
                          Text(
                            'Add Image',
                            style: kBodyText,
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
                    height: size.height * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldInput(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Product Name!';
                          }
                          setState(() {
                            productName = value;
                          });
                          return null;
                        },
                        icon: Icons.description_outlined,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        labelText: 'Product Name',
                        maxWords: 35,
                      ),
                      // TextFieldInput(
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please Enter Product Description!';
                      //     }
                      //     setState(() {
                      //       productDescription = value;
                      //     });
                      //     return null;
                      //   },
                      //   icon: Icons.description_outlined,
                      //   labelText: 'Description',
                      //   inputType: TextInputType.text,
                      //   inputAction: TextInputAction.next,
                      //   maxLines: 5,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 25.0),
                        child: TextFormField(
                          maxLines: 5,
                          // controller: widget.controller,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Product Description';
                            }
                            setState(() {
                              productDescription = value;
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
                            hintStyle:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                            prefixIcon: Icon(
                              Icons.description_outlined,
                              color: Colors.white,
                            ),
                            labelText: 'Description',
                            labelStyle:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                            // contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              // gapPadding: 12.0,
                              borderSide: BorderSide(
                                width: 2,
                                color: kOrange,
                              ),
                            ),
                            focusColor: Theme
                                .of(context)
                                .primaryColor,
                          ),
                          keyboardType: TextInputType.text,
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
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              color: Colors.grey[500].withOpacity(0.5),
                              borderRadius: BorderRadiusDirectional.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.category_outlined,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: DropdownButton<String>(
                                    // focusColor: Colors.red,

                                    dropdownColor: Colors.grey.withOpacity(0.9),
                                    itemHeight: 60.0,
                                    hint: Text(
                                      'Select Category',
                                      style: kBodyText.copyWith(
                                          color: Colors.white),
                                    ),
                                    value: productCategory,
                                    icon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    underline: SizedBox(),
                                    iconSize: 25.0,
                                    style: kBodyText.copyWith(
                                        fontWeight: FontWeight.bold),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        productCategory = newValue;
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


                      //price
                      TextFieldInput(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Product Price!';
                          }
                          setState(() {
                            productPrice = value;
                          });
                          return null;
                        },
                        icon: FontAwesomeIcons.coins,
                        labelText: 'Price',
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.done,
                      ),
                      RoundedButton(
                          buttonName: 'Add',
                          onPress: () {
                            if (_formKey.currentState.validate()) {
                              if (_image != null) {
                                EasyLoading.show(status: 'Saving...');
                                uploadProductImage(_image.path).then((url) {
                                  EasyLoading.dismiss();
                                  if (url != null) {
                                    _productProvider.saveProductDetailsToFB(
                                        productURL: url,
                                        pName: productName,
                                        pCategory: productCategory,
                                        pDescription: productDescription,
                                        pPrice: productPrice).then((value) =>
                                        Navigator.pushNamed(
                                            context, SuccessScreen.id)
                                            .then((value) {
                                          _formKey.currentState.reset();
                                          _image=null;
                                        }));
                                  } else {
                                    //upload failed!
                                    _productProvider.alertDialog(
                                        context: context,
                                        title: 'IMAGE UPLOAD',
                                        content: 'Failed to upload product image!');
                                  }
                                });
                              } else {
                                _productProvider.alertDialog(
                                    context: context,
                                    title: 'PRODUCT IMAGE',
                                    content: 'Product Image not selected!');
                              }
                            }
                          }
                        // Navigator.pushNamed(context, SuccessScreen.id),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
