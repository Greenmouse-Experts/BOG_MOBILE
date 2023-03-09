
import 'package:bog/app/base/base.dart';
import 'package:bog/app/blocs/homeswitch_controller.dart';
import 'package:bog/app/blocs/user_controller.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/modules/home/transfer_details.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/http_utils.dart';
import 'package:bog/core/utils/id_utils.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/string_utils.dart';
import 'package:bog/core/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';


class Subscribe extends BaseWidget {
  const Subscribe({Key? key}) : super(key: key);

  static const route = '/Subscribe';

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends BaseWidgetState<Subscribe> with InputMixin {

  getPageTitle()=>"Subscribe";

  int currentPlan = 0;
  PageController pageController = PageController(viewportFraction: .9);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    setup=false;
    super.initState();
    setupPayStack();
  }

  final plugin = PaystackPlugin();
  void setupPayStack(){
    String paystackKey = "pk_test_77297b93cbc01f078d572fed5e2d58f4f7b518d7";
    plugin.initialize(publicKey: paystackKey,);
  }

  @override
  loadItems() {
    // TODO: implement loadItems
    performApiCall(context, "/subscription/plans", (response, error) {

      if(error!=null){
        setupError=error;
        if(mounted)setState(() {});
        return;
      }

      itemList = response["data"]??[];
      setup=true;
      if(mounted)setState(() {});
    },silently: true,handleError: false,getMethod: true);
  }

  @override
  Widget page(BuildContext context) {

    List icons = [
      "basic_plan".png,
      "ultra_plan".png,
      "ultra_plan".png,
    ];
    List planDetails = true?itemList:[
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
            return Scaffold(
              body: SingleChildScrollView(
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
                      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        child: Row(
                          children: List.generate(planDetails.length, (index){
                            String title = planDetails[index]["name"];
                            bool selected = currentPlan==index;
                            return GestureDetector(
                              onTap: (){
                                print(planDetails[index]);
                                pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                              },
                              child: Container(//duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                height: 55,
                                width: 100,
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
                                    padding: EdgeInsets.fromLTRB(10,0, 10, 0),
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.antiAlias,
                                    child: Text(title,style: textStyle(selected, 13, selected?white:blackColor.withOpacity(.5)),
                                    textAlign: TextAlign.center,)),
                              ),
                            );
                          }),
                        ),
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
                          // scrollController.jumpTo((120 * planDetails.length)/(index+1));
                              //, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                        },
                        controller: pageController,
                        children: List.generate(planDetails.length, (index){
                          Map plan = planDetails[index];
                          String name = plan["name"];
                          String price = "${plan["amount"]??"0"}";
                          String duration = "${plan["duration"]??""} Days";
                          List details = [];//plan["details"]??"";

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
                                    Image.asset(icons[index%icons.length],height: 50,),
                                    addSpaceWidth(15),
                                    Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("$name",style: textStyle(true, 13, orange1),),
                                        addSpace(10),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                          Text(price=="0"?"FREE":"NGN ${formatAmount(price)}",style: textStyle(false, 14, blackColor),),
                                          Flexible(child: Text(price=="0"?"":" / $duration",style: textStyle(false, 14, blackColor.withOpacity(.5)),))
                                        ],)
                                    ],))
                                  ],
                                ),
                                addLine(.5, blackColor.withOpacity(.2), 0, 20, 0, 20),
                                Text("This plan includes",style: textStyle(false, 12, blackColor.withOpacity(.5)),),
                                addSpace(10),
                                Builder(
                                  builder: (context) {
                                    List benefits = plan["benefits"]??[];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: List.generate((benefits).length, (index){
                                        String text = benefits[index]["benefit"]??"";
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
                                              Flexible(child: Text(text,style: textStyle(false, 14, blackColor),))
                                            ],
                                          ),
                                        );
                                      }),
                                    );
                                  }
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

                          String txRef = getRandomId();
                          if(currentPlan==0) {
                            performSub(txRef);
                            return;
                          }

                          showListDialog(context, ["Pay with card","Pay with bank Transfer"],
                              images: [Icons.payment,Icons.account_balance],
                              // title: "Select Payment Method",
                              (_){
                            if(_==0){
                              payWithCard(txRef);
                            }
                            if(_==1){
                              Map plan = itemList[currentPlan];
                              String price = "${plan["amount"]??"0"}";
                              launchScreen(context, TransferDetails(double.parse(price), txRef));
                            }
                              },returnIndex: true);
                        },
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: bottomNav(),
            );
          }),
    );
  }

  void payWithCard(String txRef)async{
    Map plan = itemList[currentPlan];
    String price = "${plan["amount"]??"0"}";

    Charge charge = Charge()
      ..amount = (int.parse(price) * 100)
      ..reference =  txRef
      ..accessCode = txRef
      ..email = currentUser.email;

    CheckoutResponse response = await plugin.checkout(
      context,logo: Image.asset("logo".png,height: 20),
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,fullscreen: true,
    );

    if(response.status==true){
      performSub(txRef);
      // showSuccessDialog(context, "You plan will be activated shortly",
      // onOkClicked: (){
      //   Navigator.pop(context,true);
      // });
    }
  }
  
  void performSub(String reference){
    Map plan = itemList[currentPlan];


    performApiCall(context, "/subscription/subscribe", (response, error){

      UserController.instance.refreshUser(context);
      showSuccessDialog(context, "Subscription successful",
      onOkClicked: (){

        Navigator.pop(context,true);
      });
    },
    data: {
      "userId": currentUser.id,
      "userType": currentUser.userType,
      "planId": plan["id"],
      "reference": reference
    });
  }
}

