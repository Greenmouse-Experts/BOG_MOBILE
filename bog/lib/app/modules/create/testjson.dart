

// import 'dart:convert';


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_styles.dart';
// import '../../data/model/gen_kyc.dart';
// import '../../data/model/log_in_model.dart';
// import '../../data/providers/my_pref.dart';
// import '../../global_widgets/overlays.dart';
// import '../settings/view_kyc.dart';

// class Teststs extends StatelessWidget {
//   final HomeController controller;
//   const Teststs({super.key, required this.controller});


//   @override
//   Widget build(BuildContext context) {
//     final width = Get.width;
//      final Size size = MediaQuery.of(context).size;
//   double multiplier = 25 * size.height * 0.01;
//     return    SizedBox(
//                   width: Get.width,
//                   child: SingleChildScrollView(
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: width * 0.05, right: width * 0.05),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "Currently logged in as : ",
//                                   style: AppTextStyle.subtitle1.copyWith(
//                                       fontSize: multiplier * 0.08,
//                                       color: Colors.black.withOpacity(.7),
//                                       fontWeight: FontWeight.w500),
//                                   textAlign: TextAlign.start,
//                                 ),
//                                 Text(
//                                   controller.currentType,
//                                   style: AppTextStyle.subtitle1.copyWith(
//                                       fontSize: multiplier * 0.08,
//                                       color: AppColors.primary,
//                                       fontWeight: FontWeight.w500),
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: width * 0.1,
//                           ),
                        
//                           if (controller.currentType != "Client")
//                             SizedBox(
//                               height: Get.height * 0.04,
//                             ),
//                           if (controller.currentType != "Client")
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: width * 0.05, right: width * 0.05),
//                               child: InkWell(
//                                 onTap: () async {
//                                   var kyc = GenKyc.fromJson(
//                                       jsonDecode(MyPref.genKyc.val));
//                                   final oldUser = controller.currentType;
//                                   controller.currentType = "Client";
//                                   controller.update();
//                                   controller.updateNewUser("Client");
//                                   var body = {
//                                     "userType": "private_client",
//                                   };
//                                   AppOverlay.loadingOverlay(
//                                       asyncFunction: () async {
//                                     var response = await controller.userRepo
//                                         .postData("/user/switch-account", body);
//                                     if (response.isSuccessful) {
                                    
//                                       var logInInfo =
//                                           LogInModel.fromJson(response.user);
//                                       MyPref.logInDetail.val =
//                                           jsonEncode(logInInfo);
//                                       print(MyPref.setOverlay.val);
//                                       if ((oldUser == 'Product Partner' ||
//                                               oldUser == 'Service Partner') &&
//                                           (MyPref.setOverlay.val == true)) {
//                                         Get.back();
//                                       }

//                                       Get.back();
//                                     }
//                                   });
//                                 },
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/client_bg.png',
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           width: Get.width * 0.05,
//                                         ),
//                                         Image.asset(
//                                           'assets/images/m2.png',
//                                           width: Get.width * 0.15,
//                                           height: Get.width * 0.15,
//                                         ),
//                                         SizedBox(
//                                           width: Get.width * 0.02,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Client',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                               'Access services and products',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.normal,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           if (controller.currentType != "Service Partner")
//                             SizedBox(
//                               height: Get.height * 0.02,
//                             ),
//                           if (controller.currentType != "Service Partner")
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: width * 0.05, right: width * 0.05),
//                               child: InkWell(
//                                 onTap: () async {
//                                   controller.currentType = "Service Partner";
//                                   controller.update();
//                                   controller.updateNewUser("Service Partner");

//                                   var body = {
//                                     "userType": "professional",
//                                   };

//                                   AppOverlay.loadingOverlay(
//                                       asyncFunction: () async {
//                                     var response = await controller.userRepo
//                                         .postData("/user/switch-account", body);
//                                     if (response.isSuccessful) {
//                                       var logInInfo =
//                                           LogInModel.fromJson(response.user);
//                                       MyPref.logInDetail.val =
//                                           jsonEncode(logInInfo);

