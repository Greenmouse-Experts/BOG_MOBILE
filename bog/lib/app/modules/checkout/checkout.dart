import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
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
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/page_input.dart';
import '../../global_widgets/tabs.dart';
import '../home/pages/CartTab.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  static const route = '/Checkout';

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var currentPos = 0;
  var homeController = Get.find<HomeController>();
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();
  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var formKey3 = GlobalKey<FormState>();
  var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));

  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zip = TextEditingController();
  TextEditingController country = TextEditingController();

  TextEditingController bank = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController cvv = TextEditingController();


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
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<HomeController>(
          id: 'Checkout',
          builder: (controller) {
            var imageString = "assets/images/Group 47538.png";
            if(currentPos == 0) {
              imageString = "assets/images/Group 47538.png";
            } else if(currentPos == 1) {
              imageString = "assets/images/Group 47539.png";
            } else if(currentPos == 2) {
              imageString = "assets/images/Group 47540.png";
            }else{
              imageString = "assets/images/Group 47540.png";
            }
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: kToolbarHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/images/back.svg",
                              height: width*0.045,
                              width: width*0.045,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width*0.04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Checkout",
                                  style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width*0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width*0.04,
                    ),
                    Container(
                      height: 1,
                      width: width,
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    Image.asset(
                      imageString,
                      height: Get.height*0.08,
                      width: Get.width,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: width*0.04,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: Get.height,
                        child: PageView(
                          onPageChanged: (value) {
                            currentPos = value;
                            controller.update(['Checkout']);
                          },
                          controller: pageController,
                          //physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                    child: Text(
                                      "Choose your shipping location",
                                      style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: width*0.015,
                                  ),
                                  SizedBox(
                                    height: width*0.08,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                            child: PageInput(
                                              hint: "Enter delivery address",
                                              label: "Address",
                                              controller: address,
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "Please enter your delivery address";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: width*0.06,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                                child: SizedBox(
                                                  width: width*0.4,
                                                  child: PageInput(
                                                    hint: "Enter City",
                                                    label: "City",
                                                    controller: city,
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please enter your city";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                                child: SizedBox(
                                                  width: width*0.4,
                                                  child: PageInput(
                                                    hint: "Enter State/Province",
                                                    label: "State/Province",
                                                    controller: state,
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please enter your state/province";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: width*0.06,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                                child: SizedBox(
                                                  width: width*0.4,
                                                  child: PageInput(
                                                    hint: "Enter Postal Code",
                                                    label: "Postal Code",
                                                    controller: zip,
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please enter your postal code";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                                child: SizedBox(
                                                  width: width*0.4,
                                                  child: PageInput(
                                                    hint: "Enter Country",
                                                    label: "Country",
                                                    controller: country,
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please enter your country";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: width*0.1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                            child: AppButton(
                                              title: "Proceed to Payment",
                                              onPressed: (){
                                                if(formKey.currentState!.validate()){
                                                  pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                                  controller.update(['Checkout']);
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              key: formKey1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                    child: Text(
                                      "Select your payment method ",
                                      style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: width*0.015,
                                  ),
                                  SizedBox(
                                    height: width*0.08,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                            child: PageInput(
                                              hint: "Your card holder name",
                                              label: "Card Holder's Name",
                                              controller: name,
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "Please enter your card holder name";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: width*0.06,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                            child: PageInput(
                                              hint: "XXXX XXXX XXXX XXXX",
                                              label: "Card Number",
                                              controller: number,
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "Please enter your card number";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: width*0.06,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                                child: SizedBox(
                                                  width: width*0.4,
                                                  child: PageInput(
                                                    hint: "XX/XX",
                                                    label: "Expiry Date",
                                                    controller: date,
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please enter your card expiry date";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                                child: SizedBox(
                                                  width: width*0.4,
                                                  child: PageInput(
                                                    hint: "Enter CVV",
                                                    label: "CVV",
                                                    controller: cvv,
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please enter your card CVV";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: width*0.1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                            child: AppButton(
                                              title: "Proceed",
                                              onPressed: (){
                                                if(formKey1.currentState!.validate()){
                                                  pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                                  controller.update(['Checkout']);
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              key: formKey2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                    child: Text(
                                      "Order Details",
                                      style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: width*0.015,
                                  ),
                                  SizedBox(
                                    height: width*0.08,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                            child: SizedBox(
                                              height: Get.height * 0.35,
                                              child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: controller.productsList.length,
                                                  shrinkWrap: false,
                                                  //physics: NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context,index){
                                                    var product = controller.productsList[index];
                                                    return CartItem(
                                                      title: product.name.toString(),
                                                      image: product.image.toString(),
                                                      price: "N ${product.price}",
                                                      quantity: controller.productsMap[product.id.toString()] ?? 1,
                                                      quantityChanged: (value){
                                                        controller.productsMap[product.id.toString()] = value;
                                                        controller.update();
                                                      },
                                                    );
                                                  }
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                                            child: SizedBox(
                                              height: Get.height * 0.4,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.05,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Sub Total:",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Get.width * 0.035,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          "N ${controller.totalPrice}",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Get.width * 0.035,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.025,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Delivery Fee :",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Get.width * 0.035,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          "N 5,000",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Get.width * 0.035,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.025,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Discount :",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Get.width * 0.035,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          "0%",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Get.width * 0.035,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.025,
                                                    ),
                                                    //Dotted Line
                                                    CustomPaint(painter: DashedLinePainter()),
                                                    SizedBox(
                                                      height: Get.height * 0.025,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Total :",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: Colors.black,
                                                            fontSize: Get.width * 0.035,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                        Text(
                                                          "N ${controller.totalPrice + 5000}",
                                                          style: AppTextStyle.subtitle1.copyWith(
                                                            color: AppColors.primary,
                                                            fontSize: Get.width * 0.04,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.025,
                                                    ),
                                                    AppButton(
                                                      title: 'Proceed To Checkout',
                                                      onPressed: () {
                                                        Get.to(() => Checkout());
                                                      },
                                                      borderRadius: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Payment Successful",
                                      style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: Get.height*0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: Text(
                                        "Congratulations,  your order has been placed successfully.",
                                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.06,color: Colors.black,fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: width*0.2),
                                  child: AppButton(
                                    title: "Proceed To Home",
                                    onPressed: (){
                                      controller.currentBottomNavPage.value = 0;
                                      controller.updateNewUser(controller.currentType);
                                      controller.update(['home']);
                                      Get.back();
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
                          controller.currentBottomNavPage.value == 1 ? 'assets/images/chat_filled.png' : 'assets/images/chatIcon.png',
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
                  }
              ),

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
      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
      child: InkWell(
        onTap: function,
        child: Container(
          height: width*0.4,
          width: width*0.4,
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
                height: width*0.15,
                width: width*0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: width*0.04,
              ),
              Text(
                title,
                style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.065,color: Colors.black,fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
