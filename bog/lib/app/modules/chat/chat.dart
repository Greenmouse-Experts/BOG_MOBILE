import 'dart:convert';
// import 'dart:io';

import 'package:bog/app/controllers/chat_controller.dart';
// import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';

// import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/user_details_model.dart';
// import '../../data/providers/api.dart';
import '../../data/providers/api.dart';
import '../../data/providers/my_pref.dart';
// import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/app_loader.dart';

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
  late AppChat socketManager;

  @override
  void initState() {
    super.initState();
    socketManager = AppChat();
    socketManager.startSocket();
    // initSocket();
    // _socket = io.io(
    //     Api.chatUrl, io.OptionBuilder().setTransports(['websocket']).build());
    // connectSocket();
  }

  // void sendMessageS(String message, String senderId, String receiverId) {
  //   _socket.emit('send_message',
  //       {"senderId": senderId, "recieverId": receiverId, "message": message});
  // }

  @override
  void dispose() {
    // _socket.disconnect();
    // _socket.dispose();
    socketManager.closeSocket();
    super.dispose();
  }

  // void connectSocket() {
  //   _socket.onConnect((data) => print('connection to socket establiished'));
  //   _socket.onConnectError((data) => print('Connectiion error: $data'));
  //   _socket.onDisconnect((data) => print('Connection has been disconnected'));
  //   _socket.connect();
  // }

  // void initSocket() {
  //   io.Socket socket = io.io(
  //       'http://localhost:3000',
  //       OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
  //           .setExtraHeaders({'foo': 'bar'}) // optional
  //           .build());
  //   // io.Socket socket = io.io(Api.baseUrl, <String, dynamic>{
  //   //   'autoConnect': false,
  //   //   'transports': ['websocket'], // You can specify the transports to be used
  //   // });

  //   socket.connect();
  //   socket.onConnect((data) => debugPrint('on colos on cos'));
  //   socket.onError((data) {
  //     print('object');
  //     print(data.toString());
  //   });
  // }

  final TextEditingController _messageController = TextEditingController();

  void sendMessage() {
    if (_messageController.text.isEmpty) {
      return;
    }
    var logInDetails =
        UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));

    socketManager.sendMessage(
        _messageController.text, logInDetails.profile!.id!, widget.receiverId);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
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
      child: GetBuilder<HomeController>(
          id: 'Chat',
          builder: (controller) {
            return Scaffold(
              appBar: newAppBarBack(context, widget.name),
              body: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: StreamBuilder<dynamic>(
                        stream: socketManager.chatMessagesStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const AppLoader();
                          } else if (snapshot.hasData) {
                            return Text('Chat Message: ${snapshot.data}');
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const Text('No chat message yet');
                          }
                        },
                      ),
                    ),
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
            );
          }),
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