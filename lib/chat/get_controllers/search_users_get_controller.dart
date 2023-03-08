import 'dart:convert';

import 'package:chat_app_get/chat/ui/chat_screen.dart';
import 'package:chat_app_get/models/channel_model.dart';
import 'package:chat_app_get/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../../models/message_model.dart';

class SearchUserGetController extends GetxController {
  void onUserTap(UserModel user) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      UserModel currentUser =
          UserModel.fromJson(jsonDecode(jsonEncode(value.data()!)));
      List<UserModel> usersInThisChannel = [currentUser, user];
      usersInThisChannel.sort((a, b) => a.name.compareTo(b.name));
      ChannelModel channel = ChannelModel(
        id: usersInThisChannel.map((e) => e.name).join(),
        users: [user, currentUser],
        lastMessage: MessageModel.empty(),
      );
      FirebaseFirestore.instance
          .collection('Channels')
          .doc(channel.id)
          .set(channel.toJson())
          .then((value) {
        Get.offAll(() => ChatScreen(channelModel: channel));
      });
    });
  }
}
