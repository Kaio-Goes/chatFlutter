import 'package:chat/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> itemsList = [];

  int get itemsCount {
    return itemsList.length;
  }

  List<ChatNotification> get items {
    return [...itemsList];
  }

  void add(ChatNotification notification) {
    itemsList.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    itemsList.removeAt(i);
    notifyListeners();
  }

  // Push notification
  Future<void> init() async {
    await _configureForeground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen((msg) {
        if (msg.notification == null) return;
        
        add(ChatNotification(
          title: msg.notification!.title ?? 'Não informado!',
          body: msg.notification!.body ?? 'Não informado!',
        ));
      });
    }
  }
}
