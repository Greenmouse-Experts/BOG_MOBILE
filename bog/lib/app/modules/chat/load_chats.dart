import 'dart:convert';

import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/admin_model.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/global_widgets.dart';
import 'chat.dart';

class LoadChats extends StatefulWidget {
  const LoadChats({super.key});

  @override
  State<LoadChats> createState() => _LoadChatsState();
}

class _LoadChatsState extends State<LoadChats> {
  late Future<ApiResponse> getAdmins;
  List<AdminModel> _admins = [];

  @override
  void initState() {
    super.initState();
    final controller = Get.find<HomeController>();
    getAdmins = controller.userRepo.getData('/all/generalAdmin');
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

                return admins.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton(
                            title: 'title',
                            onPressed: () => Get.to(
                                () => const Chat(name: 'Omar', receiverId: '')),
                          ),
                          const Text('No Admins are currently available')
                        ],
                      )
                    : ListView.builder(
                        itemCount: typeAdmins.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) {
                          final admin = typeAdmins[i];
                          return ListTile(
                            onTap: () => Get.to(() => Chat(
                                  name: admin.name ?? "",
                                  receiverId: admin.id ?? '',
                                )),
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
                            title: Text(
                              admin.name ?? '',
                              style: AppTextStyle.headline5
                                  .copyWith(color: Colors.black),
                            ),
                          );
                        });
              } else {
                return const Center(
                  child: Text(' An error occurred'),
                );
              }
            }));
  }
}
