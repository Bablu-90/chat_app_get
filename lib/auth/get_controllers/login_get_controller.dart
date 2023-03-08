import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../chat/ui/chat_dashboard.dart';

class LoginGetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) => Get.offAll(() => ChatDashboard()));
  }

  void checkIfAlreadyLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAll(() => ChatDashboard());
    }
  }

  @override
  void onInit() {
    Future.delayed(Duration(milliseconds: 200), () {
      checkIfAlreadyLoggedIn();
    });
    super.onInit();
  }
}
