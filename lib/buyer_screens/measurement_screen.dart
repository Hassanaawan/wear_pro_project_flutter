import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wear_pro/buyer_screens/tailer_detail_success.dart';
import '../constants.dart';

class MeasurementScreen extends StatefulWidget {
  static const String id = 'MeasurementScreen';

  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  PageController pageController = PageController(initialPage: 0);
  TextEditingController step1Controller = TextEditingController();
  TextEditingController step2Controller = TextEditingController();
  TextEditingController step3Controller = TextEditingController();
  TextEditingController step4Controller = TextEditingController();
  TextEditingController step5Controller = TextEditingController();
  TextEditingController step6Controller = TextEditingController();
  TextEditingController step7Controller = TextEditingController();
  TextEditingController step8Controller = TextEditingController();
  TextEditingController step9Controller = TextEditingController();
  int step1 = 0,
      step2 = 0,
      step3 = 0,
      step4 = 0,
      step5 = 0,
      step6 = 0,
      step7 = 0,
      step8 = 0,
      step9 = 0;
  String title = 'Back Shoulder Width';
  bool _step1Validate = true;
  bool _step2Validate = true;
  bool _step3Validate = true;
  bool _step4Validate = true;
  bool _step5Validate = true;
  bool _step6Validate = true;
  bool _step7Validate = true;
  bool _step8Validate = true;
  bool _step9Validate = true;