//                                       Get.back();
//                                     }
//                                   });
//                                   verifyKycComplete('professional', () {
//                                     Get.to(() => const KYCPage());
//                                   });
//                                 },
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/service_provider.png',
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           width: Get.width * 0.05,
//                                         ),
//                                         Image.asset(
//                                           'assets/images/m1.png',
//                                           width: Get.width * 0.15,
//                                           height: Get.width * 0.15,
//                                         ),
//                                         SizedBox(
//                                           width: Get.width * 0.02,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Service Partner',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                               'Render services to users in need ',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.normal,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           if (controller.currentType != "Product Partner")
//                             SizedBox(
//                               height: Get.height * 0.02,
//                             ),
//                           if (controller.currentType != "Product Partner")
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: width * 0.05, right: width * 0.05),
//                               child: InkWell(
//                                 onTap: () async {
//                                   controller.currentType = "Product Partner";
//                                   controller.update();
//                                   controller.updateNewUser("Product Partner");
//                                   var body = {
//                                     "userType": "vendor",
//                                   };
//                                   AppOverlay.loadingOverlay(
//                                       asyncFunction: () async {
//                                     var response = await controller.userRepo
//                                         .postData("/user/switch-account", body);
//                                     if (response.isSuccessful) {
//                                       var logInInfo =
//                                           LogInModel.fromJson(response.user);
//                                       MyPref.logInDetail.val =
//                                           jsonEncode(logInInfo);

//                                       Get.back();
//                                     }
//                                   });
//                                   verifyKycComplete('vendor', () {
//                                     Get.to(() => const KYCPage());
//                                   });
//                                 },
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/rect3.png',
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           width: Get.width * 0.05,
//                                         ),
//                                         Image.asset(
//                                           'assets/images/m3.png',
//                                           width: Get.width * 0.15,
//                                           height: Get.width * 0.15,
//                                         ),
//                                         SizedBox(
//                                           width: Get.width * 0.02,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Product Partner',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                               'Sell your products online ',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.normal,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           if (controller.currentType != "Corporate Client")
//                             SizedBox(
//                               height: Get.height * 0.02,
//                             ),
//                           if (controller.currentType != "Corporate Client")
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: width * 0.05, right: width * 0.05),
//                               child: InkWell(
//                                 onTap: () async {
//                                   var kyc = GenKyc.fromJson(
//                                       jsonDecode(MyPref.genKyc.val));
//                                   final oldUser = controller.currentType;
//                                   controller.currentType = "Corporate Client";

//                                   controller.update();
//                                   controller.updateNewUser("Corporate Client");

//                                   var body = {
//                                     "userType": "corporate_client",
//                                   };
//                                   AppOverlay.loadingOverlay(
//                                       asyncFunction: () async {
//                                     var response = await controller.userRepo
//                                         .postData("/user/switch-account", body);
//                                     if (response.isSuccessful) {
//                                       // var token = response.token;
//                                       //  MyPref.authToken.val = token.toString();
//                                       var logInInfo =
//                                           LogInModel.fromJson(response.user);
//                                       MyPref.logInDetail.val =
//                                           jsonEncode(logInInfo);

//                                       if ((oldUser == 'Product Partner' ||
//                                               oldUser == 'Service Partner') &&
//                                           MyPref.setOverlay.val == true) {
//                                         Get.back();
//                                       }

//                                       Get.back();
//                                     }
//                                   });

//                                   // if (oldUser == 'Product Partner' ||
//                                   //     oldUser == 'Service Partner' &&
//                                   //         kyc.isKycCompleted != true) {
//                                   //   Get.back();
//                                   // }
//                                   // Get.back();
//                                   // var body = {
//                                   //   "userType": "corporate_client",
//                                   // };
//                                   // var response = await controller.userRepo
//                                   //     .postData("/user/switch-account", body);
//                                 },
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/client_bg.png',
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           width: Get.width * 0.05,
//                                         ),
//                                         Image.asset(
//                                           'assets/images/m2.png',
//                                           width: Get.width * 0.15,
//                                           height: Get.width * 0.15,
//                                         ),
//                                         SizedBox(
//                                           width: Get.width * 0.02,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Corporate Client',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                               'Access services and products',
//                                               style: AppTextStyle.headline4
//                                                   .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.normal,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                         ]),
//                   ),
//                 );
//   }
// }