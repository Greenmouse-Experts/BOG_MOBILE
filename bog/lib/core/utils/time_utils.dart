
import 'package:intl/intl.dart';

// class TimeUtils{

  String formatTime(int milli) {
    final formatter = DateFormat("d MMM");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
    return formatter.format(date);
  }

  String formatTime2(int milli) {
    final formatter = DateFormat("d MMM, yyyy");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
    return formatter.format(date);
  }

  String formatTime3(int milli) {
    final formatter = DateFormat("yyyy-MM-dd");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
    return formatter.format(date);
  }


  bool isSameDay(int time1, int time2) {
    DateTime date1 = DateTime.fromMillisecondsSinceEpoch(time1);

    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(time2);

    return (date1.day == date2.day) &&
        (date1.month == date2.month) &&
        (date1.year == date2.year);
  }
  bool isSameMonth(int time1, int time2) {
    DateTime date1 = DateTime.fromMillisecondsSinceEpoch(time1);

    DateTime date2 = DateTime.fromMillisecondsSinceEpoch(time2);

    return
      (date1.month == date2.month) &&
          (date1.year == date2.year);
  }

int getSeconds(String time) {
  List parts = time.split(":");
  int mins = int.parse(parts[0]) * 60;
  int secs = int.parse(parts[1]);
  return mins + secs;
}

String getChatTime(int milli) {
  final formatter = DateFormat("h:mm a");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}
String getShortTime(int milli) {
  final formatter = DateFormat("EE h:mma");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}


String getTransDate(int milli) {
  final formatter = DateFormat("M/d/y\nh:mm a");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}

String getMonthDate(int milli) {
  final formatter = DateFormat("MMM yyyy");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}


String getBvnDate(int milli) {
  final formatter = DateFormat("d-MMM-yyyy");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}

String getDateOfBirth(int milli) {
  final formatter = DateFormat("d MMM, yyyy");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}

String getTodaysDay({int? milli}) {
  final formatter = DateFormat("EEEE");
  DateTime date = milli!=null?DateTime.fromMillisecondsSinceEpoch(milli):DateTime.now();
  return formatter.format(date);
}

int getCurrentMonthInt() {
  final formatter = DateFormat("M");
  DateTime date = DateTime.now();
  return int.parse(formatter.format(date));
}

String getMonthName(int month) {
    if(month<0)return "";
    if(month>11)return "";
  List months = [
    "January","February","March","April","May","June","July","August",
    "September","October","November"
,"December"  ];
return months[month];
}



int getTodaysDayInt() {
  final formatter = DateFormat("EEEE");
  DateTime date = DateTime.now();
  String day = formatter.format(date);
  List days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday",];
  return days.indexOf(day);
}


String getDateFormat(int milli,String format) {
  final formatter = DateFormat(format);
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}

String getPaybackDate(int milli) {
  final formatter = DateFormat("EEEE MMMM d, yyyy");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}
String getRepayTimeString(int milli) {
  final formatter = DateFormat("h:mm a on EEEE MMMM d");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}

String getSimpleDate(int milli) {
    if(milli==0)return "";
  final formatter = DateFormat("d MMMM, yyyy");
  DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
  return formatter.format(date);
}





// }