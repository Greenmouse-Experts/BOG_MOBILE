
// ignore_for_file: camel_case_types
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:bog/app/base/base.dart';



class listDialog extends StatefulWidget {
  final String? title;
  final items;
  final List? images;
  final bool useTint;
  final List? selections;
  final bool singleSelection;

  listDialog(this.items,
      {
      this.title,
      this.images,
      this.useTint=false,
      this.selections,
      this.singleSelection=true});

  @override
  _listDialogState createState() => _listDialogState();
}

class _listDialogState extends State<listDialog> {

  late List selections;
  late bool multiple;
  bool showBack=false;
  bool hideUI=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    multiple = widget.selections !=null;
    selections = widget.selections??[];

    Future.delayed(const Duration(milliseconds: 200),(){
      hideUI=false;
      setState(() {});
    });
    Future.delayed(const Duration(milliseconds: 500),(){
      showBack=true;
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      GestureDetector(
        onTap: () {
          closePage((){ Navigator.pop(context);});
        },
        child: AnimatedOpacity(
          opacity: showBack?1:0,duration: const Duration(milliseconds: 300),
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
    ]);
  }

  page() {
    return AnimatedOpacity(
      opacity: hideUI?0:1,duration: const Duration(milliseconds: 400),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: getScreenWidth(context)>500?500:double.infinity,
        ),
          padding: const EdgeInsets.fromLTRB(30, 45, 30, 25),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: white,elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                Container(
                  height: 75,
//                  decoration: BoxDecoration(
//                    color: red3,
//
//                  ),
                ),
                Container(
                  height: 80,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100)
                      )
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: Opacity(opacity: .3,child: Image.asset(ic_plain,height: 25,width: 25,)),
//                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if(widget.title!=null)Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          widget.title!,
                          style: textStyle(false, 16, red3),
                        ),
                      ),
                      addSpace(5),
//                addLine(.5, black.withOpacity(.1), 0, 0, 0, 0),
                      Flexible(fit: FlexFit.loose,
                        child: Container(
//                        color: white,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(

                                maxHeight: (MediaQuery.of(context).size.height / 2) +
                                    (MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? 0
                                        : (MediaQuery.of(context).size.height / 5))),
                            child: Scrollbar(
                              child: ListView.builder(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                itemBuilder: (context, position) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      position == 0
                                          ? Container()
                                          : addLine(
                                              .5, black.withOpacity(.1), 0, 0, 0, 0),
                                      GestureDetector(
                                        onTap: () {
                                          if(multiple){
                                            bool selected = selections.contains(widget.items[position]);
                                            if(selected){
                                              selections.remove(widget.items[position]);
                                            }else{
                                              if(widget.singleSelection){
                                                selections.clear();
                                              }
                                              selections.add(widget.items[position]);
                                            }
                                            setState(() {

                                            });
                                            return;
                                          }
                                          Navigator.of(context).pop(widget.items[position]);
                                        },
                                        child: Container(
                                          color: white,
                                          width: double.infinity,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                widget.images==null
                                                    ? Container()
                                                    : !(widget.images![position] is String)
                                                        ? Icon(
                                                            widget.images![position],
                                                            size: 20,
                                                            color: !widget.useTint
                                                                ? null
                                                                : red3,
                                                          )
                                                        : Image.asset(
                                                            widget.images![position],
                                                            width: 20,
                                                            height: 20,
                                                            color: !widget.useTint
                                                                ? null
                                                                : red3,
                                                          ),
                                                widget.images!=null
                                                    ? addSpaceWidth(10)
                                                    : Container(),
                                                Flexible(
                                                  flex:1,fit:FlexFit.tight,
                                                  child: Text(
                                                    widget.items[position],
                                                    style: textStyle(
                                                        false, 16, black.withOpacity(.8)),
                                                  ),
                                                ),
                                                if(multiple)addSpace(10),
                                                // if(multiple)checkBox(selections.contains(widget.items[position]))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: widget.items.length,
                                shrinkWrap: true,
                              ),
                            ),
                          ),
                        ),
                      ),
//                addLine(.5, black.withOpacity(.1), 0, 0, 0, 0),
                      if (multiple && selections.isNotEmpty)
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
//                      width: double.infinity,
                              height: 40,
                              margin: const EdgeInsets.all(10),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),backgroundColor: blue0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    /*if(selections.isEmpty){
                                      toastInAndroid("Nothing Selected");
                                      return;
                                    }*/
                                    closePage((){ Navigator.pop(context,selections);});
                                  },
                                  child: Text(
                                    "OK",
                                    style: textStyle(true, 16, white),
                                  ))),
                        )
                      //gradientLine(alpha: .1)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  closePage(onClosed){
    showBack=false;
    setState(() {

    });
    Future.delayed(const Duration(milliseconds: 100),(){
      Future.delayed(const Duration(milliseconds: 100),(){
        hideUI=true;
        setState(() {});
      });
      onClosed();
    });
  }
}
