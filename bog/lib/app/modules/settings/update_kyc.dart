import 'dart:convert';

import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/modules/settings/kyc/financial_data.dart';
import 'package:bog/app/modules/settings/kyc/general_info.dart';
import 'package:bog/app/modules/settings/kyc/job_experience.dart';
import 'package:bog/app/modules/settings/kyc/org_info.dart';
import 'package:bog/app/modules/settings/kyc/supply_category.dart';
import 'package:bog/app/modules/settings/kyc/tax_info.dart';
import 'package:bog/app/modules/settings/kyc/upload_documents.dart';
import 'package:bog/core/utils/extensions.dart';
import 'package:bog/core/utils/http_utils.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/bottom_nav.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/BankListModel.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/page_dropdown.dart';
import '../../global_widgets/page_input.dart';
import '../../global_widgets/tabs.dart';

bool kycPageSetup = false;
Map kycData = {};

class UpdateKyc extends BaseWidget {
  const UpdateKyc({Key? key}) : super(key: key);

  static const route = '/UpdateKyc';

  @override
  State<UpdateKyc> createState() => _UpdateKycState();
}

class _UpdateKycState extends BaseWidgetState<UpdateKyc> {
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

  double kycCompleted = 0;
  @override
  void initState() {
    setup = kycPageSetup;
    calcProgress();
    super.initState();
  }

  @override
  loadItems() {
    performApiCall(context,
        "/kyc/user-kyc/${currentUser.id}?userType=${currentUser.userType}",
        (response, error) {
      if (error != null) {
        if(!setup)setupError = error;
        if (mounted) setState(() {});
        return;
      }


      Map items = response["data"]??{};
      kycData = items;
      calcProgress();

      // printOut("KYC: $kycCount");

      setup=true;
      kycPageSetup = true;
      if (mounted) setState(() {});
    }, getMethod: true, silently: true, handleError: false);
  }

  void calcProgress(){
    int kycCount = 1;
    int kycTotalCount = 1;
    // Map items = response["data"]??{};
    Map items = kycData;
    for(String key in items.keys){
      if(key.startsWith("kyc")){
        kycTotalCount++;
        if(items[key]!=null){
          kycCount++;
        }
      }
    }
    kycCompleted = kycCount/kycTotalCount;
    if(mounted)setState(() {});
  }

  String getPageTitle() => "KYC";

  @override
  Widget page(BuildContext context) {
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           /*   Padding(
                                padding: EdgeInsets.only(
                                    right: width * 0.05,
                                    left: width * 0.045,
                                    top: kToolbarHeight),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "KYC",
                                            style: AppTextStyle.subtitle1
                                                .copyWith(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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

                            addSpace(40),*/
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Complete your KYC",
                                    style: textStyle(true, 18, blackColor),
                                  ),
                                  addSpace(10),
                                  Text(
                                    "Get verified by completing your KYC today",
                                    style: textStyle(false, 12, blackColor),
                                  ),
                                  addSpace(15),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.fromLTRB(10, 20, 10, 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: blackColor.withOpacity(.1),
                                          width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${double.parse("${(kycCompleted)*100}").toStringAsFixed(0)}% done",
                                          style: textStyle(false, 14, red0),
                                        ),
                                        addSpace(5),
                                        Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.zero,
                                          clipBehavior: Clip.antiAlias,
                                          child: Container(
                                            height: 10,
                                            child: LinearProgressIndicator(
                                              value: kycCompleted,
                                              color: red0,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            addSpace(20),
                            kycWidget(Icons.generating_tokens, "General Info",
                                () {
                              launchScreen(context, GeneralInfo(),result: (_){
                                loadItems();
                              });
                            }),
                            kycWidget(Icons.business, "Organizational Info",
                                () {
                              launchScreen(context, OrgInfo(),result: (_){
                                loadItems();
                              });
                            }),
                            kycWidget(Icons.payment, "Tax Details and Permit",
                                () {
                              launchScreen(context, TaxInfo(),result: (_){
                                loadItems();
                              });
                            }),
                            kycWidget(Icons.work, "Work Job Experience", () {
                              launchScreen(context, JobExperience(),result: (_){
                                loadItems();
                              });
                            }),
                            kycWidget(Icons.category, "Category of Supply", () {
                              launchScreen(context, SupplyCategory(),result: (_){
                                loadItems();
                              });
                            }),
                            //1667092852 Access Bank ..Innocent...
                            kycWidget(
                                Icons.monetization_on_sharp, "Financial Data",
                                () {
                              launchScreen(context, FinancialData(),result: (_){
                                loadItems();
                              });
                            }),
                            kycWidget(Icons.file_copy, "Documents Upload", () {
                              launchScreen(context, UploadDocuments(),result: (_){
                                loadItems();
                              });
                            }),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: AppButton(
                        title: "Submit KYC",
                        onPressed: () async {
                          // if(formKey.currentState!.validate()){
                          //
                          // }
                          performApiCall(
                              context,
                              "/kyc/user-kyc/${currentUser.id}?userType=${currentUser.userType}",
                              (response, error) {},
                              getMethod: true);
                        },
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: bottomNav(),
            );
          }),
    );
  }

  Widget kycWidget(dynamic icon, String title, onClick) {
    return Container(
      // height: 40,
      width: double.infinity,
      child: TextButton(
          onPressed: () {
            onClick();
          },
          style: TextButton.styleFrom(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: default_white, shape: BoxShape.circle),
                child: imageItem(icon, 18, null),
                // child: Image.asset("circle_user".png,height: 16,),
              ),
              addSpaceWidth(10),
              Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    title,
                    style: textStyle(true, 16, blackColor),
                  )),
              Icon(
                Icons.navigate_next,
                color: blackColor,
              )
            ],
          )),
    );
  }
}
