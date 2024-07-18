import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/buyer_screens/add_delivery_address.dart';
import 'package:wear_pro/buyer_screens/payment_summary_screen.dart';
import 'package:wear_pro/constants.dart';

import '../modules/delivery_address_model.dart';
import '../providers/check_out_provider.dart';
import '../widgets/single_delivery_item.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  static const String id = 'DeliveryDetailsScreen';
  @override
  _DeliveryDetailsScreenState createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  late DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
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
          "Delivery Details",
          style: kBodyText,
        ),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text(
                  "Add new Address",
                  style: TextStyle(color: Colors.white),
                )
              : Text("Payment Summary", style: TextStyle(color: Colors.white)),
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddDeliverAddress(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentSummaryScreen(
                        deliverAddressList: value,
                      ),
                    ),
                  );
          },
          color: kOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.location_on,
              size: 40,
            ),
          ),
          ListTile(
            title: Center(
                child: Text(
              "Deliver To",
              style: kBodyTextBlack,
            )),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Center(
                  child: Container(
                    child: Center(
                      child: Text(
                        "No Address found",
                        style: kBodyTextGrey,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: deliveryAddressProvider.getDeliveryAddressList
                      .map<Widget>((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      // addressType: 'home',
                      address:
                          " street, ${e.street},city,${e.city}, pincode ${e.pinCode}",
                      title: "${e.firstName} ${e.lastName}",
                      number: e.mobileNo,
                    );
                  }).toList(),
                ),
          GestureDetector(
            onTap: () {
              deliveryAddressProvider.deliveryAddressDataDelete();
            },
            child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Delete Address'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
