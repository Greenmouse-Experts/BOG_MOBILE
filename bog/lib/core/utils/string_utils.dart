

List getSearchString(String text) {
  text = text.toLowerCase().trim();
  text = text.replaceAll(",", " ");
  if (text.trim().isEmpty) return [];

  List list = [];
  list.add(text);
  var parts = text.split(" ");
  for (String s in parts) {
    if (s.isNotEmpty && !list.contains(s)) list.add(s);
    for (int i = 0; i < s.length; i++) {
      String sub = s.substring(0, i);
      if (sub.isNotEmpty && !list.contains(sub)) list.add(sub);
    }
  }
  for (int i = 0; i < text.length; i++) {
    String sub = text.substring(0, i);
    if (sub.isNotEmpty && !list.contains(sub)) list.add(sub.trim());
  }
  String longText = text.replaceAll(" ", "");
  for (int i = 0; i < longText.length; i++) {
    String sub = longText.substring(0, i);
    if (sub.isNotEmpty && !list.contains(sub)) list.add(sub.trim());
  }
  return list;
}

String formatAmount(var text,{int decimal=0}) {
  if (text == null) return "0.00";
  text = text.toString();
  if (text.toString().trim().isEmpty) return "0.00";
  text = text.replaceAll(",", "");
  try {
    text = double.parse(text).toStringAsFixed(decimal);
  } catch (e) {}
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  return text.replaceAllMapped(reg, mathFunc);
}

String getTimerText(int seconds, {bool three = false}) {
  int hour = seconds ~/ Duration.secondsPerHour;
  int min = (seconds ~/ 60) % 60;
  int sec = seconds % 60;

  String h = hour.toString();
  String m = min.toString();
  String s = sec.toString();

  String hs = h.length == 1 ? "0$h" : h;
  String ms = m.length == 1 ? "0$m" : m;
  String ss = s.length == 1 ? "0$s" : s;

  return three ? "$hs:$ms:$ss" : "$ms:$ss";
}

String az = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String getLetterForPosition(int position) {
  return az.substring(position, position + 1);
}


String trimPhone(String phone){
  phone = phone.replaceAll(" ", "").trim();
  if(phone.startsWith("0")){
    return "+234${phone.substring(1)}";
  }
  if(phone.startsWith("+")){
    return phone;
  }

  return "+234$phone";
}


String convertListToString(String divider, List list,{bool noSpace=false,bool toString=false}) {
  StringBuffer sb = new StringBuffer();
  for (int i = 0; i < list.length; i++) {
    String s = list[i];
    sb.write(s);
    if(!toString) {
      if (divider != ",") sb.write(" ");
      if (i != list.length - 1) sb.write(divider);
      if (!noSpace) sb.write(" ");
    }
  }

  return sb.toString().trim();
}

List<String> convertStringToList(String divider, String text) {
  if(text.trim().isEmpty)return [];
  List<String> list = [];
  var parts = text.split(divider);
  for (String s in parts) {
    list.add(s.trim());
  }
  return list;
}
