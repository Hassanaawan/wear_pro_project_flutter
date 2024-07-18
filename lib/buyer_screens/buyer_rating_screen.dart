import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wear_pro/buyer_screens/buyer_screens.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/widgets.dart';

class BuyerRatingScreen extends StatefulWidget {
  static const id = 'Feedback_Screen';

  @override
  _BuyerRatingScreenState createState() => _BuyerRatingScreenState();
}

class _BuyerRatingScreenState extends State<BuyerRatingScreen> {
  late double _ratingValue;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kOrange,
          title: const Text(
            'Feedback',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 120.0),
                const Text(
                  'How do you find your product?',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 25),
                // implement the rating bar
                RatingBar(
                    initialRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.orange),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue = value;
                      });
                    }),
                const SizedBox(height: 25),
                // Display the rate in number
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      color: kOrange, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(
                    _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RoundedButton(
                    buttonName: 'Submit',
                    onPress: () {
                      _firestore.collection('Ratings').add({
                        'Rating': _ratingValue,
                      });
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Feedback Saved')),
                      // );

                      Navigator.pushNamed(context, HomeScreen.id);
                    }),
              ],
            ),
          ),
        ));
  }
}
