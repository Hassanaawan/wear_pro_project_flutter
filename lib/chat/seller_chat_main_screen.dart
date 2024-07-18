import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/chat/seller_chat_screen.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/chat_provider.dart';

class SellerMainChatScreen extends StatefulWidget {
  @override
  _SellerMainChatScreenState createState() => _SellerMainChatScreenState();
}

class _SellerMainChatScreenState extends State<SellerMainChatScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Buyers').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kOrange,
        title: Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collectionGroup('messages')
                    // .collection('Buyers')
                    // .doc(FirebaseAuth.instance.currentUser.uid)
                    // .collection("messages")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  // if(snapshot.hasData){
                  //   // Map<String, dynamic> map={
                  //   //   'assignReceiverUid':snapshot.data.docs.first.get('assignReceiverUid'),
                  //   //   'senderUid':snapshot.data.docs.first.get('senderUid'),
                  //   //   'text':snapshot.data.docs.first.get('text'),
                  //   //   'timestamp':snapshot.data.docs.first.get('timestamp'),
                  //   // };
                  //   // map.addAll({'newEntries':'ss'});
                  //   // snapshot.data.docs.forEach((element) {
                  //   //   list.add(element.get('assignReceiverUid'));
                  //   // });
                  // }
                  //snapshot.data.docs.forEach((element) {print(element.id);});
                  final list = [];
                  bool check = true;
                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      if (list.contains(data['assignReceiverUid'])) {
                        check = true;
                      } else {
                        if (data['assignReceiverUid'] ==
                                FirebaseAuth.instance.currentUser.uid &&
                            data['senderUid'] !=
                                FirebaseAuth.instance.currentUser.uid) {
                          list.add(data['assignReceiverUid']);
                          check = false;
                        } else {
                          check = true;
                        }
                      }
                      return check == false
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Card(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           WorkerRequestDetailPage()),
                                          // );
                                        },
                                        child: Row(
                                          children: [
                                            ClipOval(
                                              child: Icon(
                                                Icons.person,
                                                size: 70,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${data['assignReceiverName']}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Last Message: ${document.get('text')}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            // MediaQuery.of(context).size.width /
                                            10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<ChatProvider>()
                                              .setbuyerUidandEmail(
                                                  document.get('senderUid'));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SellerChatScreen()));
                                        },
                                        icon: Icon(
                                          Icons.chat,
                                          size: 35,
                                          color: kOrange,
                                        ),
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     showDialog(
                                      //       context: context,
                                      //       builder: (BuildContext context) {
                                      //         return AlertDialog(
                                      //           title:
                                      //               Text("Request Completed?"),
                                      //           content: Text(
                                      //               "Are you sure to complete (Close) this request?"),
                                      //           actions: [
                                      //             TextButton(
                                      //               style: TextButton.styleFrom(
                                      //                 primary: Colors.red,
                                      //                 backgroundColor:
                                      //                     Colors.red,
                                      //               ),
                                      //               child: Text(
                                      //                 "Yes Sure",
                                      //                 style: TextStyle(
                                      //                     color: Colors.white),
                                      //               ),
                                      //               onPressed: () {
                                      //                 // await FirebaseFirestore
                                      //                 //     .instance
                                      //                 //     .collection("User")
                                      //                 //     .doc(
                                      //                 //         "${data["userUid"]}")
                                      //                 //     .collection(
                                      //                 //         "Requests")
                                      //                 //     .doc(FirebaseAuth
                                      //                 //         .instance
                                      //                 //         .currentUser
                                      //                 //         .uid)
                                      //                 //     .update({
                                      //                 //   "Status": "Completed"
                                      //                 // }).then((value) => {
                                      //                 //           Navigator.pop(
                                      //                 //               context),
                                      //                 //         });
                                      //               },
                                      //             ),
                                      //           ],
                                      //         );
                                      //       },
                                      //     );
                                      //   },
                                      //   style: ElevatedButton.styleFrom(
                                      //     primary: Colors.green,
                                      //   ),
                                      //   child: Text("Completed"),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container();
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
