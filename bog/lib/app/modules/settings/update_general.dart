import 'dart:async';
import 'dart:convert';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/general_info_model.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/role_model.dart';
import '../../data/model/user_details_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_drop_down_button.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/app_radio_button.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';

String convertToTitleCase(String input) {
  List<String> words = input.split('_');
  String result = '';

  for (String word in words) {
    result += '${word.substring(0, 1).toUpperCase()}${word.substring(1)} ';
  }

  return result.trim();
}

String convertToUnderscoreCase(String input) {
  List<String> words = input.split(' ');
  String result = '';

  for (int i = 0; i < words.length; i++) {
    result += words[i].toLowerCase();
    if (i < words.length - 1) {
      result += '_';
    }
  }

  return result;
}

class UpdateGeneralInfo extends StatefulWidget {
  final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const UpdateGeneralInfo(
      {super.key, required this.kycScore, required this.kycTotal});

  @override
  State<UpdateGeneralInfo> createState() => _UpdateGeneralInfoState();
}

class _UpdateGeneralInfoState extends State<UpdateGeneralInfo> {
  late Future<ApiResponse> getGenrealInfo;
  final _formKey = GlobalKey<FormState>();

  String? initialNumber;
  String? certOption;

  String removeCountryCode(String phoneNumber, String countryCode) {
    if (phoneNumber.startsWith(countryCode)) {
      return phoneNumber.substring(countryCode.length);
    } else {
      return phoneNumber; // Country code not found, return the original number
    }
  }

