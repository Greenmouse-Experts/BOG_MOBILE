
import 'dart:convert';

import 'package:bog/app/blocs/user_controller.dart';
import 'package:bog/app/data/model/log_in_model.dart';
import 'package:bog/app/data/providers/my_pref.dart';
import 'package:bog/setup.dart';

LogInModel get currentUser => UserController.instance.currentUser;

const String PAYSTACK_PUBLIC_KEY = "pk_test_77297b93cbc01f078d572fed5e2d58f4f7b518d7";
const String PAYSTACK_SECRETE_KEY = "sk_test_fde1e5319c69aa49534344c95485a8f1cef333ac";

String get getPayStackSecrete=>devMode?PAYSTACK_SECRETE_KEY:"";
String get getPayStackPublicKey=>devMode?PAYSTACK_PUBLIC_KEY:"";