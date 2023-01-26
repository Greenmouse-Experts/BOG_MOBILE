
// ignore_for_file: camel_case_types
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:bog/app/base/base.dart';

class messageDialog extends StatefulWidget {
  final icon;
  final Color iconColor;
  final String title;
  final String message;
  final String yesText;
  final String? noText;
  final bool cancellable;
  final double iconPadding;
  final bool isGif;

  messageDialog(
      this.icon, this.iconColor, this.title, this.message, this.yesText,
      {this.noText,
        this.cancellable = false,
        this.isGif=false,
        this.iconPadding = 0});
  @override
  _messageDialogState createState() => _messageDialogState();
}

class _messageDialogState extends State<messageDialog> {
  dynamic icon;
  late Color iconColor;
  late String title;
  late String message;
  late String yesText;
  late String? noText;
  late bool cancellable;
  late double iconPadding;
  bool showBack=false;
  bool hideUI=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    icon = widget.icon;
    iconColor = widget.iconColor;
    title = widget.title;
    message = widget.message;
    yesText = widget.yesText;
    noText = widget.noText;
    cancellable = widget.cancellable;
    iconPadding = widget.iconPadding;

    Future.delayed(Duration(milliseconds: 200),(){
      hideUI=false;
      setState(() {});
    });
    Future.delayed(Duration(milliseconds: 500),(){
      showBack=true;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (cancellable)closePage((){ Navigator.pop(context);});
        return Future.value(false);
      },
      child: Stack(fit: StackFit.expand, children: <Widget>[
        GestureDetector(
          onTap: () {
            if (cancellable) closePage((){ Navigator.pop(context);});
          },
          child: AnimatedOpacity(
            opacity: showBack?1:0,duration: Duration(milliseconds: 300),
            child: ClipRect(
                child:BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      color: black.withOpacity(.7),
                    ))
            ),
          ),
        ),
        page()
      ]),
    );
  }

  page() {
    return OrientationBuilder(
      builder: (c,o){
        return AnimatedOpacity(
          opacity: hideUI?0:1,duration: Duration(milliseconds: 400),
          child: Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              constraints: BoxConstraints(
                maxWidth: getScreenWidth(context)>500?500
                    :double.infinity,
                minWidth: getScreenWidth(context)/2
              ),
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: whiteColor,elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,20,20,15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.isGif?
                          Container(
                              width: 70,height: 70,
                              child: GifView.asset(widget.icon,frameRate: 35,color: blue0,
                                repeat: ImageRepeat.noRepeat,
                              )):
                          Container(
                              width: 60,
                              height: 60,
                              // padding: EdgeInsets.all(
                              //     iconPadding == null ? 0 : iconPadding),
                              decoration: BoxDecoration(
                                // border: Border.all(color: iconColor,width: 2),
                                shape: BoxShape.circle,
                              ),
                              child: (icon is String)
                                  ? (Image.asset(
                                icon,
                                color: iconColor,
                                width: 60,
                                height: 60,
                              ))
                                  : Icon(
                                icon,
                                color: iconColor,
                                size: 60,
                              )),
                          addSpace(10),
                          Text(
                            title,
                            style: textStyle(true, 20, blackColor),
                            textAlign: TextAlign.center,
                          ),
                          if(message.isNotEmpty)addSpace(10),
                          if(message.isNotEmpty)Flexible(
                            child: SingleChildScrollView(
                              child: Text(
                                "$message",
                                style: textStyle(false, 16, blackColor.withOpacity(.5)),
                                textAlign: TextAlign.center,
//                                    maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,10,20),
                      child: Wrap(
                        // mainAxisSize: MainAxisSize.min,
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          Container(
//                              height: 50,
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: blue0
                                ),
                                onPressed: () {
                                  closePage(() async {
//                                    await Future.delayed(Duration(milliseconds: 1000));
                                    Navigator.pop(context,true);});
                                },
                                child: Text(
                                  // "OK",
                                  yesText,
                                  maxLines: 1,
                                  style: textStyle(true, 18, white),
                                )),
                          ),
                          // if(noText!=null)addSpaceWidth(10),
                          if(noText!=null)Container(
//                          width: double.infinity,
//                              height: 50,
//                              margin: EdgeInsets.only(top: 5),
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: red0,width: 2)),
                                    backgroundColor: red0
                                ),

//                                    color: blue3,
                                onPressed: () {
                                  closePage((){ Navigator.pop(context,false);});
                                },
                                child: Text(
                                  noText!,maxLines: 1,
                                  style: textStyle(true, 18, white),
                                )),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  closePage(onClosed){
    showBack=false;
    setState(() {

    });
    Future.delayed(Duration(milliseconds: 200),(){
      Future.delayed(Duration(milliseconds: 400),(){
        hideUI=true;
        if(mounted)setState(() {});
      });
      onClosed();
    });
  }
}

