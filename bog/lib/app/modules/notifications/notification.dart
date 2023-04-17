import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/notifications_model.dart';
import '../../global_widgets/app_base_view.dart';

class NotificationPage extends GetView<HomeController> {
  final List<NotificationsModel> notifications;
  const NotificationPage(this.notifications, {Key? key}) : super(key: key);

  static const route = '/notification';

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Notification',
          builder: (controller) {
            return Scaffold(
                backgroundColor: AppColors.backgroundVariant2,
                appBar: newAppBarBack(context, 'Notifications'),
                body: SizedBox(
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.06),
                            child: Text(
                              "All",
                              style: AppTextStyle.subtitle1.copyWith(
                                  fontSize: multiplier * 0.07,
                                  color: AppColors.grey.withOpacity(0.8),
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.06),
                            child: Image.asset(
                              "assets/images/Group 47358.png",
                              height: width * 0.08,
                              width: width * 0.08,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width * 0.02,
                      ),
                      SizedBox(
                        height: Get.height * 0.77,
                        child: notifications.isEmpty
                            ? const Center(
                                child: Text('You have no notifications'),
                              )
                            : ListView.builder(
                                itemCount: notifications.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    left: width * 0.02, right: width * 0.02),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final notification = notifications[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.015),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.13,
                                          height: Get.width * 0.13,
                                          child: IconButton(
                                            icon: Image.asset(
                                              "assets/images/Ellipse 956.png",
                                              fit: BoxFit.cover,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: Get.width * 0.8,
                                                child: Text(
                                                  notification.message ?? '',
                                                  style: AppTextStyle.subtitle1
                                                      .copyWith(
                                                          fontSize:
                                                              multiplier * 0.07,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                            SizedBox(height: Get.height * 0.01),
                                            Text(
                                              timeago
                                                      .format(notification
                                                              .createdAt ??
                                                          DateTime.now())
                                                      .capitalizeFirst ??
                                                  '',
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      fontSize:
                                                          multiplier * 0.05,
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: HomeBottomWidget(
                    isHome: false,
                    controller: controller,
                    doubleNavigate: false));
          }),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    Key? key,
    required this.width,
    required this.function,
    required this.asset,
    required this.title,
    required this.multiplier,
  }) : super(key: key);

  final double width;
  final Function() function;
  final String asset;
  final String title;
  final double multiplier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: InkWell(
        onTap: function,
        child: Container(
          height: width * 0.4,
          width: width * 0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: width * 0.15,
                width: width * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Text(
                title,
                style: AppTextStyle.subtitle1.copyWith(
                    fontSize: multiplier * 0.065,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
