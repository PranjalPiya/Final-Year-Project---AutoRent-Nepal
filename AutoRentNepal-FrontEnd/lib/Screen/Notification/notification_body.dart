import 'package:auto_rent_nepal_fyp/Screen/Notification/notificaiton_badge.dart';
import 'package:auto_rent_nepal_fyp/models/pushnotification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotificationBody extends StatefulWidget {
  const PushNotificationBody({Key? key}) : super(key: key);

  @override
  State<PushNotificationBody> createState() => _PushNotificationBodyState();
}

class _PushNotificationBodyState extends State<PushNotificationBody> {
  late final FirebaseMessaging _messaging;
  late int _totalNotificaitonCounter;

  Pushnotification? _pushnotification;

  void registerNotfication() async {
    await Firebase.initializeApp();
    //instance for firebase messaging
    _messaging = FirebaseMessaging.instance;

    //
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted the permission');
      //Main Message send here

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          Pushnotification notification = Pushnotification(
            title: message.notification?.title,
            body: message.notification?.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body'],
          );
          setState(() {
            _totalNotificaitonCounter++;
            _pushnotification = notification;
          });
          if (notification != null) {
            showSimpleNotification(
              Text(_pushnotification!.title!),
              subtitle: Text(_pushnotification!.body!),
              background: Colors.green.shade500,
              duration: const Duration(seconds: 2),
            );
          }
        },
      );
    } else {
      print('permission decline by user.!');
    }
  }

  //check the initial message that we receive
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Pushnotification notification = Pushnotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
    }
  }

  @override
  void initState() {
    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Pushnotification notification = Pushnotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        _totalNotificaitonCounter++;
        _pushnotification = notification;
      });
    });
    //normal notificaiton
    registerNotfication();
    _totalNotificaitonCounter = 0;
    //when app is terminated state
    checkForInitialMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Notificaitons'),
            Notificationbadge(
              totalNotification: _totalNotificaitonCounter,
            ),
            _pushnotification != null
                ? Column(
                    children: [
                      Text(
                          '${_pushnotification!.dataTitle ?? _pushnotification!.title}'),
                      Text(
                          '${_pushnotification!.dataBody ?? _pushnotification!.body}'),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
