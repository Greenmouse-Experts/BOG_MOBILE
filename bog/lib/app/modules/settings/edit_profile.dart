import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/home_controller.dart';

import '../../data/model/user_details_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_avatar.dart';

import '../../global_widgets/app_button.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/new_app_bar.dart';
import '../../global_widgets/page_input.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  static const route = '/EditProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String? selectedImg;
  File? pickedImage;

  var logInDetails =
      UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  void initState() {
    firstName.text = logInDetails.fname ?? '';
    lastName.text = logInDetails.lname ?? '';
    email.text = logInDetails.email ?? '';
    phoneNumber.text = logInDetails.phone ?? '';
    address.text = logInDetails.address ?? '';
    state.text = logInDetails.state ?? '';
    city.text = logInDetails.city ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;

    return GetBuilder<HomeController>(
        id: 'EditProfile',
        builder: (controller) {
          return Scaffold(
            appBar: newAppBarBack(context, 'Edit Info'),
            backgroundColor: AppColors.backgroundVariant2,
            body: SizedBox(
              width: Get.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
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
                              selectedImg: selectedImg,
                              name:
                                  "${logInDetails.fname} ${logInDetails.lname}",
                            ),
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();
                              if (result != null) {
                                File file =
                                    File(result.files.single.path.toString());
                                pickedImage = file;
                                setState(() {
                                  selectedImg = file.path;
                                });
                              }
                            },
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
                                fontSize: Get.width * 0.035,
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
                          left: width * 0.03, right: width * 0.03),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.45,
                                  child: PageInput(
                                    hint: '',
                                    label: 'First Name',
                                    textWidth: 0.3,
                                    isCompulsory: true,
                                    controller: firstName,
                                    validator: MinLengthValidator(1,
                                        errorText: 'Enter a valid first name'),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.45,
                                  child: PageInput(
                                    hint: '',
                                    label: 'Last Name',
                                    textWidth: 0.3,
                                    isCompulsory: true,
                                    controller: lastName,
                                    validator: MinLengthValidator(1,
                                        errorText: 'Enter a valid last name'),
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
                              isCompulsory: true,
                              readOnly: true,
                              controller: email,
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            PageInput(
                              hint: '',
                              label: 'Phone Number',
                              validator: Validator.phoneNumValidation,
                              isCompulsory: true,
                              isPhoneNumber: true,
                              controller: phoneNumber,
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            PageInput(
                              hint: 'Enter your address',
                              label: 'Address',
                              isCompulsory: false,
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
                                    hint: 'Enter State',
                                    label: 'State',
                                    textWidth: 0.3,
                                    isCompulsory: false,
                                    controller: state,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.45,
                                  child: PageInput(
                                    hint: 'Enter City',
                                    label: 'City',
                                    textWidth: 0.3,
                                    isCompulsory: false,
                                    controller: city,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            AppButton(
                              title: "Save Changes",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var body = pickedImage == null
                                      ? {
                                          'fname': firstName.text,
                                          "lname": lastName.text,
                                          "phone": phoneNumber.text,
                                          "address": address.text,
                                          "state": state.text,
                                          "city": city.text,
                                        }
                                      : {
                                          'fname': firstName.text,
                                          "lname": lastName.text,
                                          "phone": phoneNumber.text,
                                          "address": address.text,
                                          "state": state.text,
                                          "city": city.text,
                                          "photo": [
                                            await dio.MultipartFile.fromFile(
                                                pickedImage!.path,
                                                filename: pickedImage!.path
                                                    .split('/')
                                                    .last),
                                          ],
                                        };
                                  var formData = dio.FormData.fromMap(body);

                                  final response = await controller.userRepo
                                      .patchData(
                                          '/user/update-account', formData);
                                  if (response.isSuccessful) {
                                    final type =
                                        controller.currentType == 'Client'
                                            ? 'private_client'
                                            : controller.currentType ==
                                                    'Corporate Client'
                                                ? 'corporate_client'
                                                : controller.currentType ==
                                                        'Product Partner'
                                                    ? 'vendor'
                                                    : 'professional';
                                    final newRes = await controller.userRepo
                                        .getData('/user/me?userType=$type');

                                    if (newRes.isSuccessful) {
                                      final userDetails =
                                          UserDetailsModel.fromJson(
                                              newRes.user);
                                      MyPref.userDetails.val =
                                          jsonEncode(userDetails);
                                      Get.back();
                                      Get.back();
                                      Get.snackbar('Success',
                                          'Profile Updated Successfully',
                                          backgroundColor:
                                              AppColors.successGreen,
                                          colorText: AppColors.background);
                                    } else {
                                      Get.snackbar('Error', 'An error occurred',
                                          backgroundColor: Colors.red,
                                          colorText: AppColors.background);
                                    }
                                  } else {
                                    Get.snackbar('Error', 'An error occurred',
                                        backgroundColor: Colors.red,
                                        colorText: AppColors.background);
                                  }
                                }
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
            bottomNavigationBar: HomeBottomWidget(
                isHome: false, controller: controller, doubleNavigate: true),
          );
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
