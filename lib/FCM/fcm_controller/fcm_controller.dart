import 'dart:convert';

import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FCMController extends GetxController {
  Map<String, String> service_account = {
    "type": "service_account",
    "project_id": "flutterchat-bms",
    "private_key_id": "7b850a2e648c79e92c5d86ea348a13d1937a799b",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCmx6oXXNgNeJQE\nO6DWY2OX7GTJvnjRs174lKwUGu3exeGOgi9wwMjY7PDBSwwOvNHlLpUZzYVM/oAY\njIs2maiPERYcyhyMHfGVLLTwu//RgYFb/NQiNgfnY7BrhAXuUSfez4DyzZTTTt7q\no7zHP/+Ubbh8jNGmoFwEMEJXw+WzEiQi/Lv4fFxeiRcSpsiBMgMsdLPQyk8ZR/v/\nnpys3/89DK5vhqUoJ0O4IhyZm8wKsp+e7ua8qa3wvQyaOOtItnxWEbsg9hknx6zk\nngZ8D2+FkQb870HmDUt6jJZ4cB4PUZVL6o2nEomTGorPL4hW/xXNBLRZjGkgTrY5\nAojsvO2JAgMBAAECggEAEHMhE6zUon+CGejHtF2ZNSLbzgo7YHOQqnP/hPwi+hYK\naUPt6fEZ3kuAc5AzYEC/cxtlGWZr/2watlEmafw9496Lj8tfhXJuoYgHULc6RC/B\n0pDdW4J4xRnQDMq4ywi2JgPRdCFSzIS69+mudPia/MjVqXM6OnUWnlMkOAPaZA79\nLSkjrsoNtV5LGsgfNRG7cwcm3WkTZN/Li59M95CNu2XyVY1ZpvqXNx2nW7iUEK/H\nK3nUc4D+aQHnoHtkVUYqamNjZednnguz1fyls9EGSicDr7dtt3/vsjhOxoR6412h\nahWhb1wZE3PK4+7FjjsSpImC34U2jQSja8dLI56lAQKBgQDa9K0QCmqi/32tdgQN\nTBagLNawg18lXppERpFslAEmtevwyp1AkkcyDkO0xDDHqCdYmCfsRM/7vJoeJ50c\nBx5WxOHdp4A+tFHV2QngDPmQozL6f/CayEwWNVr7IsMf/YaSt7gbDhsy8SClTe4W\nvFDFx2gdcSU2H4yOfyySGDknwwKBgQDC/yuE9mWBobzRzpE6DSYjcZLZTMmMBzm9\nm3k0Qspb20JqLcukafwFjm2siB0VwrVr94edbNzJ4wPbV+AN9mgAKLgwwAC5SN+W\nWDubpK4u6rY2rVi8Ec7dGw4VC2iASx523g6Bm5k43kxWn+woN832DqKh9MGSmQc1\nBC8JaGeMwwKBgFNflcKk5MQaW0XAyXwyu+7UBBAEhidZpY5X/KoGlYWjAiuXS1e6\nG4gQ7HEZv6VW/1x528HY1gV6ZIkU9nskrsXFhGf9jxTRXtP6KAt7hVAxBIlkTD70\nBBz0xicYroow5Jxbfqw2q96y+IZZbU6U+IDHFHsZiVzZmJDuFg+vT5w3AoGBALr2\nmE6LRTYu0nFEIyDK/LddLRTmuBRn1SgESwkdxRKfvyU5NZk1+WuGbYfQljqIDxUv\nJ7t8ZpG39bm4nt4kVQFaCYjMf6UnxyFLBhQsqMnZR85TFNJ2LKb5St5IqvDflZ0Z\nOkVw4E+TbRRdj7vcDcGPtMWefH9H9I4TrdnSXf6rAoGABspffgnjKjrN+QmPJNH4\nppX3nonunq3lp6sSrMwiPjkdxkTfLymcFcrMm4WJQdJrwcpoV5kkovs4ChbkdfJb\nbDOrkG4auFupT5nJK9gcTSYqK9GrRv2jf3ZRjx8Gjm+fk9Ov0QAiCGVCjl54HTqr\nfLnx1ox9B+PhQqdsFtDBWQ8=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-gs57e@flutterchat-bms.iam.gserviceaccount.com",
    "client_id": "103801261719203812383",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-gs57e%40flutterchat-bms.iam.gserviceaccount.com"
  };

  static const _SCOPES = [
    //'https://www.googleapis.com/auth/cloud-platform.read-only',
    'https://www.googleapis.com/auth/firebase.messaging',
  ];

  Future<String> getAccessToken() async {
    String accessToken = "";
    ServiceAccountCredentials _credentials =
        ServiceAccountCredentials.fromJson(service_account);
    final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
      _credentials,
      _SCOPES,
      http.Client(),
    );

    return accessCredentials.accessToken.data;
  }

  Future<void> sendNotification(String fcmToken, String title, String body,
      {String? imageUrl}) async {
    await getAccessToken().then((accessToken) async {
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/flutterchat-bms/messages:send'));
      request.body = json.encode({
        "message": {
          "token": fcmToken,
          "notification": {"title": title, "body": body}
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
      } else {}
    });
  }
}
// receive message from another user
