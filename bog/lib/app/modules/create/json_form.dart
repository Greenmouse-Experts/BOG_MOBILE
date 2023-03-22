import 'dart:convert';

import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/data/model/form_builder_model.dart';
import 'package:bog/app/data/model/form_response.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/json_form_builder/new_json_schema.dart';

class JsonForm extends StatefulWidget {
  final String id;
  const JsonForm({super.key, required this.id});

  @override
  State<JsonForm> createState() => _JsonFormState();
}

class _JsonFormState extends State<JsonForm> {
  late Future<ApiResponse> formBuilder;
  @override
  void initState() {
    final controller = Get.find<HomeController>();
    formBuilder =
        controller.userRepo.getData('/service/form-builder/${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic response1;

    Map decorations = {
      'input1': const InputDecoration(
        prefixIcon: Icon(Icons.account_box),
        border: OutlineInputBorder(),
      ),
      'password1': const InputDecoration(
          prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
    };
    return AppBaseView(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppBar(title: 'Service Provider Form'),
                FutureBuilder<ApiResponse>(
                    future: formBuilder,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const AppLoader();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error occured'),
                          );
                        } else if (snapshot.hasData) {
                          String forms = json.encode(snapshot.data!.data);
                          final ans = jsonDecode(forms);
                          //   print(forms);

                          if (ans['formTitle'] == null) {
                            return const Center(
                              child: Text('No Service Provider Available'),
                            );
                          }
                          final FormBuilderModel formBuilder =
                              FormBuilderModel.fromJson(ans);
                          final formBuilderData = formBuilder.formData!;
                          final List<FormAnswer> pid = [];
                          for (var i in formBuilderData) {
                            pid.add(FormAnswer(id: i.id, value: i.placeholder));
                          }
                          final FormResponse ddd = FormResponse(form: pid);
                          final formResponse = ddd.toJson();
                          //  print(formResponse);
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NewJsonSchema(
                                decorations: decorations,
                                form: forms,
                                formResponse: formResponse,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (dynamic response) {
                                  response1 = response;
                                  //   print(response);
                                },
                                actionSave: (data) {
                                  print(data);
                                },
                                buttonSave: Container(
                                  width: Get.width,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.primary,
                                  ),
                                  child: const Center(
                                    child: Text('Submit'),
                                  ),
                                ),
                                // buttonSave: Column(
                                //   children: const [
                                //     SizedBox(height: 10),
                                //     AppButton(
                                //       title: 'Submit',
                                //       // onPressed: () {
                                //       //   print(response1);
                                //       // }
                                //       // onPressed: () async {
                                //       //   if (response1 == null) {
                                //       //     Get.snackbar(
                                //       //       'Incomplete',
                                //       //       'Please fill the form above',
                                //       //       backgroundColor: Colors.red,
                                //       //     );
                                //       //     return;
                                //       //   }
                                //       //   print(jsonEncode(response1));

                                //       //   final res = await controller.userRepo
                                //       //       .postData('/projects/request',
                                //       //           jsonEncode(response1));
                                //       //   if (res.isSuccessful) {
                                //       //     Get.back();
                                //       //     Get.showSnackbar(const GetSnackBar(
                                //       //       message:
                                //       //           'Service requested successfully',
                                //       //       duration: Duration(seconds: 2),
                                //       //     ));
                                //       //   } else {
                                //       //     print(res.message);

                                //       //     Get.showSnackbar(const GetSnackBar(
                                //       //       message: 'An error occured',
                                //       //       duration: Duration(seconds: 2),
                                //       //     ));
                                //       //   }
                                //       //  }
                                //     )
                                // ],
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child:
                                Text('No Service Provider currently available'),
                          );
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}
