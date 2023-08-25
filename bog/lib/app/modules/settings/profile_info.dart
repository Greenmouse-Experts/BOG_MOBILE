import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../../data/model/user_details_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/page_input.dart';
import 'edit_profile.dart';

class ProfileInfo extends GetView<HomeController> {
  const ProfileInfo({Key? key}) : super(key: key);

  static const route = '/ProfileInfo';

  @override
  Widget build(BuildContext context) {
    String removeCountryCode(String phoneNumber, String countryCode) {
      if (phoneNumber.startsWith(countryCode)) {
        return phoneNumber.substring(countryCode.length);
      } else {
        return phoneNumber; // Country code not found, return the original number
      }
    }

    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    const countryList = countries;

    var logInDetails =
        UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));

    //
    var unformattedPhone = logInDetails.phone ?? "";
    var initalNumber = unformattedPhone;
    if (unformattedPhone.startsWith("+")) {
      unformattedPhone = unformattedPhone.substring(1);
    }

    final selectedCountry = countries.firstWhere(
        (country) => unformattedPhone.startsWith(country.dialCode),
        orElse: () => countryList.first);

    final formattedPhone =
        removeCountryCode(unformattedPhone, selectedCountry.dialCode);

    TextEditingController firstName =
        TextEditingController(text: logInDetails.fname);
    TextEditingController lastName =
        TextEditingController(text: logInDetails.lname);
    TextEditingController email =
        TextEditingController(text: logInDetails.email);
    TextEditingController phoneNumber =
        TextEditingController(text: formattedPhone);
    TextEditingController address =
        TextEditingController(text: logInDetails.address);
    TextEditingController state =
        TextEditingController(text: logInDetails.state);
    TextEditingController city = TextEditingController(text: logInDetails.city);

    return GetBuilder<HomeController>(
        id: 'ProfileInfo',
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
                                    "Profile Info",
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
                            InkWell(
                              onTap: () {
                                Get.to(() => const EditProfile());
                              },
                              child: SvgPicture.asset(
                                "assets/images/write.svg",
                                height: width * 0.045,
                                width: width * 0.045,
                                color: Colors.black,
                              ),
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
                          SizedBox(
                            width: Get.width * 0.22,
                            height: Get.width * 0.22,
                            child: IconButton(
                              icon: AppAvatar(
                                  imgUrl: (logInDetails.photo).toString(),
                                  radius: Get.width * 0.16,
                                  name:
                                      "${logInDetails.fname} ${logInDetails.lname}"),
                              onPressed: () {},
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${logInDetails.fname} ${logInDetails.lname}",
                                style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.045,
                                ),
                              ),
                              Text(
                                logInDetails.userType
                                    .toString()
                                    .replaceAll("_", " ")
                                    .capitalizeFirst
                                    .toString(),
                                style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: Get.width > 600
                                      ? Get.width * 0.025
                                      : Get.width * 0.035,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: width * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.025, right: width * 0.025),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.45,
                                  child: PageInput(
                                    hint: '',
                                    textWidth: 0.3,
                                    label: 'First Name',
                                    isCompulsory: false,
                                    readOnly: true,
                                    borderSide: BorderSide.none,
                                    controller: firstName,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.45,
                                  child: PageInput(
                                    hint: '',
                                    textWidth: 0.3,
                                    label: 'Last Name',
                                    isCompulsory: false,
                                    readOnly: true,
                                    borderSide: BorderSide.none,
                                    controller: lastName,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            PageInput(
                              hint: '',
                              label: 'Email',
                              isCompulsory: false,
                              readOnly: true,
                              borderSide: BorderSide.none,
                              controller: email,
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            PageInput(
                              hint: '',
                              initialValue: initalNumber,
                              label: 'Phone Number',
                              isCompulsory: false,
                              readOnly: true,
                              keyboardType: TextInputType.phone,
                              isPhoneNumber: true,
                              borderSide: BorderSide.none,
                              controller: phoneNumber,
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            PageInput(
                              hint: 'No Address Currently',
                              label: 'Address',
                              isCompulsory: false,
                              readOnly: true,
                              borderSide: BorderSide.none,
                              controller: address,
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.45,
                                  child: PageInput(
                                    hint: 'No State Currently',
                                    label: 'State',
                                    textWidth: 0.3,
                                    isCompulsory: false,
                                    readOnly: true,
                                    borderSide: BorderSide.none,
                                    controller: state,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.45,
                                  child: PageInput(
                                    hint: 'No City Currently',
                                    label: 'City',
                                    textWidth: 0.3,
                                    isCompulsory: false,
                                    readOnly: true,
                                    borderSide: BorderSide.none,
                                    controller: city,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: HomeBottomWidget(
                  isHome: false,
                  controller: controller,
                  doubleNavigate: false));
        });
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
