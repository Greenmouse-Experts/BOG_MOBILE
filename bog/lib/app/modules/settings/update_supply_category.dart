

import 'dart:convert';

import 'package:bog/app/data/model/supply_category_model.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controllers/home_controller.dart';
import '../../data/providers/api_response.dart';

class UpdateSupplyCategory extends StatefulWidget {
   final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const UpdateSupplyCategory({super.key, required this.kycScore, required this.kycTotal});

  @override
  State<UpdateSupplyCategory> createState() => _UpdateSupplyCategoryState();
}

class _UpdateSupplyCategoryState extends State<UpdateSupplyCategory> {
  late Future<ApiResponse> getSupplyCategories;
     

  final List<String> categories = ["ICT","Special","Mechanical","Electronics","Marine","Electrical","Plumbing","Carpentry","HSE","Stationeries","Techanicals","Paints","Building","Others"];

  

  @override
  void initState() {
    final controller = Get.find<HomeController>();

    

    getSupplyCategories = controller.userRepo.getData('/kyc-supply-category/fetch?userType=vendor');
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseView(child: Scaffold(
      appBar: newAppBarBack(context, 'Categories of Supply'),
      body: SingleChildScrollView(
        child: FutureBuilder<ApiResponse>(
          future: getSupplyCategories,
          builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const AppLoader();
          } else{
            if (snapshot.data!.isSuccessful){
              final response = SupplyCategory.fromJson( snapshot.data!.data);
             
               var oldCategories = <String>[];
              if (response.categories != null){
                oldCategories = response.categories!;
              }  
                   
        return    Column(
          children: [
            CheckTiles(categories: categories, backEndCategories: oldCategories,
            onAdd: (category){
             
               oldCategories.add(category);
           
            },
            onRemoved:  (category){
     
              oldCategories.remove(category);
      
            },),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: AppButton(title: 'Submit',
              onPressed: () async {
                 if (oldCategories.isEmpty){
                  Get.snackbar('Error', 'Select at least one category');
                  return;
                 }
                   final supplyCat = {
                                    "userType": "vendor",
                                     "categories": oldCategories.join(","),
                                  };
             
                  final kycScore = widget.kycScore;
                   kycScore['SupplyCat'] = 1;
                    final controller = Get.find<HomeController>();
                                   final updateAccount = await controller
                                          .userRepo
                                          .patchData('/user/update-account', {
                                      "kycScore": jsonEncode(kycScore),
                                      "kycTotal": jsonEncode(widget.kycTotal)
                                    });
                    final res = await controller.userRepo
                                        .postData('/kyc-supply-category/create',
                                            supplyCat);
            
                 if (res.isSuccessful && updateAccount.isSuccessful) {
                                     AppOverlay.successOverlay(
                                            message:
                                                'Supply Categories Updated Successfully Updated Successfully');
                                    } else {
                                      Get.snackbar('Error', res.message ?? 'error', backgroundColor: Colors.red);
                                    }
              },),
            )
          ],
        );
        
            } else {
              return const Center(child: Text('An error occurred, please try again later'),);
            }
          }

        })
        
      
      ),
    ));
  }
}


class CheckTiles extends StatefulWidget {
  final List<String> categories;
  final List<String> backEndCategories;
  final Function onAdd;
  final Function onRemoved;
  const CheckTiles({super.key, required this.categories, required this.backEndCategories, required this.onAdd, required this.onRemoved});

  @override
  State<CheckTiles> createState() => _CheckTilesState();
}

class _CheckTilesState extends State<CheckTiles> {
   List<bool> newCheckedItems =[];

   @override
  void initState() {
    newCheckedItems = List<bool>.generate(widget.categories.length, (i){
      return widget.backEndCategories.contains(widget.categories[i]);
    });   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   List.generate(widget.categories.length, (index) => CheckboxListTile(
            onChanged: (value){
            setState(() {
              if (value! == true){
               widget.onAdd(widget.categories[index]);
              } else {
                widget.onRemoved(widget.categories[index]);
              }
              newCheckedItems[index] = value;
            });
          },
          title: Text(widget.categories[index], style: const TextStyle(color: Colors.black),),
          value: newCheckedItems[index],))
        );
        }
}