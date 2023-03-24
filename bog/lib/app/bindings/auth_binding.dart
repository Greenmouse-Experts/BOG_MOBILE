import 'package:bog/core/loading_widget/bloc/loading_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../data/providers/api.dart';
import '../repository/user_repo.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(UserRepository(Api())));
    Get.lazyPut<HomeController>(() => HomeController(UserRepository(Api())));
    Get.lazyPut<AppLoadingController>(() => AppLoadingController());
  }
}
