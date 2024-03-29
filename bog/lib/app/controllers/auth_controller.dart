import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_text_field/otp_field.dart';

import '../data/model/log_in_model.dart';
import '../data/model/user_details_model.dart';
import '../data/providers/api_response.dart';
import '../data/providers/my_pref.dart';
import '../global_widgets/overlays.dart';
import '../modules/home/home.dart';
import '../modules/sign_in/sign_in.dart';
import '../modules/sign_up/verify_otp.dart';
import '../repository/user_repo.dart';

// final signInScopes = [
//   'email',
//   'https://www.googleapis.com/auth/contacts.readonly',
// ];

class AuthController extends GetxController {
  // final HomeController homeController;
  final UserRepository userRepo;

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController secondPhone = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController officeAddress = TextEditingController();
  TextEditingController certOfOperation = TextEditingController();
  TextEditingController proMemCert = TextEditingController();
  TextEditingController serviceSelected = TextEditingController();

  TextEditingController otp = TextEditingController();
  TextEditingController referral = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  OtpFieldController otpController = OtpFieldController();

  var currentBusinessPage = 0;
  var currentPersonalPage = 0;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  PageController businessPageController =
      PageController(initialPage: 0, keepPage: true);
  PageController personalPageController =
      PageController(initialPage: 0, keepPage: true);

  int index = 0;
  bool isCorporate = false;
  bool isTermsAndConditionsChecked = false;

