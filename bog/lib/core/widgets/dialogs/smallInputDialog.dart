
// ignore_for_file: camel_case_types

import 'dart:ui';
import 'package:bog/app/base/base.dart';

class smallInputDialog extends StatefulWidget {
  final String title;
  final String message;
  final String errorText;
  final String hint;
  final String? okText;
  final int clickBack = 0;
  final TextInputType? inputType;
  final int maxLength;
  final bool allowEmpty;
  final bool hidden;
  final bool cancellable;
  final String subTitle;

  smallInputDialog(this.title,
      {required this.message, this.hint="", this.okText, this.inputType, this.maxLength = 10000, this.allowEmpty=false,
      this.errorText="Nothing to update",this.hidden=false,this.cancellable=false,this.subTitle=""}); /*{
    this.title = title;
    this.message = message;
    this.hint = hint;
    this.okText = okText;
    this.inputType = inputType;
    this.maxLength = maxLength;
    this.allowEmpty = allowEmpty;
  }*/

  @override
  _smallInputDialogState createState() => _smallInputDialogState();
}

class _smallInputDialogState extends State<smallInputDialog> {
  late String title;
  late String message;
  late String hint;
  late String? okText;
  late TextEditingController editingController;
  int clickBack = 0;
  late TextInputType? inputType;
  late int maxLength;
  late bool allowEmpty;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message= widget.message;
    editingController = TextEditingController(text: message);
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
            if(!widget.cancellable)return;
            Navigator.pop(context);
          },
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(
                color: black.withOpacity(.7),
              )),
        ),
        page()
      ]),
    );
  }


  page() {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
        height: 220,
        child: Card(
          color: white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,10,10),
                child: Row(
                  children: [
                    Flexible(fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
//                          Text(
//                            title,
//                            style: textStyle(true, 18, black),
//                          ),


                        ],
                      ),
                    ),
                    Container(
                      width: 40,height: 40,
                      child: TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Icon(Icons.cancel),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(2),
                          shape: CircleBorder(),),
                        ),
                    
                    )
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
              Expanded(
                flex: 1,
                child: Container(
//                  color: default_white,

                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(0),
                      child: TextField(
                        //textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.sentences,
                        autofocus: true,
                        maxLength: null,
                        decoration: InputDecoration(
                            hintText: widget.title,
                            hintStyle: textStyle(
                              false,
                              20,
                              black.withOpacity(.35),
                            ),
                            border: InputBorder.none),
                        style: textStyle(false, 20, black),
                        textAlign: TextAlign.center,
                        controller: editingController,
                        cursorColor: black,obscureText: widget.hidden,
                        cursorWidth: 1,
//                      maxLines: 1,
                        keyboardType:
                        inputType == null ? TextInputType.text : inputType,
                      ),
                    ),
                  ),
                ),
              ),
              if(widget.subTitle!=null && widget.subTitle.isNotEmpty)Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Center(
                  child: Text(
                    widget.subTitle,
                    style: textStyle(false, 12, black.withOpacity(.3)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Container(
//                width: double.infinity,
                  height: 40,
                  margin: EdgeInsets.all(15),
                  child:TextButton(
                       style: TextButton.styleFrom(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(25)),
                         backgroundColor: blue0,
                        ),
                      onPressed: () {
                        String text = editingController.text.trim();
                        if (text.isEmpty && !allowEmpty) {
                          showError( widget.title);
                          return;
                        }
                        if (text.length > maxLength) {
                          showError(
                              "Text should not be more than $maxLength characters");
                          return;
                        }
                        Navigator.pop(context, text);
                      },
                      child: Text(
                        okText == null ? "OK" : okText!,
                        style: textStyle(true, 16, white),
                      )),
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