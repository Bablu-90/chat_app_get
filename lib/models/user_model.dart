class UserModel {
  String id;
  String name;
  String email;
  String imageUrl;

  String fcmToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.fcmToken,
  });

  //from Json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      fcmToken: json['fcmToken'],
    );
  }

  //to Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'fcmToken': fcmToken,
    };
  }

  //empty
  static UserModel empty() {
    return UserModel(id: '', name: '', email: '', imageUrl: '', fcmToken: '');
  }
}
