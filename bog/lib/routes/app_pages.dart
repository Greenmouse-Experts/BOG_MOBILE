import 'package:bog/app/modules/settings/update_kyc.dart';
import 'package:get/get.dart';

import '../app/bindings/auth_binding.dart';
import '../app/modules/chat/chat.dart';
import '../app/modules/create/create.dart';
import '../app/modules/home/home.dart';
import '../app/modules/multiplexor/multiplexor.dart';
import '../app/modules/onboarding/onboarding.dart';
import '../app/modules/profile/confirm_pin.dart';
import '../app/modules/profile/create_pin.dart';
import '../app/modules/profile/update_profile.dart';
import '../app/modules/setup/interests.dart';
import '../app/modules/shop/shop.dart';
import '../app/modules/sign_in/sign_in.dart';
import '../app/modules/sign_up/forgot_password.dart';
import '../app/modules/sign_up/service_provider.dart';
import '../app/modules/sign_up/sign_up.dart';
import '../app/modules/sign_up/supplier.dart';
import '../app/modules/sign_up/verify_otp.dart';
import '../app/modules/verify_otp/verify_otp.dart';

class AppPages {
  AppPages._();
  //static String initial = MyPref.authToken.val.isNotEmpty ? HomePage.route : OnbordingPage.route;
  static String initial =  OnboardingPage.route;

  static final routes = [
    GetPage(
      name: OnboardingPage.route,
      page: () => const OnboardingPage()
    ),
    GetPage(
        name: Multiplexor.route,
        page: () => const Multiplexor()
    ),
    GetPage(
      name: SignIn.route,
  // page: () => const UpdateKyc(),
  page: () => const SignIn(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: SignUp.route,
      page: () => const SignUp(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: VerifySignUpOTP.route,
      page: () => const VerifySignUpOTP(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: ServiceProviderSignUp.route,
      page: () => const ServiceProviderSignUp(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: SupplierSignUp.route,
      page: () => const SupplierSignUp(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: ForgotPassword.route,
      page: () => const ForgotPassword(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: VerifyOTP.route,
      page: () => const VerifyOTP(),
      binding: AuthBinding(),
    ),
    GetPage(
        name: UpdateProfile.route,
        page: () => const UpdateProfile()
    ),

    GetPage(
        name: CreatePIN.route,
        page: () => const CreatePIN()
    ),
    GetPage(
        name: ConfirmPIN.route,
        page: () => const ConfirmPIN()
    ),
    GetPage(
        name: Interests.route,
        page: () => const Interests()
    ),

    GetPage(
        name: Home.route,
        page: () => const Home()
    ),
    GetPage(
        name: Chat.route,
        page: () => const Chat()
    ),
    GetPage(
        name: Shop.route,
        page: () => const Shop()
    ),
    GetPage(
        name: Create.route,
        page: () => const Create()
    ),
  ];
}
