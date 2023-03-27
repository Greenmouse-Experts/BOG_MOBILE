

import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final int duration;
  final int amount;
  final List<String> benefits;
  const SubscriptionWidget({super.key, required this.name, required this.duration, required this.amount, required this.benefits, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundVariant2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 4,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
        //height: Get.height * 0.25,
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(18)
                  ),
                  padding: const EdgeInsets.all(8),
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
                  child: Image.asset('assets/icons/subscriptions.png')),
                const  SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(name, style: AppTextStyle.headline4.copyWith(color: Colors.black),),
                      const SizedBox(height: 7),
                Text('$duration weeks', style: AppTextStyle.headline4.copyWith(color: Colors.black),),
                 const SizedBox(height: 7),
                Text('NGN $amount', style: AppTextStyle.headline4.copyWith(color: Colors.black),),
                 const SizedBox(height: 7),
                
                  ],
                ),
              ],
            ),
          
            Divider(color: AppColors.blackShade.withOpacity(0.3),),
            ListView.builder(
              itemCount: benefits.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,i){
              return Row(
                children: [
               const   Icon(Icons.verified, color: AppColors.primary,),
              const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: Get.width * 0.75,
                      child: Text(benefits[i], style: AppTextStyle.bodyText1.copyWith(color: Colors.black),)),
                  )
                ],
              );
            }),
            const SizedBox(height: 10),
             Center(child: ElevatedButton.icon(
              onPressed: onPressed, icon: const Icon(Icons.arrow_circle_right), label: const Text('Choose Plan')))
          ],
        ),
      ),
    );
  }
}