import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/text_field_input.dart';
import '../providers/check_out_provider.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
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
        title: Text(
          "Add Delivery Address",
          style: kBodyText,
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isLoading == false
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
                child: MaterialButton(
                  onPressed: () {
                    checkoutProvider.validator(context);
                  },
                  child: Text(
                    "Add Address",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: kOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 20.0,
            ),
            TextFieldInput(
              labelText: "First Name",
              controller: checkoutProvider.firstName,
              icon: Icons.account_circle,
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              maxWords: 25,
            ),
            TextFieldInput(
              labelText: "Last Name",
              controller: checkoutProvider.lastName,
              icon: Icons.account_circle,
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              maxWords: 25,
            ),
            TextFieldInput(
              labelText: "Mobile No",
              controller: checkoutProvider.mobileNo,
              icon: Icons.call,
              inputAction: TextInputAction.next,
              inputType: TextInputType.number,
              maxWords: 20,
            ),
            //street address
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                maxLines: 4,
                controller: checkoutProvider.street,
                // The validator receives the text that the user has entered.
                // validator: widget.validator,
                // (value) {
                // if (value == null || value.isEmpty) {
                //   return 'Please Enter Shop Name';
                // }
                // setState(() {
                //   shopName = value;
                // });
                // return null;
                // },
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  fillColor: Colors.grey[500]!.withOpacity(0.5),
                  filled: true,
                  // hoverColor: kOrange,
                  // helperText: 'Add Text',
                  hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  labelText: "Street",
                  labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  // contentPadding: EdgeInsets.zero,
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
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.left,
                maxLength: 320,
              ),
            ),
            TextFieldInput(
              labelText: "City",
              controller: checkoutProvider.city,
              icon: Icons.location_on, inputAction: TextInputAction.next,
              inputType: TextInputType.streetAddress,
              // maxWords: 25,
            ),
            TextFieldInput(
              labelText: "Pincode",
              controller: checkoutProvider.pincode,
              icon: Icons.code, inputAction: TextInputAction.done,
              inputType: TextInputType.number,
              // maxWords: 25,
            ),

            // InkWell(
            //   onTap: () {
            //    Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => CostomGoogleMap(),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     height: 47,
            //     width: double.infinity,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         checkoutProvider.setLoaction == null? Text("Set Loaction"):
            //         Text("Done!"),
            //       ],
            //     ),
            //   ),
            // ),
            // Divider(
            //   color: Colors.black,
            // ),
            // ListTile(
            //   title: Text("Address Type*"),
            // ),
            // RadioListTile(
            //   value: AddressTypes.Home,
            //   groupValue: myType,
            //   title: Text("Home"),
            //   onChanged: (AddressTypes value) {
            //     setState(() {
            //       myType = value;
            //     });
            //   },
            //   secondary: Icon(
            //     Icons.home,
            //     color: primaryColor,
            //   ),
            // ),
            // RadioListTile(
            //   value: AddressTypes.Work,
            //   groupValue: myType,
            //   title: Text("Work"),
            //   onChanged: (AddressTypes value) {
            //     setState(() {
            //       myType = value;
            //     });
            //   },
            //   secondary: Icon(
            //     Icons.work,
            //     color: primaryColor,
            //   ),
            // ),
            // RadioListTile(
            //   value: AddressTypes.Other,
            //   groupValue: myType,
            //   title: Text("Other"),
            //   onChanged: (AddressTypes value) {
            //     setState(() {
            //       myType = value;
            //     });
            //   },
            //   secondary: Icon(
            //     Icons.devices_other,
            //     color: primaryColor,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