  double step1Inches = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    step1Controller.dispose();
    step2Controller.dispose();
    step3Controller.dispose();
    step4Controller.dispose();
    step5Controller.dispose();
    step6Controller.dispose();
    step7Controller.dispose();
    step8Controller.dispose();
    step9Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: kOrange),
        ),
        centerTitle: false,
        bottomOpacity: 0,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: kOrange,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ///step1
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step1 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 01',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step1 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/back_shoulder_width.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step2
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step2 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 02',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step2 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/sleeves.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step3
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step3 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 03',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step3 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/trouser_waist.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step4
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step4 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 04',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step4 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/full_shoulder_width.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step5
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step5 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 05',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step5 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/trouser\'s_length.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step6
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step6 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 06',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step6 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/full_chest.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step7
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step7 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 07',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step7 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/waist.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step8
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step8 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 08',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step8 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/hips_seat.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///step9
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: step9 == 1
                          ? kOrange.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Step 09',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Badge(
                          showBadge: true,
                          alignment: Alignment.bottomLeft,
                          position: BadgePosition.bottomEnd(),
                          badgeColor: step9 == 1 ? Colors.green : Colors.grey,
                          badgeContent: const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/neck.jpg'),
                            radius: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              allowImplicitScrolling: false,
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: false,
              controller: pageController,
              children: [
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/back_shoulder_width.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step1Controller.text.isEmpty) {
                                    step1Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step1Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step1Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step1Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step1Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step1Controller.text.isEmpty) {
                                    step1Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step1Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step1Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step1Controller.text.isEmpty
                            ? setState(() {
                                _step1Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step1Controller.text.isEmpty
                                    ? _step1Validate = false
                                    : _step1Validate = true;
                                step1 = 1;
                                print('set state');
                                title = 'Sleeves';
                              });
                        _step1Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/sleeves.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step2Controller.text.isEmpty) {
                                    step2Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step2Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step2Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step2Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step2Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step2Controller.text.isEmpty) {
                                    step2Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step2Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step2Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step2Controller.text.isEmpty
                            ? setState(() {
                                _step2Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step2Controller.text.isEmpty
                                    ? _step2Validate = false
                                    : _step2Validate = true;
                                step2 = 1;
                                print('set state');
                                title = 'Trouser Waist';
                              });
                        _step2Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/trouser_waist.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step3Controller.text.isEmpty) {
                                    step3Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step3Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step3Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step3Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step3Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step3Controller.text.isEmpty) {
                                    step3Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step3Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step3Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step3Controller.text.isEmpty
                            ? setState(() {
                                _step3Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step3Controller.text.isEmpty
                                    ? _step3Validate = false
                                    : _step3Validate = true;
                                step3 = 1;
                                print('set state');
                                title = 'Full Shoulder Width';
                              });
                        _step3Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/full_shoulder_width.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step4Controller.text.isEmpty) {
                                    step4Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step4Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step4Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step4Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorText: _step4Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step4Controller.text.isEmpty) {
                                    step4Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step4Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step4Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step4Controller.text.isEmpty
                            ? setState(() {
                                _step4Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step4Controller.text.isEmpty
                                    ? _step4Validate = false
                                    : _step4Validate = true;
                                step4 = 1;
                                print('set state');
                                title = 'Trouser\'s Length';
                              });
                        _step4Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/trouser\'s_length.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step5Controller.text.isEmpty) {
                                    step5Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step5Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step5Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step5Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step5Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step5Controller.text.isEmpty) {
                                    step5Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step5Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step5Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step5Controller.text.isEmpty
                            ? setState(() {
                                _step5Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step5Controller.text.isEmpty
                                    ? _step5Validate = false
                                    : _step5Validate = true;
                                step5 = 1;
                                print('set state');
                                title = 'Full Chest';
                              });
                        _step5Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //step6 controller
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/full_chest.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step6Controller.text.isEmpty) {
                                    step6Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step6Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step6Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step6Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step6Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step6Controller.text.isEmpty) {
                                    step6Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step6Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step6Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step6Controller.text.isEmpty
                            ? setState(() {
                                _step6Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step6Controller.text.isEmpty
                                    ? _step6Validate = false
                                    : _step6Validate = true;
                                step6 = 1;
                                print('set state');
                                title = 'Waist';
                              });
                        _step6Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //step7 controller
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/waist.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step7Controller.text.isEmpty) {
                                    step7Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step7Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step7Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step7Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step7Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step7Controller.text.isEmpty) {
                                    step7Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step7Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step7Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step7Controller.text.isEmpty
                            ? setState(() {
                                _step7Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step7Controller.text.isEmpty
                                    ? _step7Validate = false
                                    : _step7Validate = true;
                                step7 = 1;
                                print('set state');
                                title = 'Hips Seat';
                              });
                        _step7Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //step8 controller
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/hips_seat.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step8Controller.text.isEmpty) {
                                    step8Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step8Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step8Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step8Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step8Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step8Controller.text.isEmpty) {
                                    step8Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step8Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step8Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step8Controller.text.isEmpty
                            ? setState(() {
                                _step8Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step8Controller.text.isEmpty
                                    ? _step8Validate = false
                                    : _step8Validate = true;
                                step8 = 1;
                                print('set state');
                                title = 'Neck';
                              });
                        _step8Validate
                            ? pageController.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.ease,
                              )
                            : print('goto next page ');
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //step9 controller
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 440,
                        width: 370,
                        child: Image.asset(
                          'assets/images/neck.jpg',
                          height: 440,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  if (step9Controller.text.isEmpty) {
                                    step9Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step9Controller.text);
                                  if (b > 0) {
                                    b = b - 1;
                                  }
                                  setState(() {
                                    step9Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minus,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              backgroundColor: kOrange,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border:
                                          Border.all(color: kOrange, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextField(
                                      controller: step9Controller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: _step9Validate
                                            ? null
                                            : 'Value Can\'t Be Empty',
                                        border: InputBorder.none,
                                        hintText: 'Enter in Inches',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: kOrange,
                              child: IconButton(
                                onPressed: () {
                                  if (step9Controller.text.isEmpty) {
                                    step9Controller.text =
                                        step1Inches.toString();
                                  }
                                  double b = double.parse(step9Controller.text);
                                  b = b + 1;
                                  setState(() {
                                    step9Controller.text = b.toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        step9Controller.text.isEmpty
                            ? setState(() {
                                _step9Validate = false;
                                print('empty controller');
                              })
                            : setState(() {
                                step9Controller.text.isEmpty
                                    ? _step9Validate = false
                                    : _step9Validate = true;
                                step9 = 1;
                                print('set state');
                              });
                        FirebaseFirestore.instance
                            .collection('Buyers')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('ClothDetails')
                            .add({
                          'back_shoulder_width': step1Controller.text.trim(),
                          'sleeves': step2Controller.text.trim(),
                          'trouser_waist': step3Controller.text.trim(),
                          'full_shoulder_width': step4Controller.text.trim(),
                          'trouser\'s_length': step5Controller.text.trim(),
                          'full_chest': step6Controller.text.trim(),
                          'waist': step7Controller.text.trim(),
                          'hips_seat': step8Controller.text.trim(),
                          'neck': step9Controller.text.trim(),
                        }).whenComplete(() {
                          _step9Validate
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TailorDetailsSuccess()))
                              : print('goto next page ');
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        color: kOrange,
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
