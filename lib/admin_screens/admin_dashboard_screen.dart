import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wear_pro/admin_screens/admin_login_screen.dart';
import 'package:wear_pro/admin_screens/approval_list_screen.dart';
import 'package:wear_pro/admin_screens/approve_decline_product_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/widgets/widgets.dart';

import '../buyer_screens/login_screen.dart';
import 'admin_home_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  static const String id = 'AdminDashboardScreen';
  const AdminDashboardScreen({required Key key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final bool showCheckboxColumn = true;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      drawer: Drawer(
        child: Material(
          color: kOrange,
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/image_6.jpeg'),
                          ),
                        ),
                      ),
                      Text(
                        'Ammar Shah',
                        style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        style: kBodyText.copyWith(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                BuildMenuItem(
                  icon: Icons.account_circle_outlined,
                  text: 'Dashboard',
                  onPressed: () =>
                      Navigator.pushNamed(context, AdminDashboardScreen.id),
                ),
                BuildMenuItem(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Update Banner',
                  onPressed: () =>
                      Navigator.pushNamed(context, AdminHomeScreen.id),
                ),
                BuildMenuItem(
                  icon: FontAwesomeIcons.shoppingBag,
                  text: 'Product Approval',
                  onPressed: () => Navigator.pushNamed(
                      context, ApproveDeclineProductScreen.id),
                ),
                BuildMenuItem(
                  onPressed: () {
                    Navigator.pushNamed(context, ApprovalListScreen.id);
                  },
                  icon: Icons.error,
                  text: 'About',
                ),
                SizedBox(height: 35),
                Divider(color: Colors.white, thickness: 1.4),
                SizedBox(
                  height: 35.0,
                ),
                BuildMenuItem(
                  icon: Icons.help,
                  text: 'Help',
                ),
                BuildMenuItem(
                  icon: Icons.logout,
                  text: 'Log Out',
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('email');
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: kOrange,
        title: Text(
          'Dashboard',
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Order History',
              style: kBodyText,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Color(0xff232d37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      showAvg ? avgData() : mainData(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                height: 34,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white60)),
                    child: Text(
                      'Avg',
                      style: TextStyle(
                          fontSize: 14,
                          color: showAvg
                              ? Colors.white.withOpacity(0.5)
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Text('Order History',style: kBodyText,),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sellers Details',
              style: kBodyText,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable2(
                  // headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  // sortAscending: true,
                  columnSpacing: 12,
                  // decoration: BoxDecoration(color: Colors.grey),
                  horizontalMargin: 10,
                  minWidth: 600,
                  // checkboxHorizontalMargin: 12.0,
                  showCheckboxColumn: true,
                  // columnSpacing: 40.0,
                  // headingRowColor: Material.c,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Store Name',
                        style: kBodyText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Sales',
                        style: kBodyText.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ratings',
                        style: kBodyText.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Mobile No.',
                        style: kBodyText.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'View Details',
                        style: kBodyText.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                    DataRow(
                        // onSelectChanged: (bool selected) {
                        //   if (selected) {
                        //     setState(() {
                        //     });//'row-selected: ${itemRow.index}'
                        //   }
                        // },
                        cells: [
                          DataCell(
                            Text(
                              'Bilal Mart',
                              style: TextStyle(color: Colors.white),
                            ),
                            showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              'Rs. 20,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            // showEditIcon: true,
                            // placeholder: true,
                          ),
                          DataCell(
                            Text(
                              '3.5',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Text(
                              '+923029713906',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataCell(
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ]),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      // titlesData: FlTitlesData(
      //   show: true,
      //   rightTitles: AxisTitles(showTitles: false),
      //   topTitles: AxisTitles(showTitles: false),
      //   bottomTitles: AxisTitles(
      //     showTitles: true,
      //     reservedSize: 22,
      //     interval: 1,
      //     getTextStyles: (context, value) => const TextStyle(
      //         color: Color(0xff68737d),
      //         fontWeight: FontWeight.bold,
      //         fontSize: 16),
      //     getTitles: (value) {
      //       switch (value.toInt()) {
      //         case 2:
      //           return 'FEB';
      //         case 4:
      //           return 'APR';
      //         case 6:
      //           return 'JUN';
      //         case 8:
      //           return 'AUG';
      //         case 10:
      //           return 'OCT';
      //         case 12:
      //           return 'DEC';
      //       }
      //       return '';
      //     },
      //     margin: 8,
      //   ),
      //   leftTitles: AxisTitles(
      //     showTitles: true,
      //     interval: 1,
      //     getTextStyles: (context, value) => const TextStyle(
      //       color: Color(0xff67727d),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //     getTitles: (value) {
      //       switch (value.toInt()) {
      //         case 1:
      //           return '10k';
      //         case 3:
      //           return '30k';
      //         case 5:
      //           return '50k';
      //         case 7:
      //           return '70k';
      //       }
      //       return '';
      //     },
      //     reservedSize: 32,
      //     margin: 12,
      //   ),
      // ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 13,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(2, 2.5),
            FlSpot(4, 4),
            FlSpot(5, 6.0),
            FlSpot(6, 3.5),
            FlSpot(8, 4.0),
            FlSpot(9, 3.5),
            FlSpot(10, 6.5),
            FlSpot(11, 6.5),
            FlSpot(12, 5.6),
            FlSpot(13, 7.4),
          ],
          isCurved: true,

          // color: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            // colors:
            //     gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      // titlesData: FlTitlesData(
      //   show: true,
      //   bottomTitles: AxisTitles(
      //     showTitles: true,
      //     reservedSize: 22,
      //     getTextStyles: (context, value) => const TextStyle(
      //         color: Color(0xff68737d),
      //         fontWeight: FontWeight.bold,
      //         fontSize: 16),
      //     getTitles: (value) {
      //       switch (value.toInt()) {
      //         case 2:
      //           return 'FEB';
      //         case 4:
      //           return 'APR';
      //         case 6:
      //           return 'JUN';
      //         case 8:
      //           return 'AUG';
      //         case 10:
      //           return 'OCT';
      //         case 12:
      //           return 'DEC';
      //       }
      //       return '';
      //     },
      //     margin: 8,
      //     interval: 1,
      //   ),
      //   leftTitles: AxisTitles(
      //     showTitles: true,
      //     getTextStyles: (context, value) => const TextStyle(
      //       color: Color(0xff67727d),
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //     ),
      //     getTitles: (value) {
      //       switch (value.toInt()) {
      //         case 1:
      //           return '10k';
      //         case 3:
      //           return '30k';
      //         case 5:
      //           return '50k';
      //         case 7:
      //           return '70k';
      //       }
      //       return '';
      //     },
      //     reservedSize: 32,
      //     interval: 1,
      //     margin: 12,
      //   ),
      //   topTitles: AxisTitles(showTitles: false),
      //   rightTitles: AxisTitles(showTitles: false),
      // ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 13,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.48),
            FlSpot(2.6, 3.48),
            FlSpot(4.9, 3.48),
            FlSpot(6.8, 3.48),
            FlSpot(8, 3.48),
            FlSpot(9.5, 3.48),
            FlSpot(11, 3.48),
            FlSpot(13, 3.48),
          ],
          isCurved: true,
          // color: [
          //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //       .lerp(0.2),
          //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //       .lerp(0.2),
          // ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            //  colors: [
            //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
            //       .lerp(0.2)
            //       .withOpacity(0.1),
            //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
            //       .lerp(0.2)
            //       .withOpacity(0.1),
            // ],
          ),
        ),
      ],
    );
  }
}
