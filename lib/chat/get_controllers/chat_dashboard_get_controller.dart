import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class ChatDashboardGetController extends GetxController {
  void setFCMToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"fcmToken": value});
    });
  }

  @override
  void onInit() {
    setFCMToken();
    super.onInit();
  }
}
