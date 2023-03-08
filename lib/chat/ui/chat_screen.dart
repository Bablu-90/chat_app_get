import 'dart:convert';

import 'package:chat_app_get/chat/get_controllers/chat_screen_get_controller.dart';
import 'package:chat_app_get/models/channel_model.dart';
import 'package:chat_app_get/models/message_model.dart';
import 'package:chat_app_get/models/user_model.dart';
import 'package:chat_app_get/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final ChannelModel channelModel;

  ChatScreen({Key? key, required this.channelModel}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    ChatScreenGetController chatScreenGetController =
        Get.put(ChatScreenGetController(widget.channelModel));
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(

          title: const Text(
            'Chat',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,

        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Channels")
                .doc(widget.channelModel.id)
                .collection("Messages")
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {
                List<MessageModel> allMessages = snapshot.data!.docs
                    .map((e) =>
                    MessageModel.fromJson(jsonDecode(jsonEncode(e.data()))))
                    .toList();
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (context, index) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        MessageModel message = allMessages[index];
                        return MessageBubble(
                          message: message,
                          username: 'username',
                          isMe: false,
                        );
                      }
                      return Container();
                    },
                    itemCount: allMessages.length);
              }
              return const Center(
                child: CircularProgressIndicator(color: Colors.redAccent),
              );
            }),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                autofocus: true,
                autocorrect: true,
                controller: chatScreenGetController.messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get()
                    .then((value) {
                  UserModel currentUser =
                      UserModel.fromJson(jsonDecode(jsonEncode(value.data())));
                  MessageModel messageModel = MessageModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      text: chatScreenGetController.messageController.text,
                      sender: currentUser,
                      createdAt: DateTime.now(),
                      seenBy: [currentUser], timestamp: DateTime.now().microsecondsSinceEpoch);
                  chatScreenGetController.sendMessage(messageModel);
                  chatScreenGetController.messageController.clear();
                });
              },
              icon: const Icon(Icons.send, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
