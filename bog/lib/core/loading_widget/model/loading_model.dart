import '../loading_widget.dart';

class LoadingModel{

  final String? message;
  final LoadingType loadingType;
  final bool hideLoading;

  LoadingModel({
    this.message,
    this.loadingType=LoadingType.normal,
    this.hideLoading=false,
});
}