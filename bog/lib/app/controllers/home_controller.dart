import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:get/get.dart';

import '../data/model/cart_model.dart';
import '../data/model/my_products.dart';
import '../data/providers/my_pref.dart';
import '../modules/home/pages/cart_tab.dart';
import '../modules/home/pages/chat_tab.dart';
import '../modules/home/pages/home_tab.dart';
import '../modules/home/pages/profile_tab.dart';
import '../modules/home/pages/project_tab.dart';
import '../repository/user_repo.dart';

class HomeController extends GetxController {
  final UserRepository userRepo;
  HomeController(this.userRepo);

  RxInt currentBottomNavPage = 0.obs;
  String currentType = "Client";
  bool showProductPartnerEarnings = false;
  bool showServicePartnerEarnings = false;

  TextEditingController roleCoontroller = TextEditingController();

  String homeIcon = 'assets/images/homeIcon.png';
  String chatIcon = 'assets/images/homeIcon.png';
  String projectIcon = 'assets/images/projectIcon.png';
  String cartIcon = 'assets/images/cartIcon.png';
  String profileIcon = 'assets/images/profileIcon.png';

  String homeTitle = 'Home';
  String cartTitle = 'Cart';
  String projectTitle = 'Project';

  void switchProdPartnerEarnings() {
    showProductPartnerEarnings = !showProductPartnerEarnings;
    update();
  }

  void switchServicePartnerEarnings() {
    showServicePartnerEarnings = !showServicePartnerEarnings;
    update();
  }

  void signOut() {
    MyPref.userId.val = '';
    MyPref.authToken.val = '';
    MyPref.logInDetail.val = '';
    MyPref.userDetail.val = '';
    MyPref.userDetails.val = '';
  }

  updateNewUser(String userType, {bool updatePages = true}) {
    if (userType == "Client" || userType == "Corporate Client") {
      //Group 46942.png
      homeIcon = currentBottomNavPage.value == 0
          ? 'assets/images/homeIcon.png'
          : 'assets/images/Vector (7).png';
      chatIcon = currentBottomNavPage.value == 1
          ? 'assets/images/Vector (5).png'
          : 'assets/images/chatIcon.png';
      projectIcon = currentBottomNavPage.value == 2
          ? 'assets/images/Group 46942.png'
          : 'assets/images/projectIcon.png';
      cartIcon = currentBottomNavPage.value == 3
          ? 'assets/images/Vector (6).png'
          : 'assets/images/cartIcon.png';
      profileIcon = currentBottomNavPage.value == 4
          ? 'assets/images/Group (3).png'
          : 'assets/images/profileIcon.png';

      homeTitle = 'Home';
      cartTitle = 'Cart';
      projectTitle = 'Project';
    } else if (userType == "Product Partner") {
      homeIcon = currentBottomNavPage.value == 0
          ? 'assets/images/Vector (4).png'
          : 'assets/images/dashboardIcon.png';
      chatIcon = currentBottomNavPage.value == 1
          ? 'assets/images/Vector (5).png'
          : 'assets/images/chatIcon.png';
      projectIcon = currentBottomNavPage.value == 2
          ? 'assets/images/Group 47400.png'
          : 'assets/images/ordersIcon.png';
      cartIcon = currentBottomNavPage.value == 3
          ? 'assets/images/Group (2).png'
          : 'assets/images/prodctIcon.png';
      profileIcon = currentBottomNavPage.value == 4
          ? 'assets/images/Group (3).png'
          : 'assets/images/profileIcon.png';

      homeTitle = 'Dashboard';
      cartTitle = 'Products';
      projectTitle = 'Orders';
    } else {
      homeIcon = currentBottomNavPage.value == 0
          ? 'assets/images/homeIcon.png'
          : 'assets/images/Vector (7).png';
      chatIcon = currentBottomNavPage.value == 1
          ? 'assets/images/Vector (5).png'
          : 'assets/images/chatIcon.png';
      projectIcon = currentBottomNavPage.value == 2
          ? 'assets/images/Group 46942.png'
          : 'assets/images/projectIcon.png';
      cartIcon = currentBottomNavPage.value == 3
          ? 'assets/icons/meeeting.png'
          : 'assets/icons/meeeting.png';
      profileIcon = currentBottomNavPage.value == 4
          ? 'assets/images/Group (3).png'
          : 'assets/images/profileIcon.png';

      homeTitle = 'Home';
      cartTitle = 'Meetings';
      projectTitle = 'Project';
    }
    if (updatePages) {
      update();
      update(['home']);
    }
  }

  List<Widget> pages = const [
    HomeTab(),
    ChatTab(),
    ProjectTab(),
    CartTab(),
    ProfileTab()
  ];

  bool isBuyNow = false;
  MyProducts? myProducts;
  RxInt get cartLength => _cartItems.length.obs;