  List<RoleModel> roleModelssa = [
    RoleModel(name: "Quantity Surveyor", certifications: [
      "HND, MNIQS, RQS",
      "PGD, MNIQS, RQS",
      "B.Sc, MNIQS, RQS",
      "M.Sc, MNIQS, RQS",
      "Ph.D, MNIQS, RQS"
    ]),
    RoleModel(name: "Structural Engineer", certifications: [
      "HND, COREN",
      "PGD, COREN",
      "B.Sc, COREN",
      "M.Sc, COREN",
      "Ph.D, COREN",
    ]),
    RoleModel(name: "Architects", certifications: [
      "HND, ATECH",
      "PGD, ATECH",
      "B.Sc, G.M.NIA",
      "M.Sc, A.M.NIA,/MNIA",
      "Ph.D, MNIA"
    ]),
    RoleModel(name: "Mechanical Engineer", certifications: [
      "HND, PGD, B.Sc, M.Sc, Ph.D",
      "PGD, MNIMECHE",
      "B.Sc, MNIMECHE",
      "M.Sc, MNIMECHE",
      "Ph.D, MNIMECHE",
    ]),
    RoleModel(name: "Electrical Engineer", certifications: [
      "HND, COREN",
      "PGD, COREN",
      "B.Sc, COREN",
      "M.Sc, COREN",
      "Ph.D, COREN",
    ]),
    RoleModel(name: "Surveyor", certifications: [
      "HND, MNIS",
      "PGD, MNIS",
      "B.Sc, MNIS",
      "M.Sc, MNIS",
      "Ph.D, MNIS",
    ]),
    RoleModel(name: "Civil Engineer", certifications: [
      "HND, COREN",
      "PGD, COREN",
      "B.Sc, COREN",
      "M.Sc, COREN",
      "Ph.D, COREN",
    ])
  ];

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      width: 1,
      color: const Color(0xFF828282).withOpacity(.3),
    ),
  );

  final controller = Get.find<HomeController>();

  List<String> experienceYears = ["3-5", "6-10", "11-15", "16-20", "Over 20"];
  late List<String> roleOptions;
  List<String> certificateOptions = [];

  TextEditingController nameOfOrgController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController typeOfRegController = TextEditingController();
  TextEditingController officeTelController = TextEditingController();
  TextEditingController officeTelController2 = TextEditingController();
  TextEditingController regNumController = TextEditingController();
  TextEditingController busAddressController = TextEditingController();
  TextEditingController otherAddressController = TextEditingController();
  TextEditingController otherEmail = TextEditingController();
  late TextEditingController roleCoontroller;
  TextEditingController yearsController = TextEditingController();
  TextEditingController certificationController = TextEditingController();
  late String userType;
  String newRegType = '';

  //StreamController<ApiResponse> _formController = StreamController<ApiResponse>();
  @override
  void initState() {
    final controller = Get.find<HomeController>();
    roleCoontroller = controller.roleCoontroller;
    roleOptions = [];
    for (var i in roleModelssa) {
      roleOptions.add(i.name);
    }
    var logInDetails =
        UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));
    emailController.text = logInDetails.email ?? "";
    nameOfOrgController.text = logInDetails.profile?.companyName ?? "";

    var unformattedPhone = logInDetails.phone ?? "";
    initialNumber = unformattedPhone;
    // if (unformattedPhone.startsWith("+")) {
    //   unformattedPhone = unformattedPhone.substring(1);
    // }
    // const countryList = countries;
    // final selectedCountry = countries.firstWhere(
    //     (country) => unformattedPhone.startsWith(country.dialCode),
    //     orElse: () => countryList.first);

    // final formattedPhone =
    //     removeCountryCode(unformattedPhone, selectedCountry.dialCode);

    roleCoontroller.text = roleModelssa[0].name;
    for (var i in roleModelssa[0].certifications) {
      certificateOptions.add(i);
    }
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getGenrealInfo = controller.userRepo
        .getData('/kyc-general-info/fetch?userType=$userType');

    super.initState();
  }

  updateRole(String newVal, bool isNew) {
    if (!isNew) {
      setState(() {
        roleCoontroller.text = newVal;
        //  certificateOptions.clear();
        final sosoo =
            roleModelssa.firstWhere((element) => element.name == newVal);
        certificateOptions = sosoo.certifications;
      });
    } else {
      roleCoontroller.text = newVal;

      final sosoo =
          roleModelssa.firstWhere((element) => element.name == newVal);
      certificateOptions = sosoo.certifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = ['Incorporation', 'Registered Business Name'];

    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    return AppBaseView(
        child: Scaffold(
            appBar: newAppBarBack(context, 'General Info'),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<ApiResponse>(
                      future: getGenrealInfo,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data!.isSuccessful) {
                          if (snapshot.data!.data != null) {
                            final response = snapshot.data!.data;
                            final genData = GeneralInfoModel.fromJson(response);

                            nameOfOrgController.text =
                                genData.organisationName ?? '';
                            emailController.text = genData.emailAddress ?? '';
                            typeOfRegController.text = genData.regType ?? '';
                            yearsController.text =
                                genData.yearsOfExperience ?? "";
                            officeTelController.text =
                                genData.contactNumber.toString();
                            otherEmail.text = genData.operationalEmail ?? "";
                            officeTelController2.text =
                                genData.contactNumber2 ?? "";
                            certOption = genData.certificationOfPersonnel;
                            certificationController.text =
                                genData.certificationOfPersonnel ?? "";
                            if (genData.role != null) {
                              //  final paos = convertToTitleCase(genData.role!);
                              updateRole(
                                  convertToTitleCase(genData.role!), true);
                            }
                            regNumController.text =
                                genData.registrationNumber.toString();
                            busAddressController.text =
                                genData.businessAddress ?? '';
                            otherAddressController.text =
                                genData.operationalAddress ?? '';
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  PageInput(
                                    hint: '',
                                    label: 'Name of Organization',
                                    validator: MinLengthValidator(3,
                                        errorText:
                                            'Enter a Valid Organization Name'),
                                    controller: nameOfOrgController,
                                  ),
                                  const SizedBox(height: 10),
                                  PageInput(
                                    hint: '',
                                    label: 'Email Address',
                                    controller: emailController,
                                    //    initialValue: orgData.emailAddress,
                                    validator: EmailValidator(
                                        errorText:
                                            'Enter a valid email address'),
                                  ),
                                  const SizedBox(height: 10),
                                  AppRadioButton(
                                    onchanged: (value) {
                                      newRegType = value;
                                    },
                                    option1: 'Incorporation',
                                    options: options,
                                    label: 'Type of Registration',
                                  ),
                                  const SizedBox(height: 10),
                                  PageInput(
                                    hint: '',
                                    label: 'Office Telephone',
                                    controller: officeTelController,
                                    keyboardType: TextInputType.phone,
                                    isPhoneNumber: true,
                                    validator: Validator.phoneNumValidation,
                                  ),
                                  if (userType == "professional")
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        AppDropDownButton(
                                          onChanged: (value) {
                                            roleCoontroller.text = value;

                                            //  final paos = convertToTitleCase(genData.role!);
                                            //
                                            // certificateOptions.clear();
                                            // for (var i in roleModelssa) {
                                            //   print(i.name);
                                            //   print(i.certifications);
                                            // }
                                            setState(() {
                                              //      print(value);

                                              final sosoo = roleModelssa
                                                  .firstWhere((element) {
                                                //  print(element.name);
                                                return element.name ==
                                                    value.toString();
                                              });
                                              //  print(sosoo.name);

                                              certificateOptions =
                                                  sosoo.certifications;
                                              // print(certificateOptions);
                                              // for (var i
                                              //     in sosoo.certifications) {
                                              //   certificateOptions.add(i);
                                              // }
                                            });
                                          },
                                          options: roleOptions,
                                          value: roleCoontroller.text,
                                          label: 'Type of organisation',
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text("Certificate",
                                                    style: AppTextStyle
                                                        .bodyText2
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ]),
                                        const SizedBox(height: 10),
                                        DropdownButtonFormField<String>(
                                            value: certOption ??
                                                (certificateOptions.isNotEmpty
                                                    ? certificateOptions[0]
                                                    : null),
                                            decoration: InputDecoration(
                                              enabledBorder: outlineInputBorder,
                                              border: outlineInputBorder,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                            ),
                                            onChanged: (String? newValue) {
                                              certificationController.text =
                                                  newValue ?? "";
                                            },
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            style: AppTextStyle.bodyText2
                                                .copyWith(color: Colors.black),
                                            items: certificateOptions
                                                .map((String certification) {
                                              return DropdownMenuItem<String>(
                                                value: certification,
                                                child: Text(
                                                  certification,
                                                  style: AppTextStyle.bodyText2
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              );
                                            }).toList()),

                                        const SizedBox(height: 10),
                                        AppDropDownButton(
                                            options: experienceYears,
                                            onChanged: (String value) {
                                              yearsController.text = value;
                                            },
                                            label: "Years of Experience"),
                                        const SizedBox(height: 10),
                                        // AppDropDownButton(
                                        //   onChanged: (value) {
                                        //     certificationController.text =
                                        //         value;
                                        //   },

                                        //   //    value: certificateOptions[0],
                                        //   options: certificateOptions,
                                        //   label: 'Certification of Personnel',
                                        // ),
                                        // const SizedBox(height: 10),
                                      ],
                                    ),
                                  PageInput(
                                    hint: '',
                                    label: 'Registration Number',
                                    controller: regNumController,
                                    //  initialValue:
                                    //     orgData.registrationNumber.toString(),
                                    keyboardType: TextInputType.number,
                                    validator: MinLengthValidator(1,
                                        errorText:
                                            'Enter a valid registration number'),
                                  ),
                                  const SizedBox(height: 10),
                                  PageInput(
                                    hint: '',
                                    label: 'Business Address',
                                    controller: busAddressController,
                                    //      initialValue: orgData.businessAddress,
                                    validator: MinLengthValidator(6,
                                        errorText: 'Enter a valid address'),
                                  ),
                                  const SizedBox(height: 10),
                                  PageInput(
                                    hint: '',
                                    label: 'Other Significant Address',
                                    controller: otherAddressController,
                                    isTextArea: true,
                                    //    initialValue: orgData.operationalAddress,
                                  ),
                                  const SizedBox(height: 10),
                                  PageInput(
                                    hint: '',
                                    label: 'Other Telephone',
                                    controller: officeTelController2,
                                    keyboardType: TextInputType.phone,
                                    isPhoneNumber: true,
                                  ),
                                  const SizedBox(height: 10),
                                  PageInput(
                                    hint: '',
                                    label: 'Other Email',
                                    controller: otherEmail,
                                    isTextArea: false,
                                    //    initialValue: orgData.operationalAddress,
                                  ),
                                  AppButton(
                                    title: 'Submit',
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final newGeneralInfo = {
                                          "organisation_name":
                                              nameOfOrgController.text,
                                          "email_address": emailController.text,
                                          "certification_of_personnel":
                                              certificationController.text,
                                          "role": convertToUnderscoreCase(
                                              roleCoontroller.text),
                                          "contact_number": int.parse(
                                              officeTelController.text),
                                          "reg_type": newRegType,
                                          "registration_number":
                                              int.parse(regNumController.text),
                                          "business_address":
                                              busAddressController.text,
                                          "operational_address":
                                              otherAddressController.text,
                                          "userI": logInDetails.profile!.id,
                                          "years_of_experience":
                                              yearsController.text,
                                          "id": logInDetails.profile!.id,
                                          "userType": userType,
                                          "contact_number_2":
                                              officeTelController2.text,
                                          "operational_email_tel":
                                              otherEmail.text,
                                        };

                                        final kycScore = widget.kycScore;

                                        kycScore['generalInfo'] = 7;
                                        final controller =
                                            Get.find<HomeController>();
                                        final updateAccount = await controller
                                            .userRepo
                                            .patchData('/user/update-account', {
                                          "kycScore": jsonEncode(kycScore),
                                          "kycTotal":
                                              jsonEncode(widget.kycTotal)
                                        });
                                        final res = await controller.userRepo
                                            .postData(
                                                '/kyc-general-info/create',
                                                newGeneralInfo);
                                        // final res = await Api().postData(
                                        //     '/kyc-general-info/create/',
                                        //     body: newGeneralInfo);

                                        if (res.isSuccessful &&
                                            updateAccount.isSuccessful) {
                                          MyPref.setOverlay.val = false;
                                          AppOverlay.successOverlay(
                                              message:
                                                  'General Info Updated Successfully');
                                        } else {
                                          Get.snackbar('Error',
                                              res.message ?? 'Error Occured',
                                              colorText:
                                                  AppColors.backgroundVariant1,
                                              backgroundColor: Colors.red);
                                        }
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 25)
                                ],
                              ),
                            ),
                          );
                        } else {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const Center(
                              child: Text('Network Error Occurred'),
                            );
                          }
                          return const AppLoader();
                        }
                      })
                ],

                // SingleChildScrollView(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       FutureBuilder<ApiResponse>(
                //           future: getGenrealInfo,
                //           builder: (context, snapshot) {
                //             if (snapshot.connectionState == ConnectionState.done &&
                //                 snapshot.data!.isSuccessful) {
                //               if (snapshot.data!.data == null) {
                //                 return Padding(
                //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //                   child: Form(
                //                     key: _formKey,
                //                     child: Column(
                //                       children: [
                //                         PageInput(
                //                           hint: '',
                //                           label: 'Name of Organization',
                //                           validator: MinLengthValidator(3,
                //                               errorText:
                //                                   'Enter a Valid Organization Name'),
                //                           controller: nameOfOrgController,
                //                         ),
                //                         const SizedBox(height: 10),
                //                         PageInput(
                //                           hint: '',
                //                           label: 'Email Address',
                //                           controller: emailController,
                //                           //    initialValue: orgData.emailAddress,
                //                           validator: EmailValidator(
                //                               errorText: 'Enter a valid email address'),
                //                         ),
                //                         const SizedBox(height: 10),
                //                         AppRadioButton(
                //                           onchanged: (value) {
                //                             newRegType = value;
                //                           },
                //                           option1: 'Incorporation',
                //                           options: options,
                //                           label: 'Type of Registration',
                //                         ),
                //                         const SizedBox(height: 10),
                //                         PageInput(
                //                           hint: '',
                //                           label: 'Office Telephone',
                //                           controller: officeTelController,
                //                           keyboardType: TextInputType.phone,
                //                           isPhoneNumber: true,
                //                           validator: Validator.phoneNumValidation,
                //                         ),
                //                         const SizedBox(height: 10),
                //                         PageInput(
                //                           hint: '',
                //                           label: 'Registration Number',
                //                           controller: regNumController,
                //                           //  initialValue:
                //                           //     orgData.registrationNumber.toString(),
                //                           keyboardType: TextInputType.number,
                //                           validator: MinLengthValidator(1,
                //                               errorText:
                //                                   'Enter a valid registration number'),
                //                         ),
                //                         const SizedBox(height: 10),
                //                         PageInput(
                //                           hint: '',
                //                           label: 'Business Address',
                //                           controller: busAddressController,
                //                           //      initialValue: orgData.businessAddress,
                //                           validator: MinLengthValidator(6,
                //                               errorText: 'Enter a valid address'),
                //                         ),
                //                         const SizedBox(height: 10),
                //                         PageInput(
                //                           hint: '',
                //                           label: 'Other Significant Address',
                //                           controller: otherAddressController,
                //                           isTextArea: true,
                //                           //    initialValue: orgData.operationalAddress,
                //                         ),
                //                         const SizedBox(height: 15),
                //                         AppButton(
                //                           title: 'Submit',
                //                           onPressed: () async {
                //                             if (_formKey.currentState!.validate()) {
                //                               final newGeneralInfo = {
                //                                 "organisation_name":
                //                                     nameOfOrgController.text,
                //                                 "email_address": emailController.text,
                //                                 "contact_number":
                //                                     int.parse(officeTelController.text),
                //                                 "reg_type": newRegType,
                //                                 "registration_number":
                //                                     int.parse(regNumController.text),
                //                                 "business_address":
                //                                     busAddressController.text,
                //                                 "operational_address":
                //                                     otherAddressController.text,
                //                                 "id": logInDetails.profile!.id,
                //                                 "userType": userType
                //                               };

                //                               final kycScore = widget.kycScore;

                //                               kycScore['generalInfo'] = 7;

                //                               final controller =
                //                                   Get.find<HomeController>();
                //                               final updateAccount = await controller
                //                                   .userRepo
                //                                   .patchData('/user/update-account', {
                //                                 "kycScore": jsonEncode(kycScore),
                //                                 "kycTotal": jsonEncode(widget.kycTotal)
                //                               });
                //                               print('na here');
                //                               final res = await controller.userRepo
                //                                   .postData('/kyc-general-info/create',
                //                                       newGeneralInfo);
                //                               if (res.isSuccessful &&
                //                                   updateAccount.isSuccessful) {
                //                                 MyPref.setOverlay.val = false;
                //                                 AppOverlay.successOverlay(
                //                                     message:
                //                                         'General Info Updated Successfully');
                //                               } else {
                //                                 Get.snackbar('Error',
                //                                     res.message ?? 'Error Occured',
                //                                     colorText:
                //                                         AppColors.backgroundVariant1,
                //                                     backgroundColor: Colors.red);
                //                               }
                //                             }
                //                           },
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 );
                //               }
                //               final response = snapshot.data!.data;
                //               final orgData = GeneralInfoModel.fromJson(response);

                //               nameOfOrgController.text = orgData.organisationName ?? '';
                //               emailController.text = orgData.emailAddress ?? '';
                //               officeTelController.text = orgData.contactNumber.toString();
                //               regNumController.text =
                //                   orgData.registrationNumber.toString();
                //               busAddressController.text = orgData.businessAddress ?? '';
                //               otherAddressController.text =
                //                   orgData.operationalAddress ?? '';

                //               return Padding(
                //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //                 child: Form(
                //                   key: _formKey,
                //                   child: Column(
                //                     children: [
                //                       PageInput(
                //                         hint: '',
                //                         label: 'Name of Organization',
                //                         //    initialValue: orgData.organisationName,
                //                         validator: MinLengthValidator(3,
                //                             errorText: 'Enter a Valid Organization Name'),
                //                         controller: nameOfOrgController,
                //                       ),
                //                       const SizedBox(height: 10),
                //                       PageInput(
                //                         hint: '',
                //                         label: 'Email Address',
                //                         controller: emailController,
                //                         //    initialValue: orgData.emailAddress,
                //                         validator: EmailValidator(
                //                             errorText: 'Enter a valid email address'),
                //                       ),
                //                       const SizedBox(height: 10),
                //                       AppRadioButton(
                //                         onchanged: (value) {
                //                           orgData.regType = value;
                //                         },
                //                         option1: orgData.regType ?? '',
                //                         options: options,
                //                         label: 'Type of Registration',
                //                       ),
                //                       const SizedBox(height: 10),
                //                       PageInput(
                //                           hint: '',
                //                           label: 'Office Telephone',
                //                           controller: officeTelController,
                //                           keyboardType: TextInputType.phone,
                //                           isPhoneNumber: true,
                //                           validator: Validator.phoneNumValidation),
                //                       const SizedBox(height: 10),
                //                       PageInput(
                //                         hint: '',
                //                         label: 'Registration Number',
                //                         controller: regNumController,
                //                         //  initialValue:
                //                         //     orgData.registrationNumber.toString(),
                //                         keyboardType: TextInputType.number,
                //                         validator: MinLengthValidator(1,
                //                             errorText:
                //                                 'Enter a valid registration number'),
                //                       ),
                //                       const SizedBox(height: 10),
                //                       PageInput(
                //                         hint: '',
                //                         label: 'Business Address',
                //                         controller: busAddressController,
                //                         //      initialValue: orgData.businessAddress,
                //                         validator: MinLengthValidator(6,
                //                             errorText: 'Enter a valid address'),
                //                       ),
                //                       const SizedBox(height: 10),
                //                       PageInput(
                //                         hint: '',
                //                         label: 'Other Significant Address',
                //                         controller: otherAddressController,
                //                         isTextArea: true,
                //                         //    initialValue: orgData.operationalAddress,
                //                       ),
                //                       const SizedBox(height: 15),
                //                       AppButton(
                //                         title: 'Submit',
                //                         onPressed: () async {
                //                           if (_formKey.currentState!.validate()) {
                //                             final newGeneralInfo = {
                //                               "organisation_name":
                //                                   nameOfOrgController.text,
                //                               "email_address": emailController.text,
                //                               "contact_number": officeTelController.text,
                //                               "reg_type": orgData.regType,
                //                               "registration_number":
                //                                   int.parse(regNumController.text),
                //                               "business_address":
                //                                   busAddressController.text,
                //                               "operational_address":
                //                                   otherAddressController.text,
                //                               "id": logInDetails.profile!.id,
                //                               "userType": userType
                //                             };
                //                             final kycScore = widget.kycScore;

                //                             kycScore['generalInfo'] = 7;

                //                             final controller = Get.find<HomeController>();
                //                             print(controller.cartLength);

                //                             final updateAccount = await controller
                //                                 .userRepo
                //                                 .patchData('/user/update-account', {
                //                               "kycScore": jsonEncode(kycScore),
                //                               "kycTotal": jsonEncode(widget.kycTotal)
                //                             });
                //                             print('no be here');
                //                             // final res = await HttpClient.post(
                //                             //     '/kyc-general-info/create',
                //                             //     newGeneralInfo);
                //                             final res = await controller.userRepo
                //                                 .postData('/kyc-general-info/create',
                //                                     newGeneralInfo);
                //                             if ((res.isSuccessful) &&
                //                                 updateAccount.isSuccessful) {
                //                               MyPref.setOverlay.val = false;
                //                               AppOverlay.successOverlay(
                //                                   message:
                //                                       'General Info Updated Successfully');
                //                             } else {
                //                               Get.snackbar('Error',
                //                                   res.message ?? 'An error occurred',
                //                                   colorText: AppColors.backgroundVariant1,
                //                                   backgroundColor: Colors.red);
                //                             }
                //                           }
                //                         },
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             } else {
                //               if (snapshot.connectionState == ConnectionState.done) {
                //                 return const Center(
                //                   child: Text('Network Error Occurred'),
                //                 );
                //               }
                //               return const AppLoader();
                //             }
                //           })
                //     ],
                //   ),
                // ),
              ),
            )));
  }
}
