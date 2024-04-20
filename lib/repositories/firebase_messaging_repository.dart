import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessaginRepository {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<String?> getFcmToken() async {
    return await messaging.getToken();
  }
}
