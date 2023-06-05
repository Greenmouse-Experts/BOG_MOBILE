import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/nearest_address.dart';
import '../../data/model/post_order.dart';
import '../../data/model/order_response.dart' as order_response;
import '../../data/providers/api.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/address_picker.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/app_tool_tip.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/overlays.dart';
import '../../global_widgets/page_input.dart';
import '../home/pages/cart_tab.dart';

import 'receipt.dart';

// import 'receipt.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  static const route = '/Checkout';

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var publicKey = Api.publicKey;
  final plugin = PaystackPlugin();
  String successMessage = '';
  var currentPos = 0;
  var homeController = Get.find<HomeController>();
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();
  var formKey1 = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  var formKey3 = GlobalKey<FormState>();

  bool addInsurance = true;

  var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));

  NearestAddress? deliveryNearestAddress;

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

  List<NearestAddress> nearStateAddress = <NearestAddress>[];

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    state.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future<List<NearestAddress>> getNearestAddress(String state) async {
    final controller = Get.find<HomeController>();
    final response =
        await controller.userRepo.getData('/address/view/all?q=$state');
    final nearestAddresses = <NearestAddress>[];
    for (var element in response.data as List<dynamic>) {
      nearestAddresses.add(NearestAddress.fromJson(element));
    }

    setState(() {
      nearStateAddress = nearestAddresses;
    });
    return nearestAddresses;
  }

  void updateDeliveryFee(String newDeliveryFee) {
    final answer = NearestAddress.fromJson(jsonDecode(newDeliveryFee));
    deliveryNearestAddress = answer;
  }

  checkout(
      {required int cost,
      required String email,
      required HomeController controller,
      required int deliveryFee}) async {
    final controller = Get.find<HomeController>();
    final userType = controller.currentType == 'Client'
        ? 'private_client'
        : controller.currentType == 'Corporate Client'
            ? 'corporate_client'
            : controller.currentType == 'Product Partner'
                ? 'vendor'
                : 'professional';
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    int price = addInsurance
        ? (cost +
                deliveryFee +
                int.parse(deliveryNearestAddress!.insurancecharge ?? '0')) *
            100
        : (cost + deliveryFee) * 100;
    final List<OrderProduct> orderProducts = [];
    for (var item in controller.cartItems.values.toList()) {
      orderProducts.add(
          OrderProduct(productId: item.product.id!, quantity: item.quantity));
    }
    List<dynamic> jsonProducts = [];
    for (var element in orderProducts) {
      jsonProducts.add(element.toJson());
    }

    Charge charge = Charge()
      ..amount = price
      ..reference = 'TR-${DateTime.now().millisecondsSinceEpoch}'
      ..email = email
      ..currency = "NGN";

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      fullscreen: true,
    );

    if (response.status == true) {
      AppOverlay.loadingOverlay(
        asyncFunction: () async {
          successMessage = 'Payment was successful. Ref: ${response.reference}';
          final num total = !addInsurance
              ? cost + deliveryFee
              : deliveryNearestAddress == null
                  ? cost + deliveryFee
                  : deliveryNearestAddress!.insurancecharge == null
                      ? cost + deliveryFee
                      : cost +
                          deliveryFee +
                          double.parse(deliveryNearestAddress!.insurancecharge);
          final postOrder = {
            "products": [...jsonProducts],
            "shippingAddress": {
              "address": deliveryNearestAddress == null
                  ? ''
                  : deliveryNearestAddress!.address ?? '',
              "contact_email": logInDetails.email!,
              "contact_name": '${logInDetails.fname} ${logInDetails.lname}',
              "contact_phone": logInDetails.phone!,
              "country": country.text,
              "delivery_time": deliveryNearestAddress == null
                  ? ''
                  : deliveryNearestAddress!.deliveryTime ?? '',
              "home_address": address.text,
              "postal_code": zip.text,
              "state": state.text,
            },
            "totalAmount": total,
            "deliveryFee": deliveryFee,
            "discount": 0,
            "paymentInfo": {"reference": response.reference, "amount": total},
            "userType": userType,
            "deliveryaddressId":
                addInsurance ? deliveryNearestAddress?.id ?? '' : '',
          };
          final respose = await controller.userRepo
              .postData('/orders/submit-order', postOrder);

          if (respose.isSuccessful) {
            controller.clearCart();
            final order = order_response.OrderResponse.fromJson(respose.order);
            Get.back();

            Get.to(() => AppReceipt(id: order.id!));
          }
        },
      );
    } else {
      Get.snackbar('Error', 'An error occurred',
          colorText: AppColors.background, backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Checkout',
          builder: (controller) {
            var imageString = "assets/images/Group 47538.png";
            if (currentPos == 0) {
              imageString = "assets/images/Group 47538.png";
            } else if (currentPos == 1) {
              imageString = "assets/images/Group 47539.png";
            } else if (currentPos == 2) {
              imageString = "assets/images/Group 47540.png";
            } else {
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
                                Get.back();
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
                                    "Checkout",
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
                      Image.asset(
                        imageString,
                        height: Get.height * 0.08,
                        width: Get.width,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        height: width * 0.04,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: Get.height,
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
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
                                      padding: EdgeInsets.only(
                                          left: width * 0.04,
                                          right: width * 0.04),
                                      child: Text(
                                        "Choose your shipping location",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: width * 0.015,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: PageInput(
                                                hint: "Enter delivery address",
                                                label: "Address",
                                                controller: address,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter your delivery address";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: width * 0.06,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.04,
                                                      right: width * 0.04),
                                                  child: SizedBox(
                                                    width: width * 0.4,
                                                    child: PageInput(
                                                      textWidth: 0.35,
                                                      hint: "Enter City",
                                                      label: "City",
                                                      controller: city,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Please enter your city";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.04,
                                                      right: width * 0.04),
                                                  child: SizedBox(
                                                    width: width * 0.4,
                                                    child: PageInput(
                                                      textWidth: 0.35,
                                                      hint:
                                                          "Enter State/Province",
                                                      label: "State/Province",
                                                      controller: state,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
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
                                              height: width * 0.06,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.04,
                                                      right: width * 0.04),
                                                  child: SizedBox(
                                                    width: width * 0.4,
                                                    child: PageInput(
                                                      textWidth: 0.35,
                                                      hint: "Enter Postal Code",
                                                      label: "Postal Code",
                                                      controller: zip,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Please enter your postal code";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.04,
                                                      right: width * 0.04),
                                                  child: SizedBox(
                                                    width: width * 0.4,
                                                    child: PageInput(
                                                      hint: "Enter Country",
                                                      label: "Country",
                                                      textWidth: 0.35,
                                                      controller: country,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
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
                                              height: width * 0.1,
                                            ),
                                            state.text.isEmpty
                                                ? const Center(
                                                    child: Text(
                                                        'Select Nearest Address'))
                                                : Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 12),
                                                    child: AddressPicker(
                                                      updateDeliveryFee,
                                                      textController: state,
                                                      controller: controller,
                                                    ),
                                                  ),
                                            const SizedBox(height: 80),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: AppButton(
                                                title: "Proceed to Payment",
                                                onPressed: () {
                                                  if (deliveryNearestAddress ==
                                                      null) {
                                                    Get.snackbar('Error',
                                                        'You must select a delivery address before checkout',
                                                        backgroundColor:
                                                            Colors.red,
                                                        colorText: AppColors
                                                            .backgroundVariant1);
                                                    return;
                                                  }
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    pageController.animateToPage(
                                                        1,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.easeIn);
                                                    controller
                                                        .update(['Checkout']);
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
                                      padding: EdgeInsets.only(
                                          left: width * 0.04,
                                          right: width * 0.04),
                                      child: Text(
                                        "Order Details",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: width * 0.015,
                                    ),
                                    SizedBox(
                                      height: width * 0.08,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: SizedBox(
                                                height: Get.height * 0.35,
                                                child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller
                                                        .productsList.length,
                                                    shrinkWrap: false,
                                                    //physics: NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      var product = controller
                                                          .productsList[index];
                                                      return CartItem(
                                                        deleteItem: () {
                                                          controller.removeItem(
                                                              product.id!,
                                                              product);
                                                          Get.back();
                                                        },
                                                        maxcount:
                                                            product.remaining ??
                                                                0,
                                                        itemDecrement: () {
                                                          controller
                                                              .cartItemDecrement(
                                                                  product.id!);
                                                        },
                                                        itemIncrement: () {
                                                          controller
                                                              .cartItemIncrement(
                                                            product.id!,
                                                          );
                                                        },
                                                        title: product.name
                                                            .toString(),
                                                        image: product.image
                                                            .toString(),
                                                        price:
                                                            "N ${product.price}",
                                                        quantity: controller
                                                                    .productsMap[
                                                                product.id
                                                                    .toString()] ??
                                                            1,
                                                        quantityChanged:
                                                            (value) {
                                                          controller.productsMap[
                                                                  product.id
                                                                      .toString()] =
                                                              value;
                                                          controller.update();
                                                        },
                                                      );
                                                    }),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: SizedBox(
                                                height: Get.height * 0.9,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.05,
                                                      ),
                                                      if (deliveryNearestAddress !=
                                                          null)
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Delivery Time:",
                                                              style:
                                                                  AppTextStyle
                                                                      .subtitle1
                                                                      .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    Get.width *
                                                                        0.035,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${deliveryNearestAddress!.deliveryTime ?? 0}",
                                                              style:
                                                                  AppTextStyle
                                                                      .subtitle1
                                                                      .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    Get.width *
                                                                        0.035,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Sub Total:",
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            "N ${controller.subTotalPrice}",
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Estimated Delivery Fee :",
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            deliveryNearestAddress ==
                                                                    null
                                                                ? '0'
                                                                : deliveryNearestAddress!
                                                                    .charge
                                                                    .toString(),
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      addInsurance
                                                          ? Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.025,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Insurance Fee :",
                                                                      style: AppTextStyle
                                                                          .subtitle1
                                                                          .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            Get.width *
                                                                                0.035,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      deliveryNearestAddress ==
                                                                              null
                                                                          ? '0'
                                                                          : deliveryNearestAddress!.insurancecharge == null
                                                                              ? '0'
                                                                              : deliveryNearestAddress!.insurancecharge.toString(),
                                                                      style: AppTextStyle
                                                                          .subtitle1
                                                                          .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            Get.width *
                                                                                0.035,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Estimated Sales Tax :",
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            "0%",
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const AppToolTip(
                                                                message:
                                                                    'This insurance provides the coverage for the orders shipped to recover any losses if the package is lost or damaged in transit. There is a fee required for this coverage.',
                                                              ),
                                                              Text(
                                                                "Accept Insurance :",
                                                                style: AppTextStyle
                                                                    .subtitle1
                                                                    .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.035,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Checkbox(
                                                              // checkColor:
                                                              //     AppColors
                                                              //         .primary,
                                                              checkColor: AppColors
                                                                  .backgroundVariant1, // color of tick Mark
                                                              activeColor:
                                                                  AppColors
                                                                      .primary,
                                                              value:
                                                                  addInsurance,
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  addInsurance =
                                                                      !addInsurance;
                                                                });
                                                              }),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      //Dotted Line
                                                      CustomPaint(
                                                          painter:
                                                              DashedLinePainter()),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Total :",
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Text(
                                                            deliveryNearestAddress ==
                                                                    null
                                                                ? "N ${controller.subTotalPrice}"
                                                                : addInsurance
                                                                    ? (deliveryNearestAddress!.charge! +
                                                                            int.parse(deliveryNearestAddress!.insurancecharge ??
                                                                                '0') +
                                                                            controller
                                                                                .subTotalPrice)
                                                                        .toString()
                                                                    : (deliveryNearestAddress!.charge! +
                                                                            controller.subTotalPrice)
                                                                        .toString(),
                                                            style: AppTextStyle
                                                                .subtitle1
                                                                .copyWith(
                                                              color: AppColors
                                                                  .primary,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.04,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      AppButton(
                                                        title: 'Proceed ',
                                                        onPressed: () {
                                                          checkout(
                                                            cost: controller
                                                                .subTotalPrice,
                                                            deliveryFee:
                                                                deliveryNearestAddress!
                                                                        .charge ??
                                                                    5000,
                                                            email: logInDetails
                                                                .email!,
                                                            controller:
                                                                controller,
                                                          );
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
                              Form(
                                key: formKey1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.04,
                                          right: width * 0.04),
                                      child: Text(
                                        "Select your payment method ",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: width * 0.015,
                                    ),
                                    SizedBox(
                                      height: width * 0.08,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: PageInput(
                                                hint: "Your card holder name",
                                                label: "Card Holder's Name",
                                                controller: name,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter your card holder name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: width * 0.06,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: PageInput(
                                                hint: "XXXX XXXX XXXX XXXX",
                                                label: "Card Number",
                                                controller: number,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter your card number";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: width * 0.06,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.04,
                                                      right: width * 0.04),
                                                  child: SizedBox(
                                                    width: width * 0.4,
                                                    child: PageInput(
                                                      hint: "XX/XX",
                                                      label: "Expiry Date",
                                                      controller: date,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Please enter your card expiry date";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.04,
                                                      right: width * 0.04),
                                                  child: SizedBox(
                                                    width: width * 0.4,
                                                    child: PageInput(
                                                      hint: "Enter CVV",
                                                      label: "CVV",
                                                      controller: cvv,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
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
                                              height: width * 0.1,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * 0.04,
                                                  right: width * 0.04),
                                              child: AppButton(
                                                title: "Proceed",
                                                onPressed: () {
                                                  if (formKey1.currentState!
                                                      .validate()) {
                                                    pageController.animateToPage(
                                                        2,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.easeIn);
                                                    controller
                                                        .update(['Checkout']);
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
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Payment Successful",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.05,
                                            right: width * 0.05),
                                        child: Text(
                                          "Congratulations,  your order has been placed successfully.",
                                          style: AppTextStyle.subtitle1
                                              .copyWith(
                                                  fontSize: multiplier * 0.06,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05,
                                        bottom: width * 0.2),
                                    child: AppButton(
                                      title: "Proceed To Home",
                                      onPressed: () {
                                        controller.currentBottomNavPage.value =
                                            0;
                                        controller.updateNewUser(
                                            controller.currentType);
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
