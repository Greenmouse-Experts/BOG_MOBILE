import '../loading_widget/bloc/loading_controller.dart';

class Loader {
  static void showLoading({String? message, bool cancellable = true}) {
    AppLoadingController.instance
        .showLoading(message: message, cancellable: cancellable);
  }

  static void hideLoading() {
    AppLoadingController.instance.hideLoading();
  }
}
