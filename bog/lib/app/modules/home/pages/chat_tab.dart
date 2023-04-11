import 'package:bog/app/data/model/announcement_model.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/modules/chat/chat.dart';
import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';

import '../../../data/providers/api_response.dart';
import '../../../global_widgets/app_avatar.dart';
import '../../../global_widgets/app_input.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  late Future<ApiResponse> getAnnouncements;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    final userType = controller.currentType == 'Client'
        ? 'private_client'
        : controller.currentType == 'Corporate Client'
            ? 'corporate_client'
            : controller.currentType == 'Product Partner'
                ? 'vendor'
                : 'professional';
    getAnnouncements =
        controller.userRepo.getData('/announcements?userType=$userType');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              height: Get.height * 0.91,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: kToolbarHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Messages",
                          style: AppTextStyle.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: Get.width * 0.045,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  AppInput(
                    hintText: 'Search with name or keyword ...',
                    filledColor: Colors.grey.withOpacity(.1),
                    prefexIcon: Icon(
                      FeatherIcons.search,
                      color: Colors.black.withOpacity(.5),
                      size: Get.width * 0.05,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  SizedBox(
                      height: Get.height * 0.65,
                      child: FutureBuilder<ApiResponse>(
                          future: getAnnouncements,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AppLoader();
                            } else {
                              if (snapshot.data!.isSuccessful) {
                                final response =
                                    snapshot.data!.data as List<dynamic>;
                                final announcements = <AnnouncementModel>[];

                                for (var element in response) {
                                  announcements
                                      .add(AnnouncementModel.fromJson(element));
                                }

                                return ListView.builder(
                                  itemCount: announcements.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final announcement = announcements[index];
                                    return SizedBox(
                                      height: Get.height * 0.08,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.16,
                                            height: Get.width * 0.16,
                                            child: IconButton(
                                              icon: AppAvatar(
                                                  imgUrl: "",
                                                  radius: Get.width * 0.16,
                                                  name: "Admin"),
                                              onPressed: () {},
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    announcement.title ?? '',
                                                    style: AppTextStyle
                                                        .subtitle1
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize:
                                                                Get.width *
                                                                    0.04),
                                                  ),
                                                  SizedBox(
                                                      width: Get.width * 0.2),
                                                  Text(
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(announcement
                                                            .createdAt!),
                                                    style: AppTextStyle
                                                        .subtitle1
                                                        .copyWith(
                                                            color: Colors.grey,
                                                            fontSize:
                                                                Get.width *
                                                                    0.035),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.01),
                                              Text(
                                                announcement.content ?? '',
                                                style: AppTextStyle.subtitle1
                                                    .copyWith(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            Get.width * 0.035),
                                              ),
                                              //Divider
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Container(
                                                height: 1,
                                                width: Get.width * 0.7,
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text('An error occurred'),
                                );
                              }
                            }
                          }))
                ],
              ),
            ),
            //floating action button
            FloatingActionButton(
              onPressed: () {
                Get.toNamed(Chat.route);
              },
              backgroundColor: AppColors.primary,
              child: Stack(
                children: [
                  SizedBox(
                      width: Get.width * 0.05,
                      height: Get.width * 0.05,
                      child: Image.asset("assets/images/chat_new.png")),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
