
// ignore_for_file: camel_case_types

import 'dart:ui';
import 'package:bog/app/base/base.dart';
import 'package:bog/core/utils/widget_util.dart';



class inputDialog extends StatefulWidget {
  final String title;
  final String message;
  final String? hint;
  final String? okText;
  // final TextEditingController editingController;
  final int clickBack;
  final TextInputType? inputType;
  final int maxLength;
  final bool allowEmpty;

  inputDialog(this.title,
      {required this.message, this.hint,this.clickBack=0, this.okText,
        this.inputType, this.maxLength = 10000, this.allowEmpty=false}); /*{
    this.title = title;
    this.message = message;
    this.hint = hint;
    this.okText = okText;
    this.inputType = inputType;
    this.maxLength = maxLength;
    this.allowEmpty = allowEmpty;
  }*/

  @override
  _inputDialogState createState() => _inputDialogState();
}

class _inputDialogState extends State<inputDialog> {
  late String title;
  late String message;
  late String? hint;
  late String? okText;
  late TextEditingController editingController;
  int clickBack = 0;
  late TextInputType? inputType;
  late int maxLength;
  bool allowEmpty = false;
  late StateSetter buttonState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message= widget.message;
    editingController = new TextEditingController(text: message);
    title= widget.title;
    hint= widget.hint;
    okText= widget.okText;
    inputType= widget.inputType;
    maxLength= widget.maxLength;
    allowEmpty= widget.allowEmpty;
  }

  @override
  Widget build(BuildContext c) {

    return Scaffold(backgroundColor: transparent,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: ClipRect(
              child:BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    color: black.withOpacity(.7),
                  ))
          ),
        ),
        page()
      ]),
    );
  }


  page() {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(50, 70, 50, 30),
        height: 300,
        child: Card(
          color: white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20,20,20,10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textStyle(false, 18, black),
                    ),
                    if(widget.hint!=null && widget.hint!.isNotEmpty)Text(
                      widget.hint!,
                      style: textStyle(false, 12, black.withOpacity(.3)),
                    ),

                  ],
                ),
              ),
              AnimatedContainer(duration: Duration(milliseconds: 500),
                width: double.infinity,
                height: errorText.isEmpty?0:40,
                color: red0,
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                child:Center(child: Text(errorText,style: textStyle(true, 16, white),)),
              ),
              new Expanded(
                flex: 1,
                child: Container(
                  // color: default_white,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(0),
                    child: new TextField(
                      //textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
                      autofocus: true,
                      maxLength: null,
                      decoration: InputDecoration(
                          // hintText: hint,
                        contentPadding: EdgeInsets.zero,
                          hintStyle: textStyle(
                            false,
                            25,
                            black.withOpacity(.3),light: true
                          ),
                          border: InputBorder.none),
                      style: textStyle(false, 25, black,light: true),
                      controller: editingController,
                      cursorColor: black,
                      cursorWidth: 1,
                      maxLines: null,
                      onChanged: (s){
                        if(buttonState!=null)buttonState((){});
                      },
                      keyboardType:
                      inputType == null ? TextInputType.multiline : inputType,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 40,
               width: 80,
               margin: EdgeInsets.all(15),
                  child:StatefulBuilder(
                    builder: (c,s){
                      if(buttonState==null)buttonState=s;
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              primary: blue0,elevation: 5,shadowColor: black.withOpacity(.3)
                          ),
                          onPressed:
                          editingController.text.trim().isEmpty

                              ?null:() {
                            String text = editingController.text.trim();
                            // if (text.isEmpty && !allowEmpty) {
                            //   showError( hint);
                            //   return;
                            // }
                            // if (text.length > maxLength) {
                            //   showError(
                            //       "Text should not be more than $maxLength characters");
                            //   return;
                            // }
                            Navigator.pop(context, text);
                          },
                          child: //Icon(Icons.send_rounded)
                          Text(
                            okText == null ? "OK" : okText!,
                            style: textStyle(true, 17, white),
                          )
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String errorText ="";
  showError(String text){
    errorText=text;
    setState(() {

    });
    Future.delayed(Duration(seconds: 1),(){
      errorText="";
      setState(() {

      });
    });
  }
}