import 'dart:convert';

// import 'package:bog/app/modules/home/home.dart';
import 'package:bog/app/data/model/get_account_model.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:bog/app/global_widgets/switch_widget.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/gen_kyc.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/overlays.dart';

class SwitchUser extends StatefulWidget {
  const SwitchUser({Key? key}) : super(key: key);

  static const route = '/create';

  @override
  State<SwitchUser> createState() => _SwitchUserState();
}

class _SwitchUserState extends State<SwitchUser> {
  late Future<ApiResponse> getAccounts;

  final width = Get.width;
  final height = Get.height;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getAccounts = controller.userRepo.getData('/user/get-accounts');
    super.initState();
  }

  void verifyKycComplete(String type, VoidCallback onPressed) async {
    final controller = Get.find<HomeController>();
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    final res = await controller.userRepo
        .getData('/kyc/user-kyc/${logInDetails.id}?userType=$type');

    final kyc = GenKyc.fromJson(res.data);
    MyPref.genKyc.val = jsonEncode(kyc);
    MyPref.genKyc.val = jsonEncode(kyc);

    if (kyc.isKycCompleted != true) {
      MyPref.setOverlay.val = true;
      AppOverlay.showKycDialog(
          title: 'Kyc Not Complete',
          buttonText: 'Complete KYC',
          content:
              "You haven't completed your KYC yet, Kindly Complete your KYC now",
          onPressed: onPressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Switch',
          builder: (controller) {
            return Scaffold(
                appBar: newAppBar(context, 'Switch', true),
                backgroundColor: AppColors.backgroundVariant2,
                body: FutureBuilder<ApiResponse>(
                    future: getAccounts,
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Center(
                                  child: Text('An error occured'),
                                )
                              ],
                            ),
                          );
                        } else {
                          final response =
                              snapshot.data!.accounts as List<dynamic>;
                          final accountTypes = <GetAccountModel>[];
                          final newAccountTypes = <GetAccountModel>[];
                          for (var element in response) {
                            accountTypes.add(GetAccountModel.fromJson(element));
                          }
                          for (GetAccountModel element in accountTypes) {
                            final newElement = GetAccountModel(
                                id: element.id,
                                userId: element.userId,
                                userType: element.userType == 'private_client'
                                    ? 'Client'
                                    : element.userType == 'corporate_client'
                                        ? 'Corporate Client'
                                        : element.userType == 'vendor'
                                            ? 'Product Partner'
                                            : 'Service Partner');
                            newAccountTypes.add(newElement);
                          }

                          final finalAccountTypes = newAccountTypes
                              .where((element) =>
                                  controller.currentType != element.userType!)
                              .toList();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: newAccountTypes.length,
                                  itemBuilder: (ctx, i) {
                                    return controller.currentType ==
                                            newAccountTypes[i].userType!
                                        ? MainSwitchWidget(
                                            accountType:
                                                newAccountTypes[i].userType ??
                                                    '')
                                        : const SizedBox.shrink();
                                  }),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.05, right: width * 0.05),
                                child: Text(
                                  "Switch To :",
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: multiplier * 0.08,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              finalAccountTypes.isEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              'You have no other accounts',
                                              style: AppTextStyle.bodyText2,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: newAccountTypes.length,
                                  itemBuilder: (ctx, i) {
                                    return controller.currentType ==
                                            newAccountTypes[i].userType!
                                        ? const SizedBox.shrink()
                                        : PrimarySwitchWidget(
                                            sendType: accountTypes[i].userType!,
                                            iconAsset: newAccountTypes[i]
                                                        .userType ==
                                                    'Client'
                                                ? 'assets/images/m2.png'
                                                : newAccountTypes[i].userType ==
                                                        'Corporate Client'
                                                    ? 'assets/images/m2.png'
                                                    : newAccountTypes[i]
                                                                .userType ==
                                                            'Product Partner'
                                                        ? 'assets/images/m3.png'
                                                        : 'assets/images/m1.png',
                                            backgroundAsset: newAccountTypes[i]
                                                        .userType ==
                                                    'Client'
                                                ? 'assets/images/client_bg.png'
                                                : newAccountTypes[i].userType ==
                                                        'Corporate Client'
                                                    ? 'assets/images/client_bg.png'
                                                    : newAccountTypes[i]
                                                                .userType ==
                                                            'Product Partner'
                                                        ? 'assets/images/rect3.png'
                                                        : 'assets/images/service_provider.png',
                                            newCurrentType:
                                                newAccountTypes[i].userType!,
                                            detail: newAccountTypes[i]
                                                        .userType ==
                                                    'Client'
                                                ? 'Access services and products'
                                                : newAccountTypes[i].userType ==
                                                        'Corporate Client'
                                                    ? 'Access services and products'
                                                    : newAccountTypes[i]
                                                                .userType ==
                                                            'Product Partner'
                                                        ? 'Sell your products online'
                                                        : 'Render services to users in need',
                                          );
                                  }),
                            ],
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const AppLoader();
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(
                              child: Text('An error occured'),
                            )
                          ],
                        );
                      }
                    }),
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
