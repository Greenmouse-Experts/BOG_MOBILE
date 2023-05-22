import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/form_builder_model.dart';
import '../../data/model/form_response.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/json_form_builder/new_json_schema.dart';
import '../../global_widgets/new_app_bar.dart';

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
    debugPrint(response1);
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
          appBar: newAppBarBack(context, 'Service Provider Form'),
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                                },
                                actionSave: (data) {},
                                buttonSave:
                                    // const AppButton(title: 'Submit')

                                    Container(
                                  width: Get.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Submit',
                                      style: AppTextStyle.bodyText2.copyWith(
                                          color: AppColors.background),
                                    ),
                                  ),
                                ),
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
