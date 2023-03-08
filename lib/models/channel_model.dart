

import 'package:chat_app_get/models/user_model.dart';

import 'message_model.dart';

class ChannelModel {
  String id;
  List<UserModel> users;
  MessageModel lastMessage = MessageModel.empty();

  ChannelModel(
      {required this.id, required this.users, required this.lastMessage});

//from Json
  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      users: (json['users'] as List).map((e) => UserModel.fromJson(e)).toList(),
      lastMessage: MessageModel.fromJson(json['lastMessage']),
    );
  }

//to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users': users.map((e) => e.toJson()).toList(),
      'lastMessage': lastMessage.toJson(),
    };
  }
}
