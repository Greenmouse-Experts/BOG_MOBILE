import 'dart:io';
import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/string_utils.dart';
import 'package:bog/core/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bog/core/utils/transitions.dart';
import 'package:bog/core/widgets/popup_widget/bloc/popup_controller.dart';
import 'package:flutter/services.dart';

import '../widgets/loading_widget/loading_widget.dart';

double getScreenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getScreenWidth(context) {
  return MediaQuery.of(context).size.width;
}

double getFittedHeight(
    BuildContext context, double originalImageWidth, double originalImageHeight,
    {double padding = 0}) {
  double heightRatio = originalImageWidth / originalImageHeight;

  double adjustedScreenWidth = getScreenWidth(context) - padding;

  double diff = (adjustedScreenWidth - originalImageWidth);

  double ratio = diff / heightRatio;

  double fittedHeight = originalImageHeight + ratio;

  return fittedHeight;
}

double getFittedWidth(double originalImageWidth, double originalImageHeight,
    double screenHeight) {
  double widthRatio = originalImageHeight / originalImageWidth;

  double diff = (screenHeight - originalImageHeight);

  double ratio = diff / widthRatio;

  double fittedWidth = originalImageWidth + ratio;

  return fittedWidth;
}

// double getFittedWidth(context,
//     double width, double height, double sh,
//     {double padding = 0}) {
//   double wratio = height / width;
//   double diff = (sh - height);
//   double ratio = diff / wratio;
//   double w1 = width + ratio;
//   return w1;
// }

addExpanded() {
  return Expanded(
    child: Container(),
    // fit: FlexFit.tight,
  );
}

addFlexible() {
  return Flexible(
    child: Container(),
    fit: FlexFit.tight,
  );
}

Container addLine(double size, Color color, double left, double top,
    double right, double bottom) {
  return Container(
    height: size,
    width: double.infinity,
    color: color,
    margin: EdgeInsets.fromLTRB(left, top, right, bottom),
  );
}

Widget imageItem(icon, double size, color, {bool ignoreWidth = false}) {
  return icon is IconData
      ? Icon(
          icon,
          size: size,
          color: color,
        )
      : Image.asset(
          icon,
          width: ignoreWidth ? null : size,
          height: size,
          color: color,
        );
}

SizedBox addSpace(double size) {
  return SizedBox(
    height: size,
  );
}

addSpaceWidth(double size) {
  return SizedBox(
    width: size,
  );
}

Widget tightBox(Widget child){
  return Flexible(
      fit: FlexFit.tight,
      child: child);
}

textStyle(bool bold, double size, color,
    {underlined = false,
    bool withShadow = false,
    double shadowOffset = 4.0,
    bool crossed = false,
    int type = 2,
    double? height,
    bool thick = false,
    bool light = false,
    bool semi = false}) {
  return TextStyle(
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontStyle: FontStyle.normal,
      height: height,
      // fontFamily: type == 2 && light
      //     ? "EuclidCircularB-Light"
      //     : type == 2 && semi
      //         ? "EuclidCircularB-SemiBold"
      //         : type == 2 && !bold
      //             ? "EuclidCircularB-Regular"
      //             : type == 2 && bold
      //                 ? "EuclidCircularB-Bold"
      //                 : "FiraSans-Regular",
      fontSize: size,
      shadows: !withShadow
          ? null
          : (<Shadow>[
              Shadow(
                  offset: Offset(shadowOffset, shadowOffset),
                  blurRadius: 8.0,
                  color: Colors.black.withOpacity(.2)),
            ]),
      decoration: crossed
          ? TextDecoration.lineThrough
          : underlined
              ? TextDecoration.underline
              : TextDecoration.none);
}

