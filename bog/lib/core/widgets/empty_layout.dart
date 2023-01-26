import 'dart:ui';
import 'package:bog/app/base/base.dart';
import 'package:flutter/material.dart';

 class EmptyLayout extends StatefulWidget {
   final onClosed;
   final icon;
   final String title;
   final String text;
   final  click;
   final String clickText;
   // final double height;
   final double bottomMargin;
   final double topMargin;
   final bool dontTint;
   final textColor;
   final String pageTitle;
   final Color? titleColor;
   final double backButtonSize;
   EmptyLayout(
       this.icon, this.title, this.text,
       {this.click, this.clickText="Retry",//this.height,
         this.topMargin=15,
         this.backButtonSize=45,
         this.bottomMargin=40,this.pageTitle="",this.titleColor,
         this.dontTint=false,this.onClosed,this.textColor}
       );
   @override
   _EmptyLayoutState createState() => _EmptyLayoutState();
 }

 class _EmptyLayoutState extends State<EmptyLayout> {

   @override
  void initState() {
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
     if(widget.onClosed!=null)
     return SafeArea(
       child: page(),
     );
     return page();
   }

   page(){
     String title= widget.title==null?"":widget.title;
     String text= widget.text==null?"":widget.text;
     return Stack(
       children: [
         Center(
           child: Container(
             // width: double.infinity,
             margin: EdgeInsets.fromLTRB(20,widget.topMargin,20,widget.bottomMargin),
             padding: const EdgeInsets.all(0),
             decoration: BoxDecoration(
                 // color: whiteColor3,
                 borderRadius: BorderRadius.circular(10)
             ),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 new Container(
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: black.withOpacity(.05)
                   ),
                     padding: const EdgeInsets.all(15),
                     child:
                     imageItem(widget.icon, 40, blackColor)),
                 addSpace(10),
                 if(title.isNotEmpty)Container(
                   child: Text(
                     title,
                     style: textStyle(false, 14, widget.textColor??blackColor),
                     textAlign: TextAlign.center,
                   ),
//                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                  decoration: BoxDecoration(
//                    color: default_white,
//                    borderRadius: BorderRadius.circular(25)
//                  ),
                 ),
                 if(text.isNotEmpty && title.isNotEmpty)addSpace(5),
                 if(text.isNotEmpty)Flexible(
                   child: Text(
                     text,
                     style: textStyle(false, 14, (widget.textColor??black).withOpacity(.5)),
                     textAlign: TextAlign.center,maxLines: 3,overflow: TextOverflow.ellipsis,
                   ),
                 ),
//            if(click!=null)addSpace(10),
                 if(widget.click!=null)Flexible(
                   child: Container(height: 40,
                     margin: const EdgeInsets.only(top: 10),
                     child: TextButton(
                         style: TextButton.styleFrom(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(25),//side: BorderSide(width: 2,color:black)
                           ),
                           backgroundColor:app_color,
                           padding: const EdgeInsets.fromLTRB(40,5,40,5),
                         ),
                         onPressed: widget.click,

                         child: Text(
                           widget.clickText,
                           style: textStyle(true, 15, white),
                         )),
                   ),
                 )
               ],
             ),
           ),
         ),
         if(widget.onClosed!=null)Align(alignment: Alignment.topLeft,
             child:Container(
               height: widget.backButtonSize,
               margin: const EdgeInsets.only(left: 0,top: 15,right: 0),
               child:  Row(
                 children: <Widget>[
                   Container(
                     width: widget.backButtonSize,
                     height: widget.backButtonSize,
                     margin: const EdgeInsets.only(
                         left: 10, right: 10),
                     child: TextButton(
                       onPressed: () {
                         widget.onClosed();
                       },
                       style: TextButton.styleFrom(
                         padding: const EdgeInsets.all(0),
                         shape: const CircleBorder(),
                       ),
                       child: Icon(
                         Icons.arrow_back_ios_new,
                         color:
                         widget.titleColor ?? blackColor,
                         size: 20,
                       ),
                     ),
                   ),
                   Flexible(
                       child: Align(
                         alignment: Alignment.center,
                         child: Text(
                           widget.pageTitle,
                           style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                               color: widget.titleColor ??
                                   blackColor),
                         ),
                       )),
                   SizedBox(
                     width: widget.backButtonSize + 20,
                   )
                 ],
               ),
             ))
       ],
     );
   }
 }
