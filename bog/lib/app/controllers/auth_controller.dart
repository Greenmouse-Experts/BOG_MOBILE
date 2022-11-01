import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:otp_text_field/otp_field.dart';

import '../data/providers/api_response.dart';
import '../global_widgets/overlays.dart';
import '../modules/home/home.dart';
import '../modules/sign_in/sign_in.dart';
import '../modules/sign_up/verify_otp.dart';
import '../modules/verify_otp/verify_otp.dart';
import '../repository/user_repo.dart';

class AuthController extends GetxController {
  final UserRepository userRepo;

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController officeAddress = TextEditingController();
  TextEditingController certOfOperation = TextEditingController();
  TextEditingController proMemCert = TextEditingController();


  TextEditingController otp = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  OtpFieldController otpController = OtpFieldController();

  var currentBusinessPage = 0;
  var currentPersonalPage = 0;
  PageController pageController = PageController(initialPage: 0, keepPage: true);
  PageController businessPageController = PageController(initialPage: 0, keepPage: true);
  PageController personalPageController = PageController(initialPage: 0, keepPage: true);

  int index = 0;
  bool isCorporate = false;
  bool isTermsAndConditionsChecked = false;

  AuthController(this.userRepo);

  toggleBusiness(int index) {
    this.index = index;
    if(index == 0) {
      isCorporate = false;
      pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      isCorporate = true;
      pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
    update();
  }

  toggleTermsAndConditions(bool value) {
    isTermsAndConditionsChecked = value;
    update();
  }

  //Sign Up
  Future<void> signupServiceProvider(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var message = "";
      var buttonMessage = "";
      ApiResponse response = await userRepo.signup(_signupServiceProviderPayload);
      if(response.message == "This Email is already in Use") {
        message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        message = "Account created successfully, Check your email for otp verification";
        buttonMessage = "Continue";
      }
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: message,
        buttonText: buttonMessage,
        onPressed: () {
          if(response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          }else{
            if(response.isSuccessful) {
              Get.toNamed(VerifySignUpOTP.route);
              startTimer();
            }else{
              Get.back();
            }
          }
        },
      );
    }
  }

  Future<void> signupClient(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var message = "";
      var buttonMessage = "";
      ApiResponse response = await userRepo.signup(_signupServiceClient);
      if(response.message == "This Email is already in Use") {
        message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        message = "Account created successfully, Check your email for otp verification";
        buttonMessage = "Continue";
      }
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: message,
        buttonText: buttonMessage,
        onPressed: () {
          if(response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          }else{
            if(response.isSuccessful) {
              Get.toNamed(VerifySignUpOTP.route);
              startTimer();
            }else{
              Get.back();
            }
          }
        },
      );
    }
  }

  Future<void> signupCorporate(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var message = "";
      var buttonMessage = "";
      ApiResponse response = await userRepo.signup(_signupServiceCorporate);
      if(response.message == "This Email is already in Use") {
        message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        message = "Account created successfully, Check your email for otp verification";
        buttonMessage = "Continue";
      }
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: message,
        buttonText: buttonMessage,
        onPressed: () {
          if(response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          }else{
            if(response.isSuccessful) {
              Get.toNamed(VerifySignUpOTP.route);
              startTimer();
            }else{
              Get.back();
            }
          }
        },
      );
    }
  }

  Future<void> signupSupplier(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var message = "";
      var buttonMessage = "";
      ApiResponse response = await userRepo.signup(_signupServiceSupplier);
      if(response.message == "This Email is already in Use") {
        message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        message = "Account created successfully, Check your email for otp verification";
        buttonMessage = "Continue";
      }
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: message,
        buttonText: buttonMessage,
        onPressed: () {
          if(response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          }else{
            if(response.isSuccessful) {
              Get.toNamed(VerifySignUpOTP.route);
              startTimer();
            }else{
              Get.back();
            }
          }
        },
      );
    }
  }

  Future<void> verifyOTPForSignUp() async {
    ApiResponse response = await userRepo.verifyOTPForSignUp(email.text, otp.text);
    if(response.isSuccessful){
      AppOverlay.showInfoDialog(
        title: 'Success',
        content: "OTP Verification Successful, Please Login",
        buttonText: "Continue",
        onPressed: () {
          Get.toNamed(SignIn.route);
        },
      );
    }else{
      AppOverlay.showInfoDialog(
        title: 'Failure',
        content: "OTP Verification Failed. Please try again",
        buttonText: "Okay",
        onPressed: () {
          Get.back();
        },
      );
    }
  }

  int _start = 120;
  var time = "0:00";
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec, (Timer timer) {
        var duration = Duration(seconds: _start);
      if (_start < 1) {
        time = "0:00";
        timer.cancel();
        update();
      } else {
        time = "0:${_start.toString().padLeft(2, '0')}";
        _start = _start - 1;
        update();
      }
    },
    );
  }

  Map<String, dynamic> get _signupServiceProviderPayload => {
    'fname': fName.text,
    'lname': lName.text,
    'name': "${fName.text} ${lName.text}",
    'email': email.text,
    'phone': phone.text,
    'company_name': companyName.text,
    'password': password.text,
    "userType": "professional",
    "platform":"mobile"
  };

  Map<String, dynamic> get _signupServiceClient => {
    'fname': fName.text,
    'lname': lName.text,
    'name': "${fName.text} ${lName.text}",
    'email': email.text,
    'phone': phone.text,
    'password': password.text,
    "userType": "private_client",
    "platform":"mobile"
  };

  Map<String, dynamic> get _signupServiceCorporate => {
    'fname': fName.text,
    'lname': lName.text,
    'name': "${fName.text} ${lName.text}",
    'email': email.text,
    'phone': phone.text,
    'company_name': companyName.text,
    'password': password.text,
    "userType": "corporate_client",
    "platform":"mobile"
  };

  Map<String, dynamic> get _signupServiceSupplier => {
    'fname': fName.text,
    'lname': lName.text,
    'name': "${fName.text} ${lName.text}",
    'email': email.text,
    'phone': phone.text,
    'company_name': companyName.text,
    'password': password.text,
    "userType": "vendor",
    "platform":"mobile"
  };

  //Sign In
  Future<void> signIn(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      var message = "";
      var buttonMessage = "";
      ApiResponse response = await userRepo.signIn(_signInPayload);
      if(response.isSuccessful){
        Get.toNamed(Home.route);
      }else{
        if(response.message == "This Email is already in Use") {
          message = "This Email is already in Use, Please Login";
          buttonMessage = "Login";
        } else {
          message = "Account created successfully, Check your email for verification";
          buttonMessage = "Login";
        }
        AppOverlay.showInfoDialog(
          title: response.isSuccessful ? 'Success' : 'Failure',
          content: response.message,
          buttonText: "Continue",
          onPressed: () {
            if(response.isSuccessful){

            }else{
              Get.back();
            }
          },
        );
      }
    }
  }

  Map<String, dynamic> get _signInPayload => {
    'email': email.text,
    'password': password.text,
    "platform":"mobile"
  };

  Future<void> forgotPassword(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      ApiResponse response = await userRepo.forgotPassword(email.text);
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: response.message,
        buttonText: "Okay",
        onPressed: () {
          Get.back();
        },
      );
    }
  }
}