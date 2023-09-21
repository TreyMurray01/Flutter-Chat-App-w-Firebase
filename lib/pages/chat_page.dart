import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/components/app_text_field.dart';
import 'package:to_do/components/chat_bubble.dart';
import 'package:to_do/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String recieverUserName;
  final String recieverUserId;
  const ChatPage(
      {super.key,
      required this.recieverUserName,
      required this.recieverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageInputController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageInputController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserId, messageInputController.text);
      messageInputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverUserName),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: BuildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget BuildMessageList() {
    return (StreamBuilder(
      stream: _chatService.getMessage(
          _auth.currentUser!.uid, widget.recieverUserId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    ));
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data["senderId"] == _auth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          alignment: alignment,
          child: Column(
            crossAxisAlignment: data["senderId"] == _auth.currentUser!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: data["senderId"] == _auth.currentUser!.uid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(data["senderEmail"]),
              ChatBubble(message: data["message"])
            ],
          )),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
                hint: "Mesage",
                obscureText: false,
                controller: messageInputController),
          ),
          IconButton(
              onPressed: () {
                sendMessage();
              },
              icon: const Icon(Icons.send_rounded))
        ],
      ),
    );
  }
}
