import 'dart:convert';

import 'package:chat_app_get/chat/ui/chat_screen.dart';
import 'package:chat_app_get/chat/ui/search_users.dart';
import 'package:chat_app_get/models/channel_model.dart';
import 'package:chat_app_get/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../get_controllers/chat_dashboard_get_controller.dart';

class ChatDashboard extends StatelessWidget {
  ChatDashboard({Key? key}) : super(key: key);

  ChatDashboardGetController getController =
      Get.put(ChatDashboardGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => SearchUser(), transition: Transition.rightToLeft);
              },
              icon: const Icon(Icons.person_search))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Channels").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ChannelModel> channels = [];
              for (var element in snapshot.data!.docs) {
                ChannelModel channel = ChannelModel.fromJson(
                    jsonDecode(jsonEncode(element.data())));
                if (channel.users.any((element) =>
                    element.id == FirebaseAuth.instance.currentUser!.uid)) {
                  channels.add(channel);
                }
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  ChannelModel channel = channels[index];
                  return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Channels")
                          .doc(channel.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!['lastMessage'] != null) {
                            MessageModel? lastMessage = MessageModel.fromJson(
                                snapshot.data!['lastMessage']);
                            return ListTile(
                              title: Text(channel.users
                                  .firstWhere((element) =>
                                      element.id !=
                                      FirebaseAuth.instance.currentUser!.uid)
                                  .name),
                              subtitle: Text(
                                  lastMessage == null ? '' : lastMessage.text),
                              onTap: () {
                                Get.to(() => ChatScreen(channelModel: channel));
                              },
                              trailing: Text(lastMessage == null
                                  ? 'send'
                                  : "${lastMessage.createdAt.day}/${lastMessage!.createdAt.month}/${lastMessage!.createdAt.year} ${lastMessage!.createdAt.hour}:${lastMessage!.createdAt.minute}"),
                            );
                          }
                          return ListTile(
                            title: Text(channel.users
                                .firstWhere((element) =>
                                    element.id !=
                                    FirebaseAuth.instance.currentUser!.uid)
                                .name),
                            onTap: () {
                              Get.to(() => ChatScreen(channelModel: channel),
                                  transition: Transition.upToDown);
                            },
                          );
                        }
                        return ListTile(
                          title: Text(channel.users
                              .firstWhere((element) =>
                                  element.id !=
                                  FirebaseAuth.instance.currentUser!.uid)
                              .name),
                          onTap: () {
                            Get.to(() => ChatScreen(channelModel: channel),
                                transition: Transition.downToUp);
                          },
                        );
                      });
                },
                itemCount: channels.length,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
