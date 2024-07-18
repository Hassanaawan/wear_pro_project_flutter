import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/providers/chat_provider.dart';

import '../constants.dart';

final _firestore = FirebaseFirestore.instance;

String email;
String messageText;
// User loggedInUser;

class BuyerChatScreen extends StatefulWidget {
  @override
  _BuyerChatScreenState createState() => _BuyerChatScreenState();
}

class _BuyerChatScreenState extends State<BuyerChatScreen> {
  final chatMsgTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    // try {
    //   final user = await _auth.currentUser!;
    //   if (user != null) {
    //     loggedInUser = user;
    //     setState(() {
    //       //username = loggedInUser.displayName!;
    //       email = loggedInUser.email!;
    //     });
    //   }
    // } catch (e) {
    //   print('current user getting error');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kOrange),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size(25, 2),
          child: Container(
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: kOrange,
            ),
            decoration: BoxDecoration(
                // color: Colors.blue,

                // borderRadius: BorderRadius.circular(20)
                ),
            constraints: BoxConstraints.expand(height: 1),
          ),
        ),
        backgroundColor: Colors.white10,
        // leading: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: CircleAvatar(backgroundImage: NetworkImage('https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png'),),
        // ),
        title: Center(
          child: Text(
            'Inbox',
            style:
                TextStyle(fontFamily: 'Poppins', fontSize: 20, color: kOrange),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_sharp),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: Icon(
                Icons.keyboard_backspace,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BuyerChatStream(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        controller: chatMsgTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Type your message here...',
                          hintStyle:
                              TextStyle(fontFamily: 'Poppins', fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    shape: CircleBorder(),
                    color: kOrange,
                    onPressed: () {
                      chatMsgTextController.clear();
                      _firestore
                          .collection('Buyers')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('messages')
                          .add({
                        'assignReceiverUid':
                            context.read<ChatProvider>().sellerUid,
                        'text': messageText,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                        'senderUid': FirebaseAuth.instance.currentUser.uid,
                        'assignReceiverName':
                            context.read<ChatProvider>().sellerName,
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                    // Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuyerChatStream extends StatelessWidget {
  final assignWorkerEmail;
  BuyerChatStream({this.assignWorkerEmail});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Buyers')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('messages')
          .orderBy('timestamp')
          // .where('senderEmail',
          //     isEqualTo: '${FirebaseAuth.instance.currentUser!.email}')
          // .where('senderEmail',
          //     isEqualTo:
          //         '${context.read<BottomNavigationProvider>().workerUid}')
          .snapshots(),
      builder: (context, snapshot) {
        print(FirebaseAuth.instance.currentUser.email);
        print(assignWorkerEmail);
        if (snapshot.hasData) {
          final messages = snapshot.data.docs.reversed;
          final receiverEmail = context.read<ChatProvider>().sellerUid;
          List<BuyerMessageBubble> messageWidgets = [];
          for (var message in messages) {
            final msgText = message.get('text');
            print(msgText);
            final msgSender = message.get('senderUid');
            final assignReceiverEmail = message.get('assignReceiverUid');
            final currentUser = FirebaseAuth.instance.currentUser.uid;
            final msgBubble = BuyerMessageBubble(
              msgText: msgText,
              msgSender: msgSender,
              user: currentUser == msgSender,
            );
            if ((msgSender == FirebaseAuth.instance.currentUser.uid &&
                    assignReceiverEmail == receiverEmail) ||
                (msgSender == receiverEmail &&
                    assignReceiverEmail ==
                        FirebaseAuth.instance.currentUser.uid)) {
              // if (assignReceiverEmail == receiverEmail ||
              //     assignReceiverEmail ==
              //         FirebaseAuth.instance.currentUser!.email) {
              print('msg text is $msgText');
              messageWidgets.add(msgBubble);
              // }
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(backgroundColor: kOrange),
          );
        }
      },
    );
  }
}

class BuyerMessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;
  BuyerMessageBubble({this.msgText, this.msgSender, this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              // msgSender,
              '',
              style: TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: user ? Radius.circular(50) : Radius.circular(0),
              bottomRight: Radius.circular(50),
              topRight: user ? Radius.circular(0) : Radius.circular(50),
            ),
            color: user ? kOrange : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.white : kOrange,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
