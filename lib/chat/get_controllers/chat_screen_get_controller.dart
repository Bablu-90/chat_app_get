import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../FCM/fcm_controller/fcm_controller.dart';
import '../../models/channel_model.dart';
import '../../models/message_model.dart';

class ChatScreenGetController extends GetxController {
  final ChannelModel channelModel;

  ChatScreenGetController(this.channelModel);

  final TextEditingController messageController = TextEditingController();

  void sendMessage(MessageModel messageModel) {
    FirebaseFirestore.instance
        .collection("Channels")
        .doc(channelModel.id)
        .collection("Messages")
        .doc(messageModel.id)
        .set(messageModel.toJson())
        .then((value) {
      FirebaseFirestore.instance
          .collection("Channels")
          .doc(channelModel.id)
          .update({"lastMessage": messageModel.toJson()}).then((fcmController) {
        FCMController fcmController = Get.put(FCMController());
        fcmController.getAccessToken();
      });
      FirebaseFirestore.instance
          .collection("Users")
          .doc("09rHI6yo0bNN05lDuWkFr0D2BTy1")
          .get()
          .then((value) {
        String fcmToken = value['test'];
        FCMController fcmController = Get.put(FCMController());
        fcmController.sendNotification(
          fcmToken,
          'New Message Received',
          messageModel.text,
        );
      });
    });

    // get fcm token of receiver => send notification to receiver
  }
}
