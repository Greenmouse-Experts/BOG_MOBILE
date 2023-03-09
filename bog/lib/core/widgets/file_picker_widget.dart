
import 'package:bog/app/base/base.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerWidget extends StatefulWidget {
  final double height;
  final String title;
  final PlatformFile? fileInfo;
  Function(PlatformFile fileInfo) onSelected;

  FilePickerWidget({
    this.height = 55,
    this.title="",
    required this.onSelected,
    this.fileInfo,
    Key? key}) : super(key: key);

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {

  PlatformFile? fileInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fileInfo = widget.fileInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.title.isNotEmpty)Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(widget.title,style: textStyle(false, 14, blackColor),)),

        AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 500),
            height: widget.height,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: whiteColor4,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
            child: Row(
              children: <Widget>[
                Container(
                  height: widget.height,
                child: TextButton(
                  onPressed: (){
                    selectFile();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    alignment: Alignment.center,
                    backgroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  child: Text("Choose File",style: textStyle(false, 14, blackColor),),

                ),
                ),
                addSpaceWidth(10),
                Flexible(
                  child:  Text(
                    fileInfo==null?"":fileInfo!.name,
                    style: textStyle(false, 16,
                        fileInfo==null ? blackColor.withOpacity(.5) : blackColor),
                    maxLines: 1,
                    overflow:  TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: true);
    if (result == null) return;

    fileInfo = result.files.first;
    setState(() {});
    widget.onSelected(fileInfo!);
  }
}
