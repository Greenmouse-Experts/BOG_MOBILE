
import 'package:bog/app/base/base.dart';
import 'package:bog/core/widgets/expandable_options.dart';

class CustomExpandable extends StatefulWidget {

  final String title;
  final Map options;
  Function(dynamic item) onSelected;
  CustomExpandable(this.title,this.options,this.onSelected,{Key? key}) : super(key: key);

  @override
  State<CustomExpandable> createState() => _CustomExpandableState();
}

class _CustomExpandableState extends State<CustomExpandable> {

  late String title;
  late Map options;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    options = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableOptions(
        listItems: options.keys.toList(),
        onSelected: (_) {
          title = _;
          String itemId = options[title];
          setState(() {});
          widget.onSelected(itemId);
        },
        childHeight: 55,
        child: Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
              color: whiteColor4,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              addSpaceWidth(15),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  title,
                  style: textStyle(
                      false,
                      16,
                      blackColor.withOpacity(
                          title.isNotEmpty ? (1) : .5)),
                ),
              ),
              Icon(
                Icons.arrow_drop_down_outlined,
                size: 25,
                color: blackColor.withOpacity(.5),
              ),
              addSpaceWidth(15),
            ],
          ),
        ));
  }
}
