import 'package:chat/core/models/chat_notification.dart';
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
}
