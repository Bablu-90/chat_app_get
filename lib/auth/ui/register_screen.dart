import 'dart:io';

import 'package:chat_app_get/auth/ui/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../get_controllers/register_get_controller.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterGetController registerGetController =
      Get.put(RegisterGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();*/
            TextFormField(
              controller: registerGetController.emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextFormField(
              controller: registerGetController.passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            TextFormField(
              controller: registerGetController.nameController,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Get.offAll(
                        () => LoginScreen(
                              userImageFile: File('pickedImage'),
                            ),
                        transition: Transition.rightToLeft);
                  },
                  child: Text("Login"),
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
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () {
                registerGetController.register();
              },
              label: Text("Register"),
            ),
          ),
        ],
      ),
    );
  }
}
