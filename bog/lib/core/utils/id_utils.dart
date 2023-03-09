
import 'dart:math';
import 'package:uuid/uuid.dart';

String getRandomId() {
  var uuid = const Uuid();
  return uuid.v1();
}
String getRandomIdShort({int lenght=5,bool numberOnly=false}){
  var texts = "abcdefghijklmnopqrstuvwxyz";
  var nums = "123456789";

  String code = "";
  for(int i=0;i<=lenght;i++){
    bool useNum = numberOnly??Random().nextInt(2) == 0;
    if(useNum){
      code = code + nums[Random().nextInt(nums.length)];
    }else{
      bool upper = Random().nextInt(2) == 0;
      String s = texts[Random().nextInt(texts.length)];
      if(upper) s= s.toUpperCase();
      code = code + s;
    }
  }
  // if(/*isNumeric(code)*/true){
  //   int p = Random().nextInt(code.length);
  //   bool upper = Random().nextInt(2) == 0;
  //   String s = texts[Random().nextInt(texts.length)];
  //   if(upper) s= s.toUpperCase();
  //   code = code.substring(0,code.length-1) + s;
  // }
  return code;
}