import 'dart:convert';
import 'package:bog/app/base/base.dart';
import 'package:bog/core/utils/string_utils.dart';
import 'package:bog/setup.dart';
import 'package:http/http.dart' as http;


class TransferDetails extends BaseWidget {
  double amount;
  String txRef;
  TransferDetails(this.amount,this.txRef);
    @override
    _TransferDetailsState createState() => _TransferDetailsState();
  }

  class _TransferDetailsState extends BaseWidgetState<TransferDetails> {

   String accountNumber = "";
   String accountBank = "";

     @override
    void initState() {
      setup=false;
      if(devMode){
        setup=true;
        accountNumber = "00221122221";
        accountBank = "WEMA BANK";
      }
      super.initState();
     }


    @override
    loadItems()async{
      setupError=null;
      if(mounted)setState(() {});
      createCustomer();

    }

   createCustomer()async{
     setupError=null;
     if(mounted)setState(() {});
     try {
       var response = await http.post(
           Uri.parse("https://api.paystack.co/customer"),
           headers: {
             "Authorization":"Bearer ${getPayStackSecrete}"
           },
           body:
           {
             "email": currentUser.email,
             "first_name": currentUser.fname,
             "last_name": currentUser.lname,
             "phone": currentUser.phone
           }
       );
       print("Res: ${response.body}");
       Map res = jsonDecode(response.body);
       bool status = res["status"];
       if (status == true) {
         Map items = res["data"];
         String customer_code = items["customer_code"];
         int customer_id = items["id"];

         createVirtualAccount(customer_code,customer_id);
       } else {
         setupError = res["message"]??"Error occurred, try again later";
         if(mounted)setState(() {});
       }
     }catch(e){
       setupError = e.toString();
       if(mounted)setState(() {});
     }

   }

   createVirtualAccount(String customerCode,int customerId)async{
     setupError=null;
     if(mounted)setState(() {});
     try {
       var response = await http.post(
           Uri.parse("https://api.paystack.co/dedicated_account"),
           headers: {
             "Authorization":"Bearer ${getPayStackSecrete}"
           },
           body:
           { "customer": customerCode, "preferred_bank": "wema-bank"}
       );
       print("Res: ${response.body}");
       Map res = jsonDecode(response.body);
       bool status = res["status"];
       if (status == true) {
         Map items = res["data"];
         accountNumber = items["account_number"];
         accountBank = items["bank"]["name"];

         setup=true;
         if(mounted)setState(() {});
       } else {
         setupError = res["message"]??"Error occurred, try again later";
         if(mounted)setState(() {});
       }
     }catch(e){
       setupError = e.toString();
       if(mounted)setState(() {});
     }

   }

  getpageTitle()=>"Perform Transfer";

   @override
    page(BuildContext context){

       return Column(
         children: [

           Expanded(
             child:

             Center(
               child: SingleChildScrollView(
                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Image.asset("naira".png,color: blue0,height: 22,),
                         addSpaceWidth(5),
                         Text(formatAmount(widget.amount),
                           style: textStyle(true, 45, blue0),)
                       ],
                     ),
                     addSpace(15),
                     Text("Please proceed to your mobile banking/internet banking app to complete the transfer",
                       style: textStyle(true, 14, blackColor.withOpacity(.9))),
                     addSpace(10),
                     Text("Your subscription will be activated once the transfer has been made",
                       style: textStyle(false, 12, blackColor.withOpacity(.9))),
                     addSpace(20),

                     Container(
                       padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                       decoration: BoxDecoration(
                         color: whiteColor4,borderRadius: BorderRadius.circular(10)
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           rowItem("Account Number", accountNumber,copy: true,context: context),
                           rowItem("Bank", accountBank,),
                         ],
                       ),
                     ),
                     addSpace(20),
                     Container(
                             height: 45,width: double.infinity,
                       margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                       child: TextButton(
                           style: TextButton.styleFrom(
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)),
                             backgroundColor: blue0,
                           ),
                           onPressed: () {
                               Navigator.pop(context,true);
                           },
                           child: Text(
                             "OK",maxLines: 1,
                             style: textStyle(true, 18, white),
                           )),
                     ),
                     addSpace(30),
                     Text("Having payment issues?",style: textStyle(false, 14, black.withOpacity(.5)),),
                     addSpace(10),
                     GestureDetector(
                         onTap: (){
                           // String email = appSettingsModel.getString(SUPPORT_EMAIL);
                           // sendEmail(email,subject: "Payment Issues",body: "Hi Team, i will be glad if you can assist me");

                         },
                         child: Text("Email us",style: textStyle(true, 14, blue0),)),
                     addSpace(100),
                   ],
                 ),
               ),
             ),
           )
         ],
       );
    }
  }
