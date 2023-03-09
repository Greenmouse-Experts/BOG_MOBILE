
import 'package:bog/app/base/base.dart';
import 'package:bog/core/utils/time_utils.dart';
import 'package:bog/core/widgets/click_text.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerWidget extends StatefulWidget {
  final String? label;
  final String hint;
  final DateTime? date;
  final Function(DateTime date) onSelected;
  const DatePickerWidget(this.onSelected,{
    this.label,
    this.hint="",
    this.date,
    Key? key}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {

  late String hint = widget.hint;
  late String? label = widget.label;
  late DateTime? date = widget.date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String text = date==null?"":getSimpleDate(date!.millisecondsSinceEpoch);
    return ClickText(hint, text, (){

      bool empty = date==null;

      int? year;
      int? month;
      int? day;
      if (!empty) {
        int time = date!.millisecondsSinceEpoch;
        year = DateTime.fromMillisecondsSinceEpoch(time).year;
        month = DateTime.fromMillisecondsSinceEpoch(time).month;
        day = DateTime.fromMillisecondsSinceEpoch(time).day;
      }


      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: DateTime.now().subtract(Duration(days: 365*50)),
        maxTime: DateTime.now(),
        onChanged: (date) {},
        onConfirm: (d) {
          date = d;
          widget.onSelected(date!);
          setState(() {});
        },
        currentTime: empty ? null : DateTime(year!, month!, day!),
        // locale:LocaleType.en
      );
    },label:widget.label);
  }
}
