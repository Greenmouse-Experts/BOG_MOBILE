import 'package:flutter/services.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/blocs/mode_controller.dart';

import '../utils/currency_formatter.dart';

class InputTextFieldModel{

  final String title;
  final String? hint;
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final bool optional;
  final dynamic prefill;

  InputTextFieldModel(this.title,{this.hint,this.optional=false,this.prefill});

  String get text=>textController.text.trim();
}

class InputTextField extends StatefulWidget {
  // final TextEditingController textController;
  // final bool useWhite;
  // final FocusNode? focusNode;
  final InputTextFieldModel inputTextFieldModel;
  final prefixIcon;
  // final String label;
  final maxLength;
  final maxLine;
  // final String? labelFocused;
  final double height;
  final bool hidden;
  final bool isPass;
  // final bool showPass;
  final TextInputType keyBoardType;
  final Function(String s)? onSubmit;
  // final onChanged;
  final Function? onEdit;
  final textInputAction;
  final TextCapitalization textCapitalization;
  final bool padTop;
  final bool loading;
  final bool isAmount;
  final double marginTop;
  final double marginBottom;
  final onUnfocused;
  final bool? isPhone;
  final Function(String pref)? onPhonePrefixSelected;
  final bool curved;
  final Function(bool on)? onChecked;
  final bool? checked;
  final double fontSize;
  // final String? hint;
  final bool readOnly;