  AuthController(this.userRepo);

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  toggleBusiness(int index) {
    this.index = index;
    if (index == 0) {
      isCorporate = false;
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    } else {
      isCorporate = true;
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
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
      // var message = "";
      var buttonMessage = "";
      ApiResponse response =
          await userRepo.signup(_signupServiceProviderPayload);
      if (response.message == "This Email is already in Use") {
        // message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        // message =
        //     "Account created successfully, Check your email for otp verification";
        buttonMessage = "Continue";
      }
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: response.exists == true
            ? "New Account Profile Created Successfully\nProceed to login, your recently created profile has been included in your profile collection"
            : response.message,
        buttonText: buttonMessage,
        onPressed: () {
          if (response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          } else {
            if (response.isSuccessful) {
              if (response.exists == true) {
                Get.toNamed(SignIn.route);
              } else {
                Get.toNamed(VerifySignUpOTP.route);
                startTimer();
              }
            } else {
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

      if (response.message == "This Email is already in Use") {
        message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        if (response.isSuccessful) {
          if (response.exists == true) {
            message =
                "New Account Profile Created Successfully\nProceed to login, your recently created profile has been included in your profile collection";
          } else {
            message =
                "Account created successfully, Check your email for otp verification";
          }

          buttonMessage = "Continue";
        } else {
          //    message = "An error occurred, Please try again";
          message = response.message ?? '';
          buttonMessage = "Ok";
        }
      }
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: message,
        buttonText: buttonMessage,
        onPressed: () {
          if (response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          } else {
            if (response.isSuccessful) {
              if (response.exists == true) {
                Get.toNamed(SignIn.route);
              } else {
                Get.toNamed(VerifySignUpOTP.route);
                startTimer();
              }
            } else {
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
      if (response.message == "This Email is already in Use") {
        message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        if (response.isSuccessful) {
          if (response.exists == true) {
            message =
                "New Account Profile Created Successfully\nProceed to login, your recently created profile has been included in your profile collection";
          } else {
            message =
                "Account created successfully, Check your email for otp verification";
          }
          buttonMessage = "Continue";
        } else {
          message = "An error occurred, Please try again";
          buttonMessage = "Ok";
        }
      }
      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: message,
        buttonText: buttonMessage,
        onPressed: () {
          if (response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          } else {
            if (response.isSuccessful) {
              if (response.exists == true) {
                Get.toNamed(SignIn.route);
              } else {
                Get.toNamed(VerifySignUpOTP.route);
                startTimer();
              }
            } else {
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

      if (response.message == "This Email is already in Use") {
        message = "This Email is already in Use, Please Login";
        buttonMessage = "Login";
      } else {
        if (response.isSuccessful) {
          if (response.exists == true) {
            message =
                "New Account Profile Created Successfully\nProceed to login, your recently created profile has been included in your profile collection";
          } else {
            message =
                "Account created successfully, Check your email for otp verification";
          }

          buttonMessage = "Continue";
        } else {
          message = "An error occurred, Please try again";
          buttonMessage = "Ok";
        }
      }

      AppOverlay.showInfoDialog(
        title: response.isSuccessful ? 'Success' : 'Failure',
        content: message,
        buttonText: buttonMessage,
        onPressed: () {
          if (response.message == "This Email is already in Use") {
            Get.toNamed(SignIn.route);
          } else {
            if (response.isSuccessful) {
              if (response.exists == true) {
                Get.toNamed(SignIn.route);
              } else {
                Get.toNamed(VerifySignUpOTP.route);
                startTimer();
              }
            } else {
              Get.back();
            }
          }
        },
      );
    }
  }

  Future<void> handleSignUpGoogle() async {
    try {
      await _googleSignIn.signOut();

      final response = await _googleSignIn.signIn();

      if (response != null) {
        final newRes = await response.authentication;
        AppOverlay.loadingOverlay(asyncFunction: () async {
          ApiResponse response = await userRepo.googleSignUp({
            "access_token": newRes.accessToken,
            "user_type": "private_client"
          });

          if (response.isSuccessful) {
            var logInInfo = LogInModel.fromJson(response.user);
            response.user = logInInfo;

            var token = response.token;
            MyPref.logInDetail.val = jsonEncode(response.user);
            MyPref.authToken.val = token.toString();
            ApiResponse bankListResponse = await userRepo.getBanks();

            final newRes = await userRepo
                .getData('/user/me?userType=${logInInfo.profile!.userType}');
            final userDetails = UserDetailsModel.fromJson(newRes.user);
            MyPref.userDetails.val = jsonEncode(userDetails);

            if (bankListResponse.isSuccessful && newRes.isSuccessful) {
              MyPref.bankListDetail.val = jsonEncode(bankListResponse.data);

              Get.offAndToNamed(Home.route);
            } else {
              AppOverlay.showInfoDialog(
                title: "Error",
                content: "An error occurred, Please try again",
                buttonText: "Okay",
                onPressed: () {
                  Get.back();
                },
              );
            }
          } else {
            AppOverlay.showInfoDialog(
              title: 'Failure',
              content: response.message ?? 'Account creation failed',
              buttonText: "Continue",
              onPressed: () {
                if (response.isSuccessful) {
                } else {
                  Get.back();
                }
              },
            );
          }
        });
      }
    } catch (error) {
      AppOverlay.showInfoDialog(title: 'Error', content: error.toString());
    }
  }

  Future<void> logOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<void> resendOTP() async {
    ApiResponse response = await userRepo.resendOTP(email.text);
    if (response.isSuccessful) {
      AppOverlay.showInfoDialog(
        title: 'Success',
        content: "OTP Resent Successfully, Please Input New OTP",
        buttonText: "Continue",
        onPressed: () {
          Get.back();
        },
      );
    } else {
      AppOverlay.showInfoDialog(
        title: 'Failure',
        content:
            response.message ?? "OTP Verification Failed. Please try again",
        buttonText: "Okay",
        onPressed: () {
          Get.back();
        },
      );
    }
  }

  Future<void> verifyOTPForSignUp() async {
    ApiResponse response =
        await userRepo.verifyOTPForSignUp(email.text, otp.text);
    if (response.isSuccessful) {
      AppOverlay.showInfoDialog(
        title: 'Success',
        content: "OTP Verification Successful, Please Login",
        buttonText: "Continue",
        onPressed: () {
          Get.toNamed(SignIn.route);
        },
      );
    } else {
      AppOverlay.showInfoDialog(
        title: 'Failure',
        content:
            response.message ?? "OTP Verification Failed. Please try again",
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
      oneSec,
      (Timer timer) {
        // var duration = Duration(seconds: _start);
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
        'phone': secondPhone.text,
        'company_name': companyName.text,
        'password': password.text,
        'serviceTypeId': serviceSelected.text,
        "userType": "professional",
        "platform": "mobile"
      };

  Map<String, dynamic> get _signupServiceClient => {
        'fname': fName.text,
        'lname': lName.text,
        'name': "${fName.text} ${lName.text}",
        'email': email.text,
        'phone': secondPhone.text,
        'password': password.text,
        "userType": "private_client",
        "platform": "mobile"
      };

  Map<String, dynamic> get _signupServiceCorporate => {
        'fname': fName.text,
        'lname': lName.text,
        'name': "${fName.text} ${lName.text}",
        'email': email.text,
        'phone': secondPhone.text,
        'company_name': companyName.text,
        'password': password.text,
        "userType": "corporate_client",
        "platform": "mobile"
      };

  Map<String, dynamic> get _signupServiceSupplier => {
        'fname': fName.text,
        'lname': lName.text,
        'name': "${fName.text} ${lName.text}",
        'email': email.text,
        'phone': secondPhone.text,
        'company_name': companyName.text,
        'password': password.text,
        "userType": "vendor",
        "platform": "mobile"
      };

  //Sign In
  Future<void> signIn(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      ApiResponse response = await userRepo.signIn(_signInPayload);
      if (response.isSuccessful) {
        var logInInfo = LogInModel.fromJson(response.user);
        response.user = logInInfo;
        var token = response.token;
        MyPref.logInDetail.val = jsonEncode(response.user);
        MyPref.authToken.val = token.toString();
        MyPref.refreshToken.val = response.refreshToken.toString();
        ApiResponse bankListResponse = await userRepo.getBanks();

        final newRes = await userRepo
            .getData('/user/me?userType=${logInInfo.profile!.userType}');
        final userDetails = UserDetailsModel.fromJson(newRes.user);
        MyPref.userDetails.val = jsonEncode(userDetails);

        if (bankListResponse.isSuccessful && newRes.isSuccessful) {
          MyPref.bankListDetail.val = jsonEncode(bankListResponse.data);

          Get.offAndToNamed(Home.route);
        } else {
          AppOverlay.showInfoDialog(
            title: "Error",
            content: "An error occurred, Please try again",
            buttonText: "Okay",
            onPressed: () {
              Get.back();
            },
          );
        }
      } else {
        AppOverlay.showInfoDialog(
          title: response.isSuccessful ? 'Success' : 'Failure',
          content: response.message,
          buttonText: response.message == 'Please Verify account'
              ? 'Verify'
              : "Continue",
          onPressed: () async {
            if (response.isSuccessful) {
            } else {
              if (response.message == 'Please Verify account') {
                final response = await userRepo.postData('/user/resend-token',
                    {"email": email.text, "platform": "mobile"});
                if (response.isSuccessful) {
                  Get.toNamed(VerifySignUpOTP.route);
                } else {
                  AppOverlay.showInfoDialog(
                      title: 'Error',
                      content: response.message,
                      buttonText: 'Continue');
                }
              } else {
                Get.back();
              }
            }
          },
        );
      }
    }
  }

  Map<String, dynamic> get _signInPayload =>
      {'email': email.text, 'password': password.text, "platform": "mobile"};

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
