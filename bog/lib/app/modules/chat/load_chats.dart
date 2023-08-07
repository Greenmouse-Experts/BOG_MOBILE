import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../core/theme/theme.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/admin_model.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/user_chhat_model.dart';
import '../../data/model/user_details_model.dart';
import '../../data/providers/api.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/new_app_bar.dart';
import 'chat.dart';

class LoadChats extends StatefulWidget {
  const LoadChats({super.key});

  @override
  State<LoadChats> createState() => _LoadChatsState();
}

class _LoadChatsState extends State<LoadChats> {
  late Future<ApiResponse> getAdmins;
  List<AdminModel> _admins = [];

  bool isLoading = true;

  List<UserChatModel> userChats = [];

  void showChatOptions(List<AdminModel> admins, String name) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return DefaultTabController(
              length: 1,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                          icon: Text(
                        name,
                        style: AppTextStyle.bodyText2,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.5,
                    child: TabBarView(children: [
                      ListView.builder(
                          itemCount: admins.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            final admin = admins[i];
                            return ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Chat(
                                            name: admin.name ?? "",
                                            receiverId: admin.id ?? '',
                                          )),
                                );
                                // Get.to(() => Chat(
                                //       name: admin.name ?? "",
                                //       receiverId: admin.id ?? '',
                                //     ));
                              },
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              leading: CircleAvatar(
                                radius: Get.width * 0.06,
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.4),
                                child: Text(
                                  admin.name!.substring(0, 1).toUpperCase(),
                                  style: AppTextStyle.headline4
                                      .copyWith(color: Colors.black),
                                ),
                              ),

                              // AppAvatar(
                              //   // imgUrl: (admin.).toString(),
                              //   // radius: Get.width > 500
                              //   //     ? Get.width * 0.1
                              //   //     : Get.width * 0.16,
                              //   name: admin.name ?? '',
                              // ),
                              title: Text(
                                admin.name ?? '',
                                style: AppTextStyle.headline5
                                    .copyWith(color: Colors.black),
                              ),
                            );
                          }),
                      // SizedBox(),
                      // SizedBox()
                    ]),
                  )
                ],
              ));
        });
  }

  io.Socket? socket;
  late AppChat socketManager;
  var logInDetails =
      UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initSocket();
    });

    final controller = Get.find<HomeController>();
    getAdmins = controller.userRepo.getData('/all/generalAdmin');
  }

  void closeSocket() {
    if (socket == null) {
      return;
    }
    socket!.disconnect();
  }

  @override
  void dispose() {
    closeSocket();
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
        setState(() {
          isLoading = false;
        });
        debugPrint('Connection established');
        socket!.emit('addNewUser', logInDetails.profile!.userId!);

        socket!.on('getOnlineUsers', (data) {
          // print(data);
        });

        socket!.emit(
            'getUserConversations', {"userId": logInDetails.profile!.userId!});

        // socket!.emit('getUserConversations', (data) {
        //   print('this is the emited data');
        //   print(data);
        // });

        socket!.on('getUserNotifications', (data) {});

        socket!.on('getUserConversations', (data) {
          // print('object basss');
          debugPrint(jsonEncode(data));
          // print('na gere');
          //if (mounted) {
          setState(() {
            userChats = UserChatModel.getList(data);
          });
          //  }

          // print('object');
        });

        socket!.on('sentMessage', (data) {
          setState(() {
            //    _chats.add(MessageModel.fromJson(data));
          });

          //  update();
        });

        // // socket!.on('getUserChatMessages', (data) {
        // //   print('dangote');
        // // });

        socket!.on('getChatMessagesApi', (data) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: newAppBarBack(context, 'Chats'),
        body: FutureBuilder<ApiResponse>(
            future: getAdmins,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppLoader();
              } else if (snapshot.data!.isSuccessful) {
                final response = snapshot.data!.users as List<dynamic>;

                List<AdminModel> admins = <AdminModel>[];
                for (var element in response) {
                  admins.add(AdminModel.fromJson(element));
                }

                _admins = admins;

                final productAdmins =
                    _admins.where((element) => element.level == 5).toList();

                final projectAdmins =
                    _admins.where((element) => element.level == 4).toList();

                final superAdmins =
                    _admins.where((element) => element.level == 1).toList();
                var logInDetails =
                    LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
                var type = logInDetails.userType;

                final List<AdminModel> typeAdmins =
                    type == "private_client" || type == 'corporate_client'
                        ? [
                            ...superAdmins,
                          ]
                        : type == 'vendors'
                            ? [...productAdmins]
                            : [...projectAdmins];

                final String adminName =
                    type == "private_client" || type == 'corporate_client'
                        ? 'General Admins'
                        : type == 'vendors'
                            ? 'Product Admins'
                            : 'Project Admins';

                //     admins.clear();

                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      // socket!.emit('getUserConversations',
                      //     {"userId": logInDetails.profile!.userId!});

                      showChatOptions(typeAdmins, adminName);
                    },
                    backgroundColor: AppColors.primary,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: Get.width * 0.05,
                          height: Get.width * 0.05,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: Get.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //   floatingActionButton: FloatingActionButton(onPressed: () {}),
                  body: isLoading
                      ? const AppLoader()
                      : userChats.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: Get.width),
                                const Text('You have no chats currently')
                              ],
                            )
                          : ListView.builder(
                              itemCount: userChats.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                final admin = userChats[i];
                                final name =
                                    "${(admin.conversationtype ?? '').capitalizeFirst} Admin";
                                final receiver = admin.participantsId!
                                    .firstWhere((element) =>
                                        element !=
                                        logInDetails.profile!.userId!);
                                return ListTile(
                                  onTap: () => Get.to(() => Chat(
                                        name: name,
                                        receiverId: receiver,
                                      )),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  leading: CircleAvatar(
                                    radius: Get.width * 0.06,
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.4),
                                    child: Text(
                                      name.substring(0, 1).toUpperCase(),
                                      style: AppTextStyle.headline4
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                  title: Text(
                                    name,
                                    style: AppTextStyle.headline5
                                        .copyWith(color: Colors.black),
                                  ),
                                );
                              }),
                );
              } else {
                return const Center(
                  child: Text(' An error occurred'),
                );
              }
            }));
  }
}
