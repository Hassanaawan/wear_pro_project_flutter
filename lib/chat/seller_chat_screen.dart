import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wear_pro/constants.dart';
import 'package:wear_pro/providers/chat_provider.dart';

final _firestore = FirebaseFirestore.instance;
String messageText;

class SellerChatScreen extends StatefulWidget {
  @override
  _SellerChatScreenState createState() => _SellerChatScreenState();
}

class _SellerChatScreenState extends State<SellerChatScreen> {
  var chatMsgTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    //uIdGet().whenComplete(() => setState(() {}));
    // setState(() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    // try {
    //   // QuerySnapshot querySnapshot = await _firestore
    //   //     .collection('User')
    //   //     .where('Email', isEqualTo: '${widget.assignUserEmail}')
    //   //     .get();
    //   // assignUserId = querySnapshot.docs.first.id;
    //   // print("aaa//////////////////////${querySnapshot.docs.first.id}");
    //   // final user = await _auth.currentUser!;
    //   // if (user != null) {
    //   //   loggedInUser = user;
    //   //   setState(() {
    //   //     email = loggedInUser.email!;
    //   //     print('///////////////////////////$email');
    //   //   });
    //   }

    //   print("aaa//////////////////////");
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
          SellerChatStream(),
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
                          print(value);
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
                          .doc(context.read<ChatProvider>().buyerUid)
                          .collection('messages')
                          .add({
                        'assignReceiverUid':
                            context.read<ChatProvider>().buyerUid,
                        'text': messageText,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                        'senderUid': FirebaseAuth.instance.currentUser.uid,
                        'assignReceiverName':
                            context.read<ChatProvider>().buyerName,
                      }).whenComplete(() => print(
                              'added in firebase from worker chat screen.'));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SellerChatStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Buyers')
          .doc(context.read<ChatProvider>().buyerUid)
          .collection('messages')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: kOrange),
          );
        }
        print('messages bubbles');
        snapshot.data.docs.map((e) {
          print(e.get('text'));
        });
        final messages = snapshot.data.docs.reversed;
        List<SellerMessageBubble> messageWidgets = [];
        final receiverEmail = context.read<ChatProvider>().buyerUid;
        for (var message in messages) {
          final msgText = message.get('text');
          final msgSender = message.get('senderUid');
          print('text message: $msgText');
          final assignReceiverEmail = message.get('assignReceiverUid');
          final currentUser = FirebaseAuth.instance.currentUser.uid;
          final msgBubble = SellerMessageBubble(
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
            messageWidgets.add(msgBubble);
            // }
          }
          // messageWidgets.add(msgBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            children: messageWidgets,
          ),
        );
      },
    );
    // : Center(
    //     child: CircularProgressIndicator(
    //       color: Colors.lightGreen,
    //     ),
    //   );
  }
}

class SellerMessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;
  SellerMessageBubble({this.msgText, this.msgSender, this.user});

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