launchScreen(BuildContext context, item,
    {Function(dynamic d)? result,
    opaque = false,
    bool replace = false,
    transitionBuilder,
    transitionDuration,
    bool scale = false,
    slideUp = false,
    slide = false,
    fade = false,
    bool ignoreIOS = true}) {
  PageRoute pageRoute = createPageRoute(item,
  result: result,scale: scale,
  fade: fade,ignoreIOS: ignoreIOS,opaque: opaque,
  replace: replace,slide: slide,slideUp: slideUp,
  transitionBuilder: transitionBuilder,transitionDuration: transitionDuration);

  if (replace) {
    Navigator.pushReplacement(context, pageRoute).then((_) {
      if (_ != null) {
        if (result != null) result(_);
      }
    });
    return;
  }
  Navigator.push(context, pageRoute).then((_) {
    if (_ != null) {
      if (result != null) result(_);
    }
  });
}

PageRoute createPageRoute(Widget item,
    {Function(dynamic d)? result,
    opaque = false,
    bool replace = false,
    transitionBuilder,
    transitionDuration,
    bool scale = false,
    slideUp = false,
    slide = false,
    fade = false,
    bool ignoreIOS = true}) {
  PageRoute pageRoute = Platform.isIOS && !ignoreIOS
      ? CupertinoPageRoute(
          builder: (context) {
            return item;
          },
        )
      : PageRouteBuilder(
          transitionsBuilder: scale
              ? scaleTransition
              : fade
                  ? fadeTransition
                  : slideUp
                      ? slideUpTransition
                      : scaleTransition,
                      // : defaultTransitionsBuilder,
          transitionDuration:
              transitionDuration ?? const Duration(milliseconds: 300),
          opaque: opaque,
          pageBuilder: (context, _, __) {
            return item;
          });
  return pageRoute;
}

Widget loadingLayout(
    {bool trans = false,
    double? height,
    bool fullPage = false,
    onClosed,
    color = Colors.blue,
    backColor = Colors.black,
    titleColor = Colors.black,
    double bottom = 0,
    String message = ""}) {
  Widget child = Center(child: loadingBar(color: color, text: message));
  return Container(
    color: trans ? Colors.transparent : backColor,
    child: fullPage
        ? SafeArea(
            child: Container(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  child,
                  if (onClosed != null)
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(left: 20, top: 20),
                          child: TextButton(
                            onPressed: () {
                              onClosed();
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              shape: const CircleBorder(
                                  side: const BorderSide(
                                      color: Colors.blue, width: 2)),
                              // backgroundColor: Colors.black.withOpacity(top?(.1):0)
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                        ))
                ],
              ),
            ),
          )
        : Container(
            width: double.infinity,
            height: height,
            child: child,
          ),
  );
}

Widget loadingBar(
    {color = Colors.blue,
    double size = 25,
    bool loading = true,
    double topMargin = 0,
    double bottomMargin = 0,
    String? text}) {
  return Align(
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: size + 10,
            height: size + 10,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2)),
            // margin: EdgeInsets.only(bottom: 2,left: 2.5,),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(color),
              strokeWidth: 2,
            )),
        if (text != null)
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              text,
              style: textStyle(false, 14, color.withOpacity(.5)),
            ),
          )
      ],
    ),
  );
}

///Use this method to show a loading page in front of the screen
void showLoading({String? message, bool cancellable = true}) {
  LoadingController.instance
      .showLoading(message: message, cancellable: cancellable);
}

///Use this method to hide a loading page from the screen
void hideLoading() {
  LoadingController.instance.hideLoading();
}

///Use this method to show a popup dialog on a screen
void showPopup(String message,
    {String title = "", bool error = true, icon, int delayInMilli = 1500}) {
  if (!error) {
    PopupController.instance.showPopup(
      message: message,
      icon: icon,
    );
  } else {
    PopupController.instance.showErrorPopup(message: message);
  }
}

