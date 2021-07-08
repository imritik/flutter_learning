import 'package:bloc_sqflite/view/notification/new_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  Future<void> init() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_devs');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) async {
    Get.to(NewScreen(payload: payload!));
  }

  void showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'media channel id', 'media channel name', 'media channel description',
        color: Colors.red,
        enableLights: true,
        largeIcon: DrawableResourceAndroidBitmap("flutter_devs"),
        styleInformation: MediaStyleInformation());

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);

    await flutterLocalNotificationsPlugin.show(
        0, 'notification title', 'body', platformChannelSpecifics);
  }

  void showBigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("flutter_devs"),
        largeIcon: DrawableResourceAndroidBitmap("flutter_devs"),
        contentTitle: "fluuter devs",
        htmlFormatContentTitle: true,
        summaryText: 'Summary text',
        htmlFormatSummaryText: true);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);

    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  void scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 5));

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'flutter_devs',
      largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  void cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  void showNotification() async {
    var android = const AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('tone'));

    var iOS = const IOSNotificationDetails();

    var platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter local notification demo', platform,
        payload: 'Welcome to the local notification demo');
  }
}
