import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/bottom_widget.dart';

class OrderDetails extends StatefulWidget {
  final String id;
  const OrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var lgaController = TextEditingController(text: 'Eti Osa');
  var sizeController = TextEditingController(text: '0 - 1000 sq.m');
  var typeController = TextEditingController(text: 'Residential');
  var surveyController = TextEditingController(text: 'Perimeter Survey');

  @override
  Widget build(BuildContext context) {
    //  var title = Get.arguments as String?;
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    print(widget.id);
    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'OrderDetails',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: width * 0.045,
                          top: kToolbarHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/images/back.svg",
                              height: width * 0.045,
                              width: width * 0.045,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Order Details",
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: multiplier * 0.07,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Container(
                      height: 1,
                      width: width,
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Text(
                        controller.currentType == "Service Partner"
                            ? "Project ID :  LAN -SUV -132"
                            : "Order ID :  SAN - 123- NDS ",
                        style: AppTextStyle.subtitle1.copyWith(
                            fontSize: multiplier * 0.07,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Text(
                        "Project Name ",
                        style: AppTextStyle.subtitle1.copyWith(
                            fontSize: multiplier * 0.065,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Text(
                        "Land Survey Project",
                        style: AppTextStyle.subtitle1.copyWith(
                            fontSize: multiplier * 0.068,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Text(
                        "Service type",
                        style: AppTextStyle.subtitle1.copyWith(
                            fontSize: multiplier * 0.065,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Text(
                        "Land Survey",
                        style: AppTextStyle.subtitle1.copyWith(
                            fontSize: multiplier * 0.068,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Text(
                        "Service Location",
                        style: AppTextStyle.subtitle1.copyWith(
                            fontSize: multiplier * 0.065,
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Text(
                        "No 7, Street close, Ogba Ikeja, Lagos",
                        style: AppTextStyle.subtitle1.copyWith(
                            fontSize: multiplier * 0.068,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Container(
                        height: 1,
                        width: width,
                        color: AppColors.grey.withOpacity(0.1),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05, left: width * 0.045, top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: AppButton(
                              title: "Decline",
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              border:
                                  Border.all(color: const Color(0xFFDC1515)),
                              bckgrndColor: Colors.white,
                              fontColor: const Color(0xFFDC1515),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.4,
                            child: AppButton(
                              title: "Accept",
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              border:
                                  Border.all(color: const Color(0xFF24B53D)),
                              bckgrndColor: Colors.white,
                              fontColor: const Color(0xFF24B53D),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: HomeBottomWidget(
                  controller: controller, doubleNavigate: false, isHome: false),
            );
          }),
    );
  }
}
