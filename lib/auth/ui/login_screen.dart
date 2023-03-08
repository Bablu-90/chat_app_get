import 'dart:io';

import 'package:chat_app_get/auth/ui/register_screen.dart';
import 'package:chat_app_get/chat/ui/user_image_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../get_controllers/login_get_controller.dart';

class LoginScreen extends StatefulWidget {
  File userImageFile = File('image');

  LoginScreen({Key? key, required this.userImageFile}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginGetController loginGetController = Get.put(LoginGetController());

  void pickedImage(File image) {
    final userImageFile = image;

    if (userImageFile == null && loginGetController.login != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image..'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserImagePicker(),
            TextFormField(
              controller: loginGetController.emailController,
              decoration: InputDecoration(
                  hintText: 'Email', filled: true, fillColor: Colors.white70),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              controller: loginGetController.passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                hintText: 'Password',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Get.offAll(() => RegisterScreen(),
                        transition: Transition.downToUp);
                  },
                  child: Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () {
                loginGetController.login();
              },
              label: Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}

// login = user2@gmail.com
// passwrd = 112233
