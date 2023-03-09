// import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
// import 'package:detectable_text_field/widgets/detectable_text.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'package:bog/app/base/base.dart';
//
//
// class ReadMoreText extends StatefulWidget {
//   String text;
//   bool full;
//   var toggle;
//   int minLength;
//   double fontSize;
//   var textColor;
//   var moreColor;
//   bool center;
//   bool canExpand;
//   bool light;
//
//   ReadMoreText(this.text,
//       {this.full = false,
//         this.minLength = 200,
//         this.fontSize = 16,
//         this.toggle,
//         this.textColor = black,
//         this.moreColor = red0,
//         this.center=false,
//         this.canExpand=true,
//         this.light=false,
//         Key? key
//       }):super(key:key);
//
//   @override
//   _ReadMoreTextState createState() => _ReadMoreTextState();
// }
//
//
//
// class _ReadMoreTextState extends State<ReadMoreText> {
//   late bool expanded;
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     expanded = widget.full;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String urlRegexContent = "((http|https)://)(www.)?" +
//         "[a-zA-Z0-9\-@:%._\\+~#?&//=]" +
//         "{2,256}\\.[a-z]" +
//         "{2,6}\\b([-a-zA-Z0-9@:%" +
//         "._\\+~#?&//=]*)";
//     return  AnimatedSize(duration: Duration(milliseconds: 300),
//       child: DetectableText(
//         trimLength: widget.minLength,
//         colorClickableText: red0,
//         trimMode: TrimMode.Length,
//         trimCollapsedText: 'more',
//         trimExpandedText: '...less',
//         text:widget.text,
//         lessStyle: textStyle(true, widget.fontSize - 2, widget.moreColor,
//             underlined: false),
//         moreStyle: textStyle(true, widget.fontSize - 2, widget.moreColor,
//             underlined: false),
//         detectionRegExp: RegExp(
//           "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
//           multiLine: true,
//         ),
//         callback: (bool readMore) {
//           debugPrint('Read more >>>>>>> $readMore');
//         },
//         onTap: (tappedText) async {
//           print(tappedText);
//           if (tappedText.startsWith('#')) {
//             // launchScreen(context, SearchMain(tappedText));
//           } else if (tappedText.startsWith('@')) {
//             String text = tappedText.replaceAll("_", " ");
//             text = text.replaceAll("@", "");
//             // launchScreen(context, SearchMain(text.trim(),page:1));
//             debugPrint('DetectableText >>>>>>> @');
//           } else if (tappedText.startsWith('http')) {
//             launch(tappedText);
//           }
//         },
//         basicStyle: textStyle(false, widget.fontSize, widget.textColor,light: widget.light),
//         detectedStyle: textStyle(false, widget.fontSize, blue0),
//       ),
//     );
//   }
//
//   text() {
//     return RichText(
//       text: TextSpan(children: [
//         WidgetSpan(
//             child:
//
//       DetectableText(
//       trimLength: widget.minLength,
//         colorClickableText: red0,
//         trimMode: TrimMode.Length,
//         trimCollapsedText: 'more',
//         trimExpandedText: '...less',
//         text:widget.text,
//         detectionRegExp: RegExp(
//           "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
//           multiLine: true,
//         ),
//         callback: (bool readMore) {
//           debugPrint('Read more >>>>>>> $readMore');
//         },
//         onTap: (tappedText) async {
//           print(tappedText);
//           if (tappedText.startsWith('#')) {
//             // launchScreen(context, SearchMain(tappedText));
//           } else if (tappedText.startsWith('@')) {
//             String text = tappedText.replaceAll("_", " ");
//             text = text.replaceAll("@", "");
//             // launchScreen(context, SearchMain(text.trim(),page:1));
//             debugPrint('DetectableText >>>>>>> @');
//           } else if (tappedText.startsWith('http')) {
//             launch(tappedText);
//           }
//         },
//         basicStyle: textStyle(false, widget.fontSize, widget.textColor),
//         detectedStyle: textStyle(false, widget.fontSize, blue0),
//       ),
//
//     //             HashTagText(text:
//     //   widget.text.length <= widget.minLength
//     //   ? widget.text
//     //           : expanded
//     //       ? widget.text
//     //           : (widget.text.substring(0, widget.minLength-1)),
//     // basicStyle: textStyle(false, widget.fontSize, widget.textColor),
//     // decorateAtSign: true,
//     // decoratedLink: true,
//     //                 onTap: (s){
//     //               print(s);
//     //                 },
//     // decoratedStyle: textStyle(false, widget.fontSize, blue0)
//     //   ),
//
//         ),
//
//         // TextSpan(
//         //     text: widget.text.length <= widget.minLength
//         //         ? widget.text
//         //         : expanded
//         //         ? widget.text
//         //         : (widget.text.substring(0, widget.minLength)),
//         //     style: textStyle(false, widget.fontSize, widget.textColor)),
//         TextSpan(
//             text: widget.text.length < widget.minLength || expanded ? "" : "...",
//             style: textStyle(false, widget.fontSize, black)),
//         TextSpan(
//           text: widget.text.length < widget.minLength
//               ? ""
//               : expanded ? " Read Less" : "Read More",
//           style: textStyle(true, widget.fontSize - 2, widget.moreColor,
//               underlined: false),
//           recognizer: new TapGestureRecognizer()
//             ..onTap = () {
//               setState(() {
//                 if(widget.canExpand)expanded = !expanded;
//                 if (widget.toggle != null) widget.toggle(expanded);
//               });
//             },
//         )
//       ],),textAlign: widget.center?TextAlign.center:TextAlign.left,);
//   }
// }