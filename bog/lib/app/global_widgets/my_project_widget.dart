import 'package:bog/app/global_widgets/overlays.dart';
import 'package:bog/app/modules/settings/view_kyc.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProjectWidget extends StatelessWidget {
  const MyProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const[
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.green,

          ),
        ],
      ),
      title: const Text('Project Type', style: TextStyle(color: Colors.black),),
      subtitle: const Text('Order Slug'),
      trailing:
      PopupMenuButton(
        color: Colors.white,
                    
                   itemBuilder: (context){
                     return [
                            PopupMenuItem<int>(
                                value: 1,
                                child:
                                 TextButton(onPressed: (){
                                  Get.to(()=> KYCPage());
                                 }, child: const Text('View Details', style: TextStyle(color: Colors.grey),)),
                            ),

                            PopupMenuItem<int>(
                                value: 2,
                                child:  TextButton(onPressed: (){},  child: const Text('View Form', style: TextStyle(color: Colors.grey),)),
                            ),

                            PopupMenuItem<int>(
                                value: 3,
                                child:   ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red
                                  ),
                                onPressed: (){}, child: const Text('Delete Project', style: TextStyle(color: Colors.white),)),
                            ),
                        ];
                   },
                    onSelected:(value){
                      if(value == 1){
                        Get.to(()=> const KYCPage());
                         print("My account menu is selected.");
                      }else if(value == 2){
                         print("Settings menu is selected.");
                      }else if(value == 3){
                         print("Logout menu is selected.");
                      }
                   },
        child:   const Icon(Icons.more_vert, color: Colors.black,)
                  ),
      
      
    
    );
  }
}