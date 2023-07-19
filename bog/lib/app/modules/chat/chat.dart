import 'dart:convert';
// import 'dart:io';

import 'package:bog/app/controllers/chat_controller.dart';
import 'package:bog/app/global_widgets/message_bubble.dart';
// import 'package:bog/app/global_widgets/app_loader.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:bog/app/global_widgets/new_app_bar.dart';

// import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../core/theme/app_colors.dart';
import '../../data/model/message_model.dart';
import '../../data/model/user_details_model.dart';
// import '../../data/providers/api.dart';
// import '../../data/providers/api.dart';
import '../../data/providers/api.dart';
import '../../data/providers/my_pref.dart';
// import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';

class Chat extends StatefulWidget {
  final String name;
  final String receiverId;
  const Chat({Key? key, required this.name, required this.receiverId})
      : super(key: key);

  static const route = '/chat';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  // late io.Socket _socket;

  io.Socket? socket;
  late AppChat socketManager;
  var logInDetails =
      UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));

  String conversationId = '';

  final List<MessageModel> _chats = [];

  @override
  void initState() {
    super.initState();
    // socketManager = AppChat();
    // socketManager.startSocket(logInDetails.profile!.userId!, widget.receiverId);
    initSocket();
    // _socket = io.io(
    //     Api.chatUrl, io.OptionBuilder().setTransports(['websocket']).build());
    // connectSocket();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initSocket() {
    try {
      if (socket != null) {
        return;
      }
      socket = io.io(
          Api.chatUrl, io.OptionBuilder().setTransports(['websocket']).build());
      socket!.connect();

      socket!.onConnect((_) {
        debugPrint('Connection established');
        socket!.emit('addNewUser', logInDetails.profile!.userId!);

        socket!.on('getOnlineUsers', (data) {
          print('onliners');
          print(data);
        });

        socket!.emit('getUserConversations ');

        // socket!.emit('getUserConversations', (data) {
        //   print('this is the emited data');
        //   print(data);
        // });

        socket!.on('getUserNotifications', (data) {
          print('user notifications');
          print(data);
        });

        socket!.on('getUserConversations', (data) {
          print('les chats');
          print(data);
        });

        socket!.on('sentMessage', (data) {
          print('new message');
          print(data);
          setState(() {
            _chats.add(MessageModel.fromJson(data));
          });
          print(_chats.length);
          //  update();
        });

        // // socket!.on('getUserChatMessages', (data) {
        // //   print('dangote');
        // // });

        socket!.on('getChatMessagesApi', (data) {
          print(data);
          print('new message wanne');

          // _chatMessagesStreamController.add(data);
        });
      });
      socket!.onDisconnect((_) => debugPrint('Connection Disconnection'));
      socket!.onConnectError((err) {});
      socket!.onError((err) => debugPrint(err.toString()));
    } catch (e) {
      rethrow;
    }
  }

  final TextEditingController _messageController = TextEditingController();

  void sendMessage() {
    if (_messageController.text.isEmpty) {
      return;
    }
    if (socket == null) {
      return;
    }
    // print(logInDetails.profile!.userId!);
    socket!.emit('send_message', {
      "senderId": logInDetails.profile!.userId!,
      "recieverId": widget.receiverId,
      "message": _messageController.text,
      "conversationId": "73dc0f9e-7da7-42a7-b2c9-dd1ecf922c69"
    });

    print('message sent successfully');

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.receiverId);
    // var width = Get.width;
    //final Size size = MediaQuery.of(context).size;
    // double multiplier = 25 * size.height * 0.01;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Scaffold(
        appBar: newAppBarBack(context, widget.name),
        body: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: _chats.length,
                      itemBuilder: (context, i) {
                        final chat = _chats[i];
                        return MessageBubble(
                          message: chat.message ?? '',
                          isMe: chat.senderId == logInDetails.profile!.userId!,
                          userName: 'Me',
                        );
                      })),
              SizedBox(
                height: Get.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        Expanded(
                          child: AppInput(
                            hintText: '',
                            controller: _messageController,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //        bottomNavigationBar:
      ),
    );
  }
}


 // Padding(
                    //   padding: EdgeInsets.only(
                    //       right: width * 0.05,
                    //       left: width * 0.03,
                    //       top: kToolbarHeight),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: SvgPicture.asset(
                    //           "assets/images/back.svg",
                    //           height: width * 0.05,
                    //           width: width * 0.05,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: width * 0.04,
                    //       ),
                    //       Expanded(
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             SizedBox(
                    //               width: Get.width * 0.12,
                    //               height: Get.width * 0.12,
                    //               child: IconButton(
                    //                 icon: AppAvatar(
                    //                     imgUrl: "",
                    //                     radius: Get.width * 0.12,
                    //                     name: "BOG"),
                    //                 onPressed: () {},
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: width * 0.02,
                    //             ),
                    //             Expanded(
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.stretch,
                    //                 children: [
                    //                   Text(
                    //                     "BOG Engineer",
                    //                     style: AppTextStyle.subtitle1.copyWith(
                    //                         fontSize: multiplier * 0.065,
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.w400),
                    //                     textAlign: TextAlign.start,
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // //Divider
                    // const Divider(
                    //   color: Colors.grey,
                    //   thickness: 0.3,
                    // ),