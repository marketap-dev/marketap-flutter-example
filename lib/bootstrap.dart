import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:marketap_sdk/marketap_sdk.dart';
import 'config.dart';
import 'deeplink.dart'; // 기존 파일 유지

Future<void> _bgHandler(RemoteMessage msg) async {
  await Firebase.initializeApp();
  debugPrint('[BG] ${msg.messageId}');
}

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DeepLinkService.init();
  Marketap.initialize(projectKey);
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_bgHandler);

  debugPrint('[FCM ] token = ${await FirebaseMessaging.instance.getToken()}');

  if (Platform.isIOS || Platform.isMacOS) {
    debugPrint(
      '[APNS] token = ${await FirebaseMessaging.instance.getAPNSToken()}',
    );
  }
  FirebaseMessaging.instance.onTokenRefresh.listen(
    (t) => debugPrint('[FCM ] refreshed token = $t'),
  );
}
