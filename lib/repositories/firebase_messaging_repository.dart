import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessaginRepository {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void initialize(void Function(RemoteMessage)? onMessageOpened) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    requestPermissions();
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpened);
  }

  Future<String?> getFcmToken() async {
    return await messaging.getToken();
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (message.notification != null) {
      print(
          "Message received. Title: ${message.notification!.title}, Body: ${message.notification!.body}");
    }
  }

  Future<void> requestPermissions() async {
    await messaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
