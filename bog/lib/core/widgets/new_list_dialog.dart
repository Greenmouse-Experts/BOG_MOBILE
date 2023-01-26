
import 'package:bog/app/base/base.dart';

class OptionData{
  final icon;
  final String title;
  final String? description;

  OptionData(this.icon,this.title,this.description,);
}

class NewListDialog extends StatefulWidget {
  final String title;
  final List<OptionData> items;
  final int? selectedPosition;
  final bool singleMode;
  final bool returnValue;
  NewListDialog(this.title,this.items,{this.selectedPosition,this.singleMode=false,this.returnValue=false});
   @override
   _NewListDialogState createState() => _NewListDialogState();
 }

 class _NewListDialogState extends State<NewListDialog> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedPosition = widget.selectedPosition;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showShareOptions();
    });

  }

   @override
   Widget build(BuildContext context) {
     return Container(

     );
   }

  int? selectedPosition;
   showShareOptions(){
     // int selectedPosition = shareType.index;
     showModalBottomSheet(
         backgroundColor: transparent,
         context: context, builder: (c){


       return StatefulBuilder(builder: (c,setState){


         return  Container(
           decoration: const BoxDecoration(
               color:white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(25),
                 topRight: Radius.circular(25),
               )
           ),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               // addSpace(10),
               Icon(Icons.drag_handle,size: 30,color: black.withOpacity(.2),),
               if(widget.title!=null && !widget.singleMode)
                 Padding(padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                 child:
                 Row(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     // if (icon != null)
                     //   Container(margin: EdgeInsets.only(right: 10),
                     //     padding: EdgeInsets.all(5),
                     //     decoration: BoxDecoration(
                     //         color: blue0,shape: BoxShape.circle
                     //     ),
                     //     child: imageItem(icon, 25,white,),
                     //   ),
                     Flexible(
                       fit:FlexFit.tight,
                       child:Text(widget.title,style: textStyle(true,20,blackColor),),
                     ),
                     if(!widget.singleMode)Container(
                         height:30,
                         // width: 40,
                         child:TextButton(
                             onPressed:
                             // selectedPosition==null?null:
                                 (){
                               if(selectedPosition==null)return;
                               Navigator.pop(context,selectedPosition);
                             },
                             style: TextButton.styleFrom(
                                 padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                 primary: transparent,
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(10)
                                 )
                             ),
                             child:Text("Done",style: textStyle(false, 16, blue0.withOpacity(selectedPosition==null?(.5):1)),)
                           //Icon(Icons.check,color: white,),
                         )
                     )
                   ],
                 ),),
               addLine(1, whiteColor3, 20, 0, 20, 10),
               Column(
                 children: List.generate(widget.items.length, (index){
                   OptionData option = widget.items[index];
                   return optionItem(option, selectedPosition==index,
                           (){
                     if(widget.singleMode){
                       Navigator.pop(context,index);
                       return;
                     }
                         setState((){
                           selectedPosition=index;
                         });
                       });
                 }),
               ),
               addSpace(10)
             ],
           ),
         );
       });
     },barrierColor:black.withOpacity(.5),isScrollControlled: true)
         .then((value) {
       if(value==null){
         Navigator.pop(context);
         return;
       }

       if(widget.returnValue){
         Navigator.pop(context,widget.items[value]);
         return;
       }
       Navigator.pop(context,value);

     });

   }

   Widget optionItem(OptionData optionData,bool selected,onTap){

     return GestureDetector(
       onTap: onTap,
       child: Container(
         color: transparent,
         width: double.infinity,
         padding: const EdgeInsets.fromLTRB(20,10,20,10),
         child: Row(
           // crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             if(optionData.icon!=null)Container(
               margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
               padding: const EdgeInsets.all(5),
               decoration: BoxDecoration(
                   color: whiteColor3,shape: BoxShape.circle
               ),
               child: imageItem(optionData.icon, 20,blackColor.withOpacity(.5),),
             ),
             Flexible(
                 fit: FlexFit.tight,
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(optionData.title,style: textStyle(false, 17, blackColor),),
                     if(optionData.description!=null
                         && optionData.description!.isNotEmpty)Container(
                         margin: const EdgeInsets.only(top: 5),
                         // decoration: BoxDecoration(
                         //     color: whiteColor3,
                         //     borderRadius: BorderRadius.circular(10)
                         // ),
                         // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                         child: Text(optionData.description!,style: textStyle(false, 12, blackColor2),)),
                   ],
                 )),
             addSpaceWidth(10),
             // if(!widget.singleMode)CustomCheckBox(defaultValue: selected,onChecked: (b)=>selected,)
           ],
         ),
       ),
     );
   }

 }
