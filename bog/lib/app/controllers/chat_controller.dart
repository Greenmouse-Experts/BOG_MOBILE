import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:bog/app/data/providers/api.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../data/model/message_model.dart';

class AppChat extends GetxController {
  io.Socket? socket;

  final List<MessageModel> _chats = [];

  List<MessageModel> get chats => _chats;

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

  void startSocket(String senderId, String receiverId) {
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

      socket!.onConnect((_) {
        debugPrint('Connection established');
        socket!.on('getUserChatMessages', (data) {
          print('object');
          print(data);
        });

        socket!.on('getUserChatMessages', (data) {
          print('les chats');
          print(data.toString());
        });

        socket!.on('sentMessage', (data) {
          print('new message');
          print(data);
          _chats.add(MessageModel.fromJson(data));
          print(_chats.length);
          update();
        });

        socket!.on('getChatMessagesApi', (data) {
          print(data);
          print('new message');

          _chatMessagesStreamController.add(data);
        });
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

    // print(message);
    // print(senderId);
    // print(receiverId);
    print(senderId);
    socket!.emit('send_message',
        {"senderId": senderId, "recieverId": receiverId, "message": message});
    socket!.emit('getUserChatMessages',
        {"senderId": senderId, "recieverId": receiverId});
  }
}
