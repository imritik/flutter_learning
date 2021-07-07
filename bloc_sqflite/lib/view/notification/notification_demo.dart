import 'package:flutter/material.dart';
import 'package:bloc_sqflite/services/notification_service.dart';

// ignore: use_key_in_widget_constructors
class NotificationDemo extends StatelessWidget {
  final NotificationService _notificationService = NotificationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter notification demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _notificationService.showNotification();
              },
              child: const Text(
                'showNotification',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _notificationService.cancelNotification();
              },
              child: const Text(
                'cancelNotification',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _notificationService.scheduleNotification();
              },
              child: const Text(
                'scheduleNotification',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _notificationService.showBigPictureNotification();
              },
              child: const Text(
                'showBigPictureNotification',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _notificationService.showNotificationMediaStyle();
              },
              child: const Text(
                'showNotificationMediaStyle',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
