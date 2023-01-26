import 'package:bog/app/base/base.dart';
import 'package:bog/core/widgets/dialogs/listDialog.dart';
import 'package:bog/core/widgets/dialogs/messageDialog.dart';


showErrorDialog(context,String message,{onOkClicked,bool cancellable=true,
  String okText="OK",int delay=600}){
  showMessage(context, Icons.error, red0, "Oops!",
      message,delayInMilli: delay,cancellable: cancellable,onClicked: (_){
    if(_==true){
      if(onOkClicked!=null)onOkClicked();
    }
      },clickYesText: okText,clickNoText: okText=="Retry"?"Cancel":null);
}

void showMessage(context, icon, iconColor, title, message,
    {int delayInMilli = 0,
    clickYesText = "OK",
    onClicked,
    clickNoText,
    bool cancellable = true,
    double iconPadding=0,
      bool isGif=false,
    bool = true}) {
  Future.delayed(Duration(milliseconds: delayInMilli), () {
    launchScreen(
        context,
        messageDialog(
          icon,
          iconColor,
          title,
          message,
          clickYesText,
          noText: clickNoText,
          cancellable: cancellable,
          iconPadding: iconPadding,
          isGif: isGif,
        ),ignoreIOS: true,
        result: (_){
          if(_==null)return;
          if(onClicked!=null)onClicked(_);
        },opaque: false,
        slideUp: true,
        transitionDuration: const Duration(milliseconds: 500)
    );
  });
}


void yesNoDialog(context, title, message, clickedYes,
    {bool cancellable = true, color = red0,clickYesText="Yes",clickNoText="Cancel"}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionsBuilder: slideUpTransition,
      opaque: false,
      pageBuilder: (context, _, __) {
        return messageDialog(
          Icons.error,
          color,
          title,
          message,
          clickYesText,
          noText: clickNoText,
          cancellable: cancellable,
        );
      },),).then((_) {
    if (_ != null) {
      if (_ == true) {
        clickedYes();
      }
    }
  });
}

showListDialog(context,List items, onSelected,
    {title, images, bool useTint = true,selections,bool returnIndex=false,
      bool singleSelection=false}){
  launchScreen(context,
      listDialog(items,
        title: title, images: images,useTint: useTint,selections: selections,
        singleSelection: singleSelection,),result: (_){
        if(_ is List){
          onSelected(_);
        }else{
          onSelected(returnIndex?items.indexOf(_):_);
        }
      },opaque: false,
      transitionBuilder:scaleTransition,
      transitionDuration: const Duration(milliseconds: 800),ignoreIOS: true);
}

showSuccessDialog(context,String message,{onOkClicked,bool cancellable=true,
  int delay=500,String? title}){
  showMessage(context,success_gif2, blue0, title??"Successful",
      message,delayInMilli: delay,isGif:true,cancellable: cancellable,onClicked: (_){
        if(_==true){
          if(onOkClicked!=null)onOkClicked();
        }
      });
}

