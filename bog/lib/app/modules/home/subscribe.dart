
import 'package:bog/app/base/base.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class Subscribe extends StatefulWidget {
  const Subscribe({Key? key}) : super(key: key);

  static const route = '/Subscribe';

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> with InputMixin {

  int currentPlan = 0;
  PageController pageController = PageController(viewportFraction: .9);
  @override
  Widget build(BuildContext context) {

    List planDetails = [
      {
        "name":"Basic",
        "icon":"basic_plan".png,
        "price":"5000",
        "duration":"1 yr",
        "details":[
          "Sell your products to clients",
          "Render services to clients",
          "Flexible team meeting",
          "Available for 12 months."
        ]
      },
      {
        "name":"Basic",
        "icon":"ultra_plan".png,
        "price":"5000",
        "duration":"2 yr",
        "details":[
          "Sell your products to clients",
          "Render services to clients",
          "Flexible team meeting",
          "Available for 12 months."
        ]
      },
      {
        "name":"Pro",
        "icon":"ultra_plan".png,
        "price":"9000",
        "duration":"5 yr",
        "details":[
          "Sell your products to clients",
          "Render services to clients",
          "Flexible team meeting",
          "Available for 60 months."
        ]
      },

    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<HomeController>(
          id: 'Subscribe',
          builder: (controller) {
            return SingleChildScrollView(
              // padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  addLine(2, blackColor.withOpacity(.1), 0, 0, 0, 0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      addSpace(20),
                      Text("Choose a plan that's right for you ",style: textStyle(true, 20, blackColor),),
                      addSpace(5),
                      Text("Get eligible to receives orders by subscribing today",style: textStyle(false, 14, blackColor.withOpacity(.5)),),
                      addSpace(20),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB( 10,0,10,0),
                    child: Row(
                      children: List.generate(planDetails.length, (index){
                        String title = planDetails[index]["name"];
                        bool selected = currentPlan==index;
                        return Flexible(
                          child: GestureDetector(
                            onTap: (){
                              pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                            },
                            child: Container(//duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: !selected?null:DecorationImage(image: AssetImage("rectangle".png)),
                               ),
                              alignment: Alignment.topCenter,
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      border: selected?null:Border.all(color: blackColor.withOpacity(.3),width: 1.5),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  // padding: EdgeInsets.only(bottom: selected?7:0),
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.antiAlias,
                                  child: Text(title,style: textStyle(selected, 16, selected?white:blackColor.withOpacity(.5)),)),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  addSpace(15),
                  SizedBox(
                    height: 400,
                    child: PageView(
                      onPageChanged: (index){
                        setState(() {
                          currentPlan=index;
                        });
                      },
                      controller: pageController,
                      children: List.generate(planDetails.length, (index){
                        Map plan = planDetails[index];
                        String name = plan["name"];
                        String price = plan["price"];
                        String duration = plan["duration"];
                        List details = plan["details"];

                        return Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: orange1,width: 1.5)
                          ),
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(plan["icon"],height: 50,),
                                  addSpaceWidth(15),
                                  Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("$name Plan",style: textStyle(true, 13, orange1),),
                                      addSpace(10),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                        Text("NGN ${price}",style: textStyle(false, 14, blackColor),),
                                        Flexible(child: Text(" / $duration",style: textStyle(false, 14, blackColor.withOpacity(.5)),))
                                      ],)
                                  ],))
                                ],
                              ),
                              addLine(.5, blackColor.withOpacity(.2), 0, 20, 0, 20),
                              Text("This plan includes",style: textStyle(false, 12, blackColor.withOpacity(.5)),),
                              addSpace(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(details.length, (index){

                                  return Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 8,height: 8,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle
                                          ),
                                        ),
                                        addSpaceWidth(10),
                                        Flexible(child: Text(details[index],style: textStyle(false, 14, blackColor),))
                                      ],
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        );
                      },)
                    ),
                  ),
                  addSpace(20),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: AppButton(
                      title: "Choose Plan",
                      onPressed: () async {

                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

