import 'package:chat_app_get/chat/ui/chat_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../models/user_model.dart';

class RegisterGetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void register() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      UserModel user = UserModel(
          id: value.user!.uid,
          name: nameController.text,
          email: emailController.text,
          imageUrl: '',
          fcmToken: '');
      FirebaseFirestore.instance
          .collection('Users')
          .doc(user.id)
          .set(user.toJson())
          .then((value) {
        Get.offAll(() => ChatDashboard());
      });
    });
  }
}
