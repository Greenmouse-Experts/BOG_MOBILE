import 'dart:convert';

import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/modules/settings/kyc/job_experience.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/extensions.dart';
import 'package:bog/core/utils/http_utils.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/click_text.dart';
import 'package:bog/core/widgets/custom_expandable.dart';
import 'package:bog/core/widgets/date_picker_widget.dart';
import 'package:bog/core/widgets/file_picker_widget.dart';
import 'package:bog/core/widgets/input_text_field.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SupplyCategory extends BaseWidget {

  static const route = '/SupplyCategory';

  @override
  State<SupplyCategory> createState() => _SupplyCategoryState();
}

class _SupplyCategoryState extends BaseWidgetState<SupplyCategory> with InputMixin {

  bool showCancel = false;
  FocusNode focusSearch = FocusNode();
  TextEditingController searchController = TextEditingController();

  Map setupData = {};
  List selections = [];

  @override
  void initState() {
    setup=false;
    super.initState();
    focusSearch.addListener(() { setState(() {});});
  }

  loadItems(){
    // kyc-tax-permits/fetch?userType=vendor
    performApiCall(context, "/kyc-supply-category/fetch?userType=professional", (response, error){
      if(error!=null){
        setupError=error;
        if(mounted)setState(() {});
        return;
      }

      setupData = response["data"]??{};
      allItemList = setupData["categories"]??[];
      runSearch();
      setupModels();
      setup=true;
      if(mounted)setState(() {});

    },getMethod: true,handleError: false,silently: true);
  }

  void setupModels(){
    inputModels.add(InputTextFieldModel(
        "Others (Specify below)",
        hint: "Enter the category of supply",optional: true
    ));
  }

  runSearch() {
    String search = searchController.text.trim();
    itemList.clear();
    for (String text in allItemList) {

      if (search.isNotEmpty &&
          !text.toLowerCase().contains(search.toLowerCase())) continue;
      itemList.add(text);
    }

    setup = true;
    setState(() {});
  }

  // showAppBar()=>!setup;

  @override
  String getPageTitle() =>"Category of Supply";

  @override
  Widget page(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    // double multiplier = 25 * size.height * 0.01;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'SupplyCategory',
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
                            if(false)Padding(
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
                                          "Category of Supply",
                                          style: AppTextStyle.subtitle1
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
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
                            addSpace(40),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text("Choose the category you supply or offer",style: textStyle(true, 16, blackColor),)),

                                  Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: whiteColor4.withOpacity(.5),
                                        border:
                                        Border.all(
                                            // bottom: BorderSide(
                                                color: focusSearch
                                                    .hasFocus
                                                    ? blue0
                                                    : blackColor.withOpacity(.05),
                                                width: focusSearch
                                                    .hasFocus
                                                    ? 2
                                                    : 1),borderRadius: BorderRadius.circular(10)//)
                                  ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        addSpaceWidth(10),
                                        Icon(
                                          Icons.search,
                                          color: blackColor
                                              .withOpacity(
                                              focusSearch.hasFocus
                                                  ? 1
                                                  : (.5)),
                                          size: 17,
                                        ),
                                        addSpaceWidth(10),
                                        Flexible(
                                          flex: 1,
                                          child: TextField(
                                            textInputAction:
                                            TextInputAction.search,
                                            textCapitalization:
                                            TextCapitalization
                                                .sentences,
                                            autofocus: false,
                                            onSubmitted: (_) {
                                              runSearch();
                                            },
                                            decoration: InputDecoration(
                                                hintText: "Search the keyword",
                                                hintStyle: textStyle(
                                                  false,
                                                  14,
                                                  blackColor
                                                      .withOpacity(.2),
                                                ),
                                                border: InputBorder.none,
                                                isDense: true),
                                            style: textStyle(false, 16,
                                                blackColor),
                                            controller: searchController,
                                            cursorColor: blackColor,
                                            cursorWidth: 1,
                                            focusNode: focusSearch,
                                            keyboardType:
                                            TextInputType.text,
                                            onChanged: (s) {
                                              showCancel =
                                                  s.trim().isNotEmpty;
                                              setState(() {});
                                              runSearch();
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showCancel = false;
                                              searchController.text = "";
                                            });
                                            runSearch();
                                          },
                                          child: showCancel
                                              ? const Padding(
                                            padding:
                                            EdgeInsets
                                                .fromLTRB(
                                                0, 0, 15, 0),
                                            child: Icon(
                                              Icons.close,
                                              color: red0,
                                              size: 20,
                                            ),
                                          )
                                              : Container(),
                                        )
                                      ],
                                    ),
                                  ),

                                  addSpace(20),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text("Categories (${itemList.length})",style: textStyle(false, 14, blackColor.withOpacity(.5)),)),


                                  Container(width: double.infinity,
                                    child: Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.start,
                                      children: List.generate(itemList.length, (index){

                                        String name = itemList[index];
                                        bool selected = selections.contains(name);
                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              if(!selected){
                                                selections.add(name);
                                              }else{
                                                selections.remove(name);
                                              }
                                            });
                                          },
                                          child: AnimatedContainer(duration: Duration(milliseconds: 300),
                                            margin: EdgeInsets.fromLTRB(0, 0, 10, 15),
                                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                            decoration: BoxDecoration(
                                             border: Border.all(
                                               color: blackColor,width: 1
                                             ),borderRadius: BorderRadius.circular(5),color: selected?blue0:whiteColor
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if(selected)Container(margin: EdgeInsets.only(right: 5),
                                                child: Icon(Icons.check_circle,color: white,size: 12,),),
                                                Text(name,style: textStyle(false, 14, selected?white:black),),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  
                                  addSpace(20),

                                  InputTextField(
                                      inputTextFieldModel: inputModels[0]),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    addSpace(20),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: AppButton(
                        title: "Save",
                        onPressed: () async {
                          Map studs = {};
                          bool proceed = validateInputModels(studs: studs);
                          if (proceed) {

                            String others = inputModels[0].text;

                            performApiCallWithDIO(context, "/kyc-supply-category/create", (response, error){

                              showSuccessDialog(context, "Supply Category Updated",onOkClicked: (){
                                Navigator.pop(context);
                              });

                            },data: {
                              "categories": "${selections}",
                              "userType": currentUser.userType,
                              "others":others,
                            });

                          }

                        },
                      ),
                    )
                  ],
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
                      label: 'Message',
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