  InputTextField(
  {required this.inputTextFieldModel,
    // this.useWhite=false,
    // required this.label,
    this.prefixIcon,
    // this.focusNode,
    this.maxLength,
    this.maxLine=1,
    // this.labelFocused,
    this.height = 55,
    this.hidden=false,
    this.isPass=false,
    // bool showPass=false,
    this.keyBoardType = TextInputType.text,
    this.onSubmit,
    // this.onChanged,
    this.onEdit,
    this.textInputAction= TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    this.padTop=true,
    this.loading=false,
    this.isAmount=false,
    this.marginTop=15,
    this.marginBottom=0,this.onUnfocused,
    this.isPhone,this.onPhonePrefixSelected,
    this.curved=false,this.onChecked,this.checked,
    this.fontSize=16,
    // this.hint,
    this.readOnly=false,
    Key? key}):super(key: key);
  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {

  bool showPass = false;
  var subs = [];
  late TextEditingController textEditingController;
  late FocusNode focusNode;

  @override
  void initState() {

    //listen for changes in dark mode
    subs.add(ModeController.instance.stream.listen((event) {
      if(mounted)setState(() {});
    }));

    textEditingController = widget.inputTextFieldModel.textController;
    if(widget.inputTextFieldModel.prefill!=null){
      textEditingController.text = "${widget.inputTextFieldModel!.prefill}";
    }
    focusNode = widget.inputTextFieldModel.focusNode;
    focusNode.addListener(() {
      if(widget.onUnfocused!=null && !focusNode.hasFocus){
        widget.onUnfocused();
      }
      if(mounted)setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    for(var sub in subs)sub.cancel();
    super.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    bool focused = focusNode.hasFocus;
    // String labelFocused = widget.labelFocused ?? widget.label;
    String? hint = widget.inputTextFieldModel.hint;
    String label = widget.inputTextFieldModel.title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if(hint!=null)Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text("${label}",style: textStyle(false, 14, blackColor),)),
        Row(
          children: [
            /*GestureDetector(
              onTap: () {
                pickCountry(context, (Country _) {
                  country=_;
                  setState(() {});
                });
              },
              child: Container(
                height: 30,
                width: 60,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: blue0,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Text(
                    "+${country.phoneCode}",
                    style: textStyle(true, 14, white),
                  ),
                ),
              ),
            ),*/
            Flexible(fit: FlexFit.tight,
              child:  AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: widget.maxLine>1?null:widget.height,
                // margin: EdgeInsets.fromLTRB(
                //     0,
                //     widget.height==0?0:widget.padTop?widget.marginTop:0,
                //     0,
                //     widget.height==0?0:widget.marginBottom),
                decoration: BoxDecoration(
                  color: whiteColor4,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: focused?blue0:transparent,width: 1.5)
                ),
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: textEditingController,
                  keyboardType:
                  widget.maxLine>1?TextInputType.multiline:
                  widget.isAmount?TextInputType.number:
                  widget.keyBoardType,
                  textCapitalization: widget.textCapitalization,
                  minLines: widget.maxLine,
                  textInputAction:
                  widget.maxLine>1?TextInputAction.newline:
                  widget.textInputAction,
                  // keyBoardType: TextInputType.multiline,
                  // textInputAction: TextInputAction.newline,
                  focusNode: focusNode,onSubmitted: (s,){
                  if(widget.onSubmit!=null)widget.onSubmit!(s);
                },
                  readOnly: widget.readOnly,
                  inputFormatters: widget.isAmount?[
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter()
                  ]:[],
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIconConstraints:
                  // !widget.isAmount?null:
                  const BoxConstraints(
                    maxWidth: 45,maxHeight: 16,minWidth: 45,
                  ),
                    contentPadding: EdgeInsets.fromLTRB(widget.prefixIcon==null?15:0, widget.maxLine>1?15:0, 15, widget.maxLine>1?15:0),
                    // counter: widget.height!=null?null:Container(),
                    prefixIcon:
                    widget.height==0?null:
                    widget.isAmount?
                    Container(margin: const EdgeInsets.only(bottom: 2,left: 10,right: 5),
                        child: Image.asset(
                          "naira1".png,width: 15,height: 15,color: focused?blue0: blackColor.withOpacity(.3)
                            .withOpacity(darkMode?(.5):(.3)),))
                        :
                    widget.prefixIcon==null?null:
                    widget.prefixIcon  is String ? (
                        Image.asset(widget.prefixIcon,
                          color: focused ? blue0 : blackColor.withOpacity(.5),
                      )
                    ) :
                    Icon(
                      widget.prefixIcon,
                      color: focused ? red0 : blackColor.withOpacity(.5),
                      size: 20,
                    ),
                    suffix:
                    // widget.onChecked!=null?
                    //     CustomCheckBox(onChecked: widget.onChecked!,defaultValue: widget.checked!,)
                    //
                    //     :
                    !widget.isPass?null:GestureDetector(
                        onTap: () {
                 showPass = !showPass;
//                       onChanged();
                        setState(() {});
                        },
                        child: Text(
                          showPass ? "HIDE  " : "SHOW  ",
                          style:
                          textStyle(false, 12, blackColor.withOpacity(.5)),
                        )),
                    // labelStyle: textStyle(
                    //   false,
                    //   16,
                    //   focused ? (red0) : blackColor.withOpacity(.35),
                    // ),
                    hintText: hint??label,
                    hintStyle: textStyle(false, 16, blackColor.withOpacity(.5)),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    // labelText: !focused ? widget.label : labelFocused,
                    // focusedBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(widget.curved?35:10),
                    //     borderSide: BorderSide(color:  (red0), width: 2)),
                    // enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(widget.curved?35:10),
                    //     borderSide: BorderSide(
                    //         color: widget.height==0?transparent:
                    //         blackColor.withOpacity(.35), width: 1)),
                  ),
                  style: textStyle(
                      false,
                      widget.isAmount?18:widget.fontSize,
                      blackColor,//height: 1.4
                  ),
                  obscureText:widget.hidden? true :  widget.isPass && !showPass,
                  onChanged: (s){
                  // AppManager.instance.timeOutController.add(true);
                  if(widget.onEdit!=null)widget.onEdit;
                  setState(() {});
                },
                  cursorColor: blackColor,
                  cursorWidth: 1,
                  maxLines: widget.maxLine > 1 ? null : widget.maxLine,
                  maxLength: widget.maxLength,

                ),
              ),
            ),
            if(widget.loading)Container(
                margin: const EdgeInsets.only(left: 10),
                width: 12,height: 12,
                child:const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(blue0),
                  strokeWidth: 2,
                ))
          ],
        ),
      ],
    );
  }
}
