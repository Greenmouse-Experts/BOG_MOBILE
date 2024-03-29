import 'dart:async';
import 'package:get/get.dart';
import '../loading_widget.dart';


// ignore: todo
// TODO: Please make sure you add this to your get_it instance

class AppLoadingController extends GetxController {
  static AppLoadingController get instance => Get.find();

  final StreamController<LoadingModel> _streamController =
      StreamController.broadcast();

  Stream<LoadingModel> get stream => _streamController.stream;

  void showLoading({String? message, bool cancellable = true}) {
    _streamController.add(LoadingModel(
        message: message,
        loadingType:
            cancellable ? LoadingType.normal : LoadingType.nonCancellable));
  }

  void hideLoading() {
    _streamController.add(LoadingModel(hideLoading: true));
  }
}
