import 'dart:io';

import 'package:bog/app/base/base.dart';
import 'package:bog/app/data/providers/my_pref.dart';
import 'package:bog/app/modules/home/home.dart';
import 'package:bog/app/modules/onboarding/onboarding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:gif_view/gif_view.dart';

class MainHome extends StatefulWidget {

  static String route = "/main_home";

  const MainHome({super.key});

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome>{

  List subs = [];
  bool showLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for(var sub in subs)sub?.cancel();

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3),(){

        Get.offAndToNamed(MyPref.authToken.val.isNotEmpty ? Home.route : OnboardingPage.route);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        exit(0);
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: const BoxDecoration(
            color:Colors.white
          ),
          child: Stack(
            // fit: StackFit.expand,
            children: [

Center(child:GifView.asset("onboarding".gif,frameRate: 35,
  repeat: ImageRepeat.noRepeat,
))
            ],
          ),
        ),
      ),
    );
  }

}
