import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';

import '../../../data/model/announcement_model.dart';
import '../../../data/providers/api_response.dart';

import '../../../global_widgets/app_loader.dart';
import '../../../global_widgets/global_widgets.dart';
import '../../../global_widgets/pdf_page_viewer.dart';
import '../../../global_widgets/photo_view_page.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  late Future<ApiResponse> getAnnouncements;
  var search = '';

  @override
  void initState() {
    //  Get.put(HomeController(UserRepository(Api())));
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
   //   Get.put(HomeController(UserRepository(Api())));
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              height: Get.height * 0.89,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // newAppBar(context,'Messages'),
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
                            fontSize: Get.width > 600
                                ? Get.width * 0.03
                                : Get.width * 0.045,
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
                      size:
                          Get.width > 600 ? Get.width * 0.03 : Get.width * 0.05,
                    ),
                    onChanged: (val) {
                      if (search != val) {
                        setState(() {
                          search = val;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Expanded(
                      // height: Get.height * 0.68,
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
                                List<AnnouncementModel> announcements =
                                    <AnnouncementModel>[];

                                for (var element in response) {
                                  announcements
                                      .add(AnnouncementModel.fromJson(element));
                                }

                                if (search.isNotEmpty) {
                                  announcements = {
                                    ...announcements
                                        .where((element) => element.title!
                                            .toLowerCase()
                                            .contains(search.toLowerCase()))
                                        .toList(),
                                    ...announcements
                                        .where((element) => element.content!
                                            .toLowerCase()
                                            .contains(search.toLowerCase()))
                                        .toList()
                                  }.toList();
                                }

                                return announcements.isEmpty
                                    ?const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children:  [
                                          Text('You have no messages currently')
                                        ],
                                      )
                                    : ListView.builder(
                                        itemCount: announcements.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final announcement =
                                              announcements[index];
                                          return SizedBox(
                                            height: Get.height * 0.08,
                                            child: InkWell(
                                              onTap: () {
                                                AppOverlay.showInfoDialog(
                                                  title:
                                                      announcement.title ?? '',
                                                  contentReplacement: Column(
                                                    children: [
                                                      Text(
                                                        announcement.content ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTextStyle
                                                            .bodyText2
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      announcement.supportingDocument ==
                                                              null
                                                          ? const SizedBox
                                                              .shrink()
                                                          : AppButton(
                                                              title:
                                                                  'View Supporting Document',
                                                              onPressed: () {
                                                                Get.back();
                                                                if (announcement.supportingDocument!.endsWith('.jpg') ||
                                                                    announcement
                                                                        .supportingDocument!
                                                                        .endsWith(
                                                                            '.png') ||
                                                                    announcement
                                                                        .supportingDocument!
                                                                        .endsWith(
                                                                            '.jpeg')) {
                                                                  Get.to(() =>
                                                                      PhotoViewPage(
                                                                          url: announcement
                                                                              .supportingDocument!));
                                                                } else if (announcement
                                                                    .supportingDocument!
                                                                    .endsWith(
                                                                        '.pdf')) {
                                                                  Get.to(() =>
                                                                      PdfViewerPage(
                                                                          path:
                                                                              announcement.supportingDocument!));
                                                                } else {
                                                                  Get.snackbar(
                                                                      'Error',
                                                                      'File type not supported currently',
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      colorText:
                                                                          AppColors
                                                                              .background);
                                                                }
                                                              },
                                                              borderRadius: 10,
                                                              bckgrndColor:
                                                                  Colors.white,
                                                              fontColor:
                                                                  AppColors
                                                                      .primary,
                                                              bold: false,
                                                            )
                                                    ],
                                                  ),
                                                  buttonText: 'Back',
                                                );
                                              },
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
                                                          radius:
                                                              Get.width * 0.16,
                                                          name: "Admin"),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        //  crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                Get.width * 0.5,
                                                            child: Text(
                                                              announcement
                                                                      .title ??
                                                                  '',
                                                              style: AppTextStyle
                                                                  .subtitle1
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          Get.width *
                                                                              0.04),
                                                            ),
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(announcement
                                                                    .createdAt!),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize: Get
                                                                            .width *
                                                                        0.035),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: Get.height *
                                                              0.01),
                                                      SizedBox(
                                                        width: Get.width * 0.7,
                                                        child: Text(
                                                          announcement
                                                                  .content ??
                                                              '',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyle
                                                              .subtitle1
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.035),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.01,
                                                      ),
                                                      Container(
                                                        height: 1,
                                                        width: Get.width * 0.7,
                                                        color: Colors.grey
                                                            .withOpacity(.2),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
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
          ],
        ),
      );
    });
  }
}