Widget checkBox(bool selected,
    {double size= 16,
    checkColor = app_color,
    iconColor,
    boxColor,
    onChecked,
    Widget? child}) {
  iconColor = iconColor ?? whiteColor;
  boxColor = boxColor ?? blue0;
  return GestureDetector(
    onTap: onChecked == null
        ? null
        : () {
            onChecked(!selected);
          },
    child: Row(
      children: [
        Container(
          //duration: Duration(milliseconds: 600),
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: selected ? transparent : boxColor.withOpacity(.2),
              border:
                  Border.all(color: whiteColor.withOpacity(.1), width: 1.5)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            width: size,
            height: size,
            // margin: const EdgeInsets.all(.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: selected ? checkColor : transparent,
            ),
            child: Icon(
              Icons.check,
              size: size - 2,
              color: !selected ? transparent : iconColor,
            ),
          ),
        ),
        if (child != null)
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: child,
            ),
          )
      ],
    ),
  );
}

Widget circleImage(double size, String image,
    {onTap,
      borderColor = default_white,
      icon,
      double iconSize = 20,
      String? abbr,
      iconColor = black,
      double borderWidth = 0.0}) {
  icon = icon ?? "ic_user".png;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: size,
      height: size,
      child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          color: borderColor,
          shape: CircleBorder(
              side: BorderSide(color: borderColor, width: borderWidth)),
          child: Container(
            width: size,
            height: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: abbr != null
                      ? Text(
                    abbr,
                    style: textStyle(false, 16, iconColor),
                  )
                      : icon is IconData
                      ? Icon(icon, size: iconSize, color: iconColor)
                      : Image.asset(
                    icon,
                    height: iconSize,
                    width: iconSize,
                    color: iconColor,
                  ),
                ),
                if (image != null && image.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          )),
    ),
  );
}

scrollDown(ScrollController scrollController){
  scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.ease);
}

Widget rowItem(String title,var item,
    {bool isAmount=false,bool isDate=false,bool hideBottomLine=false,
      bool copy=false,context,double textSize=13,textColor,bool bold=false})
{
  textColor = textColor ?? blackColor;
  String text = item==null||item=="null"?"":item.toString();
  String dateText = "-";
  try{
    dateText = getSimpleDate(item);
  }catch(e){}
  return Container(
    margin: EdgeInsets.only(top: 8),
    // padding: EdgeInsets.only(bottom: 8),
    // decoration: BoxDecoration(
    //     border: Border(
    //         bottom: BorderSide(
    //             color: hideBottomLine?transparent: black.withOpacity(.1),width: .3
    //         )
    //     )
    // ),
    child: Row(
      children: [
        Flexible(fit: FlexFit.tight,
          child: Container(
            width: 100,
            child: Text(title,style: textStyle(false, textSize, blackColor.withOpacity(.4))),
          ),
        ),
        addSpaceWidth(5),
        Flexible(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: BoxDecoration(
              color: whiteColor4,borderRadius: BorderRadius.circular(10)
            ),
            child: RichText(text: TextSpan(
                children: [
                  if(isAmount)WidgetSpan(child: Container(
                      margin: EdgeInsets.only(bottom: 3,right: 3),
                      child: Image.asset(
                        "naira1".png,
                        width: textSize-4,
                        height: textSize-4,
                        color: textColor,
                      )),),
                  TextSpan(text:
                  text==null || text.isEmpty?"-":
                  isDate?dateText:
                  !isAmount?"$text":"${formatAmount(text,decimal: 0)}"
                      ,style: textStyle(bold, textSize, textColor,)),
                ]
            ),textAlign: TextAlign.left,),
          ),
        ),
        if(copy)GestureDetector(
          onTap: (){
            Clipboard.setData(ClipboardData(text: text));
            showMessage(context, Icons.copy, blue0, "Copied", "");
          },
          child: Container(
              margin: EdgeInsets.only(left: 5),
              color: transparent,
              child: Icon(Icons.copy,color: black.withOpacity(.5),size: textSize,)),
        )
      ],
    ),
  ) ;
}
