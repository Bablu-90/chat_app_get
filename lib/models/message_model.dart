

import 'package:chat_app_get/models/user_model.dart';

class MessageModel {
  String id;
  String text;
  UserModel sender;
  DateTime createdAt;
  List<UserModel> seenBy;
  String? imageUrl;

  MessageModel(
      {required this.id,
      required this.text,
      required this.sender,
      required this.createdAt,
      required this.seenBy,
      this.imageUrl, required int timestamp});

  //from Json
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      text: json['text'],
      sender: UserModel.fromJson(json['sender']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      seenBy:
          (json['seenBy'] as List).map((e) => UserModel.fromJson(e)).toList(),
      imageUrl: json['imageUrl'], timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  //to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'sender': sender.toJson(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'seenBy': seenBy.map((e) => e.toJson()).toList(),
      'imageUrl': imageUrl,
    };
  }

  //empty
  factory MessageModel.empty() {
    return MessageModel(
        id: '',
        text: '',
        sender: UserModel.empty(),
        createdAt: DateTime.now(),
        seenBy: [],
        imageUrl: '', timestamp: DateTime.now().microsecondsSinceEpoch,);
  }
}
