

import 'package:bog/app/base/base.dart';

Widget ClickText(
    String title,
    String text,

    onClicked, {
      icon,
      double? height= 55,
      bool isAmount=false,
      bool curved = false,String? label,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if(label!=null)Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(label,style: textStyle(false, 14, blackColor),)),

      GestureDetector(
        onTap: (){
          onClicked();
        },
        child: AnimatedContainer(
          width: double.infinity,
          duration: const Duration(milliseconds: 500),
          height: height??(height),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: whiteColor4,
            borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            children: <Widget>[
              if (icon != null)
                Icon(
                  icon,
                  size: 18,
                  color: blackColor.withOpacity(.5),
                ),
              if (icon != null) addSpaceWidth(15),
              // if(isAmount && text.isNotEmpty)Image.asset(naira,height: 12,color: text.isEmpty ? blackColor.withOpacity(.3) : blackColor,),
              if(isAmount && text.isNotEmpty)addSpaceWidth(5),
              Flexible(
                child:  Text(
                  (text.isEmpty) ? title : text,
                  style: textStyle(false, 16,
                      text.isEmpty ? blackColor.withOpacity(.5) : blackColor),
                  maxLines: height==null?null:1,
                  overflow:  height==null?null:TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ),
      ),
    ],
  );
}

