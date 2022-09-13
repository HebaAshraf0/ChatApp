import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User? signedInUser;


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? messageText;

  void initState()
  {
    super.initState();
    GetCurrentUser();
  }
  void GetCurrentUser()
  {
    try{
      final user = _auth.currentUser;
      if(user!=null){
        signedInUser=user;
        print(signedInUser?.email);
      }
    }
    catch(e){
      print(e);
    }

    }
    // void GetMessages() async
    // {
    //   final messages = await _firestore.collection('messages').get();
    //   for(var message in messages.docs)
    //     {
    //       print(message.data());
    //     }
    // }
  void messagesStreams() async
  {
    await for (var snapshot in _firestore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());

      }

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset('images/chat.png',height: 25,),
            SizedBox(width:10 ),
            Text(
              "Let's chat...!"
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
             //messagesStreams();
              _auth.signOut();
              Navigator.pop(context);
              //logout function
            },
            icon:Icon(Icons.close),

          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context , snapshot) {
                List<MessageLine> messageWidgets = [];

                final messages = snapshot.data!.docs;
                for(var message in messages)
                  {
                    final messageText = message.get('text');
                    final messageSender = message.get('sender');
                    final currentUser = signedInUser?.email;


                    final messageWidget =MessageLine(
                        sender:messageSender,
                        text:messageText,
                        isMe: currentUser==messageSender,
                    );
                    messageWidgets.add(messageWidget);
                  }


                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    children: messageWidgets
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TextField(
                    controller: messageTextController,
                    onChanged: (value){
                      messageText= value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintText: "Type your message here...",
                      border: InputBorder.none,
                    ),
                  ),
                  ),
                  TextButton(
                      onPressed: ()  {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': signedInUser?.email,
                          'time' : FieldValue.serverTimestamp(),
                        });

                  },
                      child: Text(
                        "Send",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),

                      ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
class MessageLine extends StatelessWidget {
  const MessageLine({required this.text,required this.sender,required this.isMe, Key? key}) : super(key: key);
  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',
            style: TextStyle(fontSize: 12,color: Colors.yellow[900]),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color:isMe ? Colors.blue : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text('$text',
                style: TextStyle(fontSize: 15,
                  color:isMe? Colors.white : Colors.black45,
                ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
