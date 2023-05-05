import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmProvider extends ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _loaclNotifcation = FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notification",
    description: "test One",
    importance: Importance.high,
    playSound: true,
  );
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('app_Icon');

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> notificationDetails({
    int id = 0,
    required String title,
    required String body,
    String? payload,
    String? token,
  }) async {
    Map<String, String> toMap() {
      return {
        // 'isMe': isMe  ??true ,
        'body': body,
        'title': title,
      };
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _firebaseMessaging.sendMessage(to: token, data: toMap());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (message.notification != null) {
        _loaclNotifcation.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                playSound: true,
              ),
            ));
      }
    });
  }
}
