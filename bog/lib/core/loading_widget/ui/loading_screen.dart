import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../loading_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  late StreamSubscription streamSubscription;

  bool showLoading = false;
  String? message;
  bool cancelable = true;
  bool showBack = false;
  int counter = 0;
  // bool hideUI=true;

  @override
  void initState() {
    super.initState();

    streamSubscription = LoadingController.instance.stream.listen((event) {
      bool show = !event.hideLoading;
      message = event.message;
      cancelable = event.loadingType == LoadingType.normal;
      if (show) {
        startLoading();
      } else {
        stopLoading();
      }
    });
  }

  Timer? timer;
  startCounter() {
    counter++;
    if (mounted) setState(() {});
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) t.cancel();
      counter++;
      if (mounted) setState(() {});
    });
  }

  void startLoading() async {
    if (showLoading) return;

    showLoading = true;

    if (mounted) setState(() {});

    FocusScope.of(context).unfocus();

    await Future.delayed(const Duration(milliseconds: 200));

    // Future.delayed(const Duration(milliseconds: 200),(){
    //   hideUI=false;
    //   if(mounted)setState(() {});
    // });
    Future.delayed(const Duration(milliseconds: 200), () {
      showBack = true;
      if (mounted) setState(() {});
    });

    startCounter();
  }

  void stopLoading() async {
    if (!showLoading) return;

    showBack = false;
    if (mounted) setState(() {});
    await Future.delayed(const Duration(milliseconds: 200));

    showLoading = false;
    if (mounted) setState(() {});
    resetData();
  }

  void resetData() {
    timer?.cancel();
    counter = 0;
    message = null;
    cancelable = true;
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
    stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    if (!showLoading) return const SizedBox();

    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedOpacity(
                opacity: showBack ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: Container(
                          color: Colors.black.withOpacity(.7),
                        ))),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: MediaQuery.of(context).size.height - (showBack ? 130 : 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        message ?? "Please wait",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'Mulish'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (cancelable)
                      GestureDetector(
                          onTap: () {
                            stopLoading();
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            width: 50,
                            height: 50,
                            child: Center(
                                child: Icon(
                              Icons.cancel,
                              color: Colors.white.withOpacity(.5),
                              size: 35,
                            )),
                          ))
                  ],
                ),
              ),
              AnimatedAlign(
                duration: const Duration(seconds: 1),
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: counter < 2 ? 0 : (1),
                  duration: const Duration(seconds: 1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    margin: EdgeInsets.only(top: counter < 1 ? 50 : 0),
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: (counter % 2 == 0) ? 70 : 60,
                          height: (counter % 2 == 0) ? 70 : 60,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.9),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(seconds: 1),
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: counter < 1 ? 0 : (1),
                  duration: const Duration(seconds: 1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    margin: EdgeInsets.only(top: counter < 1 ? 50 : 0),
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: (counter % 2 == 0) ? 35 : 45,
                          height: (counter % 2 == 0) ? 35 : 45,
                          decoration: const BoxDecoration(
                              // color: white.withOpacity(.9),
                              shape: BoxShape.circle),
                          child: Image.asset('assets/images/Ellipse 956.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
