
import 'dart:async';
import 'package:flutter/material.dart';
import '../popup_widget.dart';

class PopupScreen extends StatefulWidget {
  const PopupScreen({Key? key}) : super(key: key);

  @override
  State<PopupScreen> createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen> {

  late StreamSubscription streamSubscription;
  String popMessage = "";
  bool popError = false;
  bool showPop = false;
  IconData? popIcon;

  @override
  void initState() {
    streamSubscription = PopupController.instance.stream.listen((event) {
      showPopup(event);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        IgnorePointer(
          ignoring: true,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: showPop?(.6):0,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          top: showPop?30:(-100),
          child: IgnorePointer(
            ignoring: true,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: showPop?1:0,
              child: Container(
                  // width: getScreenWidth(context)-40,
                  margin: const EdgeInsets.all(30),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    color: popError?Colors.red:Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15,15,15,15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(popIcon??Icons.error_outline, size:20,color:Colors.white),
                          const SizedBox(width:10),
                          Flexible(
                            child: Text(popMessage,style: const TextStyle(fontSize:16,
                                color:Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),
        )
      ],
    );
  }

  void showPopup(PopupModel popupModel){
    popIcon=popupModel.icon;
    popMessage = popupModel.message;
    popError = popupModel.popupType==PopupType.error;
    showPop = true;
    if(mounted)setState(() {});
    Future.delayed(const Duration(milliseconds: 1500),(){
      showPop = false;
      if(mounted)setState(() {});
    });
  }
}
