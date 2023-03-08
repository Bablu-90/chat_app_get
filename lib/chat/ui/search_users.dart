import 'dart:convert';

import 'package:chat_app_get/chat/get_controllers/search_users_get_controller.dart';
import 'package:chat_app_get/chat/ui/user_image_picker.dart';
import 'package:chat_app_get/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchUser extends StatelessWidget {
  SearchUser({Key? key}) : super(key: key);

  SearchUserGetController searchUserGetController =
      Get.put(SearchUserGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Users'),
      ),
      body: Column(
        children: [
          UserImagePicker(),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserModel> users = snapshot.data!.docs
                        .map((e) => UserModel.fromJson(
                            jsonDecode(jsonEncode(e.data()))))
                        .toList();
                    users.removeWhere((element) =>
                        element.id == FirebaseAuth.instance.currentUser!.uid);
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        UserModel user = users[index];
                        return ListTile(
                          title: Text(user.name),
                          onTap: () {
                            //onUserTap
                            searchUserGetController.onUserTap(user);
                          },
                        );
                      },
                      itemCount: users.length,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