  List<MyProducts> productsList = [];
  Map<String, int> productsMap = {};

  Map<String, CartModel> _cartItems = {};
  RxMap<String, CartModel> get cartItems => _cartItems.obs;

  String stringIntMapToJson(Map<String, int> map) {
    Map<String, dynamic> jsonMap = {};
    map.forEach((key, value) {
      jsonMap[key] = value;
    });
    return json.encode(jsonMap);
  }

// Convert JSON string back to Map<String, int>
  Map<String, int> stringIntMapFromJson(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, int> map = {};
    jsonMap.forEach((key, value) {
      map[key] = value as int;
    });
    return map;
  }

  String productListToJson(List<MyProducts> productList) {
    List<Map<String, dynamic>> jsonList =
        productList.map((product) => product.toJson()).toList();
    return json.encode(jsonList);
  }

// Convert JSON string back to List<MyProducts>
  List<MyProducts> productListFromJson(String jsonString) {
    List<dynamic> jsonList = json.decode(jsonString);
    List<MyProducts> productList =
        jsonList.map((json) => MyProducts.fromJson(json)).toList();
    return productList;
  }

  String cartMapToJson(Map<String, CartModel> cartMap) {
    Map<String, dynamic> jsonMap = {};
    cartMap.forEach((key, value) {
      jsonMap[key] = {
        'product': value.product.toJson(),
        'quantity': value.quantity,
      };
    });
    return json.encode(jsonMap);
  }

  Map<String, CartModel> cartMapFromJson(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, CartModel> cartMap = {};
    jsonMap.forEach((key, value) {
      cartMap[key] = CartModel(
        product: MyProducts.fromJson(value['product']),
        quantity: value['quantity'],
      );
    });
    return cartMap;
  }

  void saveCartLocally() {
    // print(cartMapToJson(_cartItems));

    MyPref.userCart.val = cartMapToJson(_cartItems);
    MyPref.userCartProducts.val = productListToJson(productsList);
    MyPref.productMap.val = stringIntMapToJson(productsMap);
    // print(cartMapFromJson(MyPref.userCart.val));
  }

  void restoreCart() {
    if (MyPref.userCart.val.isNotEmpty) {
      _cartItems = cartMapFromJson(MyPref.userCart.val);
    }
    if (MyPref.productMap.val.isNotEmpty) {
      productsMap = stringIntMapFromJson(MyPref.productMap.val);
    }
    if (MyPref.userCartProducts.val.isNotEmpty) {
      productsList = productListFromJson(MyPref.userCartProducts.val);
    }

    update();
  }

  void addItem(MyProducts product, int quantity) {
    final remQuantity = product.remaining ?? 0;
    if (_cartItems.containsKey(product.id!)) {
      Get.snackbar(
        'Already in Cart',
        'Product is already in Cart',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: Get.height * 0.1),
        borderRadius: 0,
        icon: const Icon(
          FeatherIcons.shoppingCart,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 2),
      );
    } else if (remQuantity < 1) {
      Get.snackbar(
        'Error',
        'Product Quantity required exceeds available quantity',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: Get.height * 0.1),
        borderRadius: 0,
        icon: const Icon(
          FeatherIcons.shoppingCart,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 2),
      );
    } else {
      productsList.add(product);
      _cartItems.putIfAbsent(
          product.id!, () => CartModel(product: product, quantity: quantity));

      Get.snackbar(
        'Added to Cart',
        'Product added to Cart Successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.only(bottom: Get.height * 0.1),
        borderRadius: 0,
        icon: const Icon(
          FeatherIcons.shoppingCart,
          color: Colors.white,
        ),
        duration: const Duration(seconds: 2),
      );
    }

    update();
    saveCartLocally();
  }

  void removeItem(String productId, MyProducts product) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.remove(productId);
      productsList.remove(product);
    }
    update();

    saveCartLocally();
  }

  void cartItemIncrement(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(productId, (existingCartItem) {
        final remQuantity = existingCartItem.product.remaining ?? 0;
        return CartModel(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity < remQuantity
              ? existingCartItem.quantity + 1
              : existingCartItem.quantity,
        );
      });
    }

    update();
    saveCartLocally();
  }

  int get subTotalPrice {
    var total = 0;
    _cartItems.forEach((key, cartItem) {
      total += int.parse(cartItem.product.price!) * cartItem.quantity;
    });
    return total;
  }

  void cartItemDecrement(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartModel(
                product: existingCartItem.product,
                quantity: existingCartItem.quantity - 1,
              ));
    }
    update();

    saveCartLocally();
  }

  void clearCart() {
    productsList.clear();
    productsMap.clear();
    _cartItems.clear();
    update();

    saveCartLocally();
  }
}
