import 'package:flutter/material.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/widgets/rounded_button.dart';
import 'package:wear_pro/widgets/text_field_input.dart';

import '../payment_repository.dart';

class PaymentScreen extends StatefulWidget {
  static const id = 'PaymentScreen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController cnic = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFieldInput(
                controller: phone,
                icon: Icons.phone_android,
                inputType: TextInputType.phone,
                inputAction: TextInputAction.next,
                labelText: 'Phone Number',
              ),
              TextFieldInput(
                controller: cnic,
                icon: Icons.phone_android,
                inputType: TextInputType.phone,
                inputAction: TextInputAction.next,
                labelText: 'cnic',
              ),
              TextFieldInput(
                controller: amount,
                icon: Icons.phone_android,
                inputType: TextInputType.phone,
                inputAction: TextInputAction.next,
                labelText: 'Amount',
              ),
              TextFieldInput(
                controller: description,
                icon: Icons.phone_android,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                labelText: 'Description',
              ),
              RoundedButton(
                buttonName: 'Enter',
                onPress: () async{
                  var a = await PaymentRepository().makeTransactionThroughMWallet(
                      ppAmount: amount.text.trim(),
                      ppDescription: description.text,
                      cnic: cnic.text.trim(),
                      mobileNumber: phone.text.trim());
                  print('success$a');
                  Navigator.pushReplacementNamed(context, BuyerSuccessScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
