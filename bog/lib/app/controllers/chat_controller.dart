import 'package:flutter/foundation.dart';
import 'package:bog/app/data/providers/api.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppChat extends GetxController {
  io.Socket? socket;

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

      socket!.on('getChatMessagesApi', (data) {});

      socket!.on('getUserNotifications', (data) {});

      socket!.on('getNotifications', (data) {});
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
    // _chatMessagesStreamController.close();
    // _userNotificationsStreamController.close();
    // _notificationsStreamController.close();
  }

  void sendMessage(String message, String senderId, String receiverId) {
    if (socket == null) {
      return;
    }
    socket!.emit('send_message',
        {"senderId": senderId, "recieverId": receiverId, "message": message});
  }
}
