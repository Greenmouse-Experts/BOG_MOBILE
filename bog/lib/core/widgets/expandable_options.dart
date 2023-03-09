
import 'package:flutter/material.dart';
import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/core/utils/widget_util.dart';

class ExpandableOptions extends StatefulWidget {
  final Widget child;
  final List listItems;
  final Function(String item) onSelected;
  final double childHeight;
  const ExpandableOptions(
      {
        required this.child,
        required this.listItems,
        required this.onSelected(String item),
        required this.childHeight,
        Key? key}) : super(key: key);

  @override
  State<ExpandableOptions> createState() => _ExpandableOptionsState();
}

class _ExpandableOptionsState extends State<ExpandableOptions> {

  bool selectionMode = false;
  String? selectedItem;

  Future delay(milli)async{
    if(milli==0)return 1;
    await Future.delayed(Duration(milliseconds: milli));
    return 1;
  }

  @override
  Widget build(BuildContext context) {

    List list = widget.listItems;
    double childHeight = widget.childHeight;
    double size = 50;
    return AnimatedSize(
      duration: Duration(milliseconds: !selectionMode?100:500),
      // width: double.infinity,
      // height: !selectionMode?childHeight:
      // double.parse(((childHeight + 20 +  (list.length * size)).toString())),
      //    margin: EdgeInsets.only(bottom: 15),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
          onPressed: (){
            selectionMode=!selectionMode;
            setState((){});
          },
          child: Container(width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.child,
                // if(selectionMode),
                  Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(list.length, (index){
                      String name = list[index];

                      return Flexible(
                        child: Container(
                          width: double.infinity,
                          height: selectionMode?size:0, //+ (index==0?20:0),
                          margin: EdgeInsets.only(top: selectionMode?10:0),
                          // decoration: BoxDecoration(
                          //     border: Border(
                          //         bottom: BorderSide(
                          //             color:
                          //             index==list.length-1?Colors.transparent:
                          //             blackColor.withOpacity(.1),width: 1
                          //         )
                          //     )
                          // ),
                          child: TextButton(
                              onPressed: (){
                                selectionMode = false;
                                selectedItem=name;
                                widget.onSelected(name);
                                setState((){});
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: whiteColor4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  elevation: 0
                              ),
                              child: Text(name,style:textStyle(false,15,blackColor)),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          )),
    );
  }

}