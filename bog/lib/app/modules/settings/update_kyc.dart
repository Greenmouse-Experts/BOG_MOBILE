import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/bank_list_model.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/page_dropdown.dart';

class UpdateKyc extends StatefulWidget {
  const UpdateKyc({Key? key}) : super(key: key);

  static const route = '/UpdateKyc';

  @override
  State<UpdateKyc> createState() => _UpdateKycState();
}

class _UpdateKycState extends State<UpdateKyc> {
  var bankList =
      BankListModel.fromJsonList(jsonDecode(MyPref.bankListDetail.val));
  var homeController = Get.find<HomeController>();
  var formKey = GlobalKey<FormState>();
  var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
  TextEditingController bankName = TextEditingController();
  TextEditingController bankAcct = TextEditingController();
  TextEditingController bankCode = TextEditingController(text: '120001');
  TextEditingController chosenBankName =
      TextEditingController(text: '9mobile 9Payment Service Bank');

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'UpdateKyc',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
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
                                    "KYC",
                                    style: AppTextStyle.subtitle1.copyWith(
                                        fontSize: multiplier * 0.07,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
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
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            "Complete your KYC",
                            style: AppTextStyle.subtitle1.copyWith(
                              color: Colors.black,
                              fontSize: Get.width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            "Get verified by completing your KYC \ntoday",
                            style: AppTextStyle.subtitle1.copyWith(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: Get.width * 0.036,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: width * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.03, right: width * 0.03),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PageInput(
                                hint: '',
                                label: 'Your Tin',
                                isCompulsory: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your TIN';
                                  }
                                  return null;
                                },
                                showInfo: false,
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              PageInput(
                                hint: '',
                                label: 'Upload your CAC',
                                controller: bankAcct,
                                keyboardType: TextInputType.number,
                                isFilePicker: true,
                              ),
                              SizedBox(
                                height: width * 0.1,
                              ),
                              Text(
                                "Bank Details",
                                style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              PageInput(
                                hint: '',
                                label: 'Account Holder Name',
                                isCompulsory: true,
                                controller: bankName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your account name';
                                  }
                                  return null;
                                },
                                showInfo: false,
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              PageInput(
                                hint: '',
                                label: 'Account Number',
                                isCompulsory: true,
                                controller: bankAcct,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your account number';
                                  } else if (GetUtils.isNumericOnly(value) ==
                                      false) {
                                    return 'Please enter a valid account number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              PageDropButton(
                                label: "Bank",
                                hint: '',
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                onChanged: (val) {
                                  bankCode.text =
                                      (val! as BankListModel).code.toString();
                                  chosenBankName.text =
                                      (val as BankListModel).name.toString();
                                },
                                value: bankList.first,
                                items: bankList
                                    .map<DropdownMenuItem<BankListModel>>(
                                        (BankListModel value) {
                                  return DropdownMenuItem<BankListModel>(
                                    value: value,
                                    child: Text(value.name.toString()),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: Get.height * 0.05,
                              ),
                              AppButton(
                                title: "Submit KYC",
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {}
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundVariant2,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.homeIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.homeTitle,
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.currentBottomNavPage.value == 1
                              ? 'assets/images/chat_filled.png'
                              : 'assets/images/chatIcon.png',
                          width: 22,
                          //color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.projectIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.projectTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.cartIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.cartTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.profileIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.currentBottomNavPage.value,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    controller.currentBottomNavPage.value = index;
                    controller.updateNewUser(controller.currentType);
                    Get.back();
                  }),
            );
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
