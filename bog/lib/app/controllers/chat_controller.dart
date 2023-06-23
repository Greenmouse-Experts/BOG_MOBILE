import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:bog/app/data/providers/api.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppChat extends GetxController {
  final StreamController<String> _chatMessagesStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _userNotificationsStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _notificationsStreamController =
      StreamController<String>.broadcast();

  Stream<String> get chatMessagesStream => _chatMessagesStreamController.stream;
  Stream<String> get userNotificationsStream =>
      _userNotificationsStreamController.stream;
  Stream<String> get notificationsStream =>
      _notificationsStreamController.stream;
  // Create a Socket instance
  io.Socket socket = io.io(Api.baseUrl, <String, dynamic>{
    'autoConnect': false,
    'transports': ['websocket'], // You can specify the transports to be used
  });

  io.Socket wsocket = io.io('http://localhost:3000');

  void startSocket() {
    socket.connect();
    socket.on('connect', (_) {
    
      debugPrint('Connected to the server');
    });

    socket.on('getChatMessagesApi', (data) {
      _chatMessagesStreamController.add(data);
    });

    socket.on('getUserNotifications', (data) {
      _userNotificationsStreamController.add(data);
    });

    socket.on('getNotifications', (data) {
      _notificationsStreamController.add(data);
    });
    socket.onConnect((_) {
      debugPrint('Connection established');
    });
    socket.onDisconnect((_) => debugPrint('Connection Disconnection'));
    socket.onConnectError((err) => debugPrint(err));
    socket.onError((err) => debugPrint(err));

    debugPrint('object na ebeas');
  }

  void closeSocket() {
    socket.disconnect();
    _chatMessagesStreamController.close();
    _userNotificationsStreamController.close();
    _notificationsStreamController.close();
  }

  void sendMessage(String message, String senderId, String receiverId) {
    socket.emit('send_message',
        {"senderId": senderId, "recieverId": receiverId, "message": message});
  }
}
