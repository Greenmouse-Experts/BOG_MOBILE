import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:bog/app/data/providers/api.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppChat extends GetxController {
  io.Socket? socket;

  final StreamController<dynamic> _chatMessagesStreamController =
      StreamController<dynamic>.broadcast();
  final StreamController<dynamic> _userNotificationsStreamController =
      StreamController<dynamic>.broadcast();
  final StreamController<dynamic> _notificationsStreamController =
      StreamController<dynamic>.broadcast();

  Stream<dynamic> get chatMessagesStream =>
      _chatMessagesStreamController.stream;
  Stream<dynamic> get userNotificationsStream =>
      _userNotificationsStreamController.stream;
  Stream<dynamic> get notificationsStream =>
      _notificationsStreamController.stream;

  void startSocket() {
    try {
      if (socket != null) {
        return;
      }
      socket = io.io(
          Api.chatUrl, io.OptionBuilder().setTransports(['websocket']).build());
      socket!.connect();
      socket!.on('connect', (_) {
        debugPrint('Connected to the server');
      });

      socket!.on('getChatMessagesApi', (data) {
        print(data);
        _chatMessagesStreamController.add(data);
      });

      socket!.on('getUserNotifications', (data) {
        _userNotificationsStreamController.add(data);
      });

      socket!.on('getNotifications', (data) {
        _notificationsStreamController.add(data);
      });
      socket!.onConnect((_) {
        debugPrint('Connection established');
      });
      socket!.onDisconnect((_) => debugPrint('Connection Disconnection'));
      socket!.onConnectError((err) {});
      socket!.onError((err) => debugPrint(err.toString()));

      debugPrint('object na ebeas');
    } catch (e) {
      rethrow;
    }
  }

  void closeSocket() {
    if (socket == null) {
      return;
    }
    socket!.disconnect();
    _chatMessagesStreamController.close();
    _userNotificationsStreamController.close();
    _notificationsStreamController.close();
  }

  void sendMessage(String message, String senderId, String receiverId) {
    if (socket == null) {
      return;
    }
    socket!.emit('send_message',
        {"senderId": senderId, "recieverId": receiverId, "message": message});
  }
}
