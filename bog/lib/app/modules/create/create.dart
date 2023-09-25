import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../../data/model/all_service_model.dart';
import '../../data/model/get_services_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';
import 'json_form.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  static const route = '/create';

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  late Future<ApiResponse> allServices;
  late Future<ApiResponse> typeOfService;

  var search = '';

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    allServices = controller.userRepo.getData('/services/all');
    typeOfService = controller.userRepo.getData('/service/type');
    super.initState();
  }

  var titleController = TextEditingController();
  var searchController = TextEditingController();

  GetServices? searchService(List<GetServices> getServices, String id) {
    try {
      GetServices response = getServices.firstWhere((getService) {
        return getService.serviceId == id;
      });

      return response;
    } catch (e) {
      return null;
    }
  }

  void onServceTap({required String service, required VoidCallback onTap}) {
    AppOverlay.showInfoDialog(
        title: 'Select Service Type',
        content: service,
        buttonText: 'Request',
        onPressed: onTap);
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Create',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              appBar: newAppBarBack(context, 'Request Service Provider'),
              body: SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       right: width * 0.05,
                      //       left: width * 0.045,
                      //       top: kToolbarHeight),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       InkWell(
                      //         onTap: () {
                      //           Get.back();
                      //         },
                      //         child: SvgPicture.asset(
                      //           "assets/images/back.svg",
                      //           height: width * 0.045,
                      //           width: width * 0.045,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: width * 0.04,
                      //       ),
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               "Request Service Provider",
                      //               style: AppTextStyle.subtitle1.copyWith(
                      //                   fontSize: multiplier * 0.07,
                      //                   color: Colors.black,
                      //                   fontWeight: FontWeight.w500),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: width * 0.04,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: width * 0.04,
                      // ),
                      // Container(
                      //   height: 1,
                      //   width: width,
                      //   color: AppColors.grey.withOpacity(0.1),
                      // ),
                      SizedBox(
                        height: width * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.05, right: width * 0.05),
                        child: Text(
                          "Search ",
                          style: AppTextStyle.subtitle1.copyWith(
                              fontSize: multiplier * 0.08,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: width * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.05, right: width * 0.05),
                        child: AppInput(
                          hintText: "Search for your desired service",
                          onChanged: (val) {
                            if (search != val) {
                              setState(() {
                                search = val;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: width * 0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.05, right: width * 0.05),
                        child: Text(
                          "What service do you need ? ",
                          style: AppTextStyle.subtitle1.copyWith(
                              fontSize: multiplier * 0.08,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: width * 0.05,
                      ),
                      FutureBuilder<List<ApiResponse>>(
                          future: Future.wait([allServices, typeOfService]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('An error occured'),
                                );
                              } else if (snapshot.hasData) {
                                final serviceType = snapshot.data![0].data;

                                final newRes = serviceType as List<dynamic>;

                                List<AllService> serviceTypeData =
                                    <AllService>[];
                                for (var element in newRes) {
                                  serviceTypeData
                                      .add(AllService.fromJson(element));
                                }

                                if (search.isNotEmpty) {
                                  serviceTypeData = serviceTypeData
                                      .where((element) => element.name!
                                          .toLowerCase()
                                          .contains(search.toLowerCase()))
                                      .toList();
                                }

                                final serviceType2 = snapshot.data![1].data;

                                final newRes2 = serviceType2 as List<dynamic>;

                                final serviceTypeData2 = <GetServices>[];
                                for (var element in newRes2) {
                                  serviceTypeData2
                                      .add(GetServices.fromJson(element));
                                }

                                if (serviceTypeData.isEmpty) {
                                  return const Center(
                                    child:
                                        Text('No service provider available'),
                                  );
                                }
                                return SizedBox(
                                  height: Get.height * 0.62,
                                  child: GridView.builder(
                                    itemCount: serviceTypeData.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 0),
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.all(0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final service = serviceTypeData[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: ServiceWidget(
                                          width: width,
                                          function: () {
                                            final gottenService = searchService(
                                                serviceTypeData2, service.id!);
                                            if (gottenService == null) {
                                              AppOverlay.showInfoDialog(
                                                  title: 'No Service Provider',
                                                  content:
                                                      'No Service Providers currently available');
                                            } else {
                                              onServceTap(
                                                  service:
                                                      gottenService.title ?? '',
                                                  onTap: () {
                                                    Get.off(JsonForm(
                                                        id: gottenService.id ??
                                                            ''));
                                                  });
                                            }
                                          },
                                          asset: service.icon ??
                                              "https://res.cloudinary.com/greenmouse-tech/image/upload/v1678743452/cgsguxufoibnah3gvz81.png",
                                          title: service.name ?? '',
                                          multiplier: multiplier,
                                          hasBorder: false,
                                          selectedText: searchController.text,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const Center(
                                    child:
                                        Text('No Service Providers Available'));
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const AppLoader();
                            } else {
                              return Text('State: ${snapshot.connectionState}');
                            }
                          }),
                      SizedBox(
                        height: width * 0.07,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: HomeBottomWidget(
                  isHome: false, controller: controller, doubleNavigate: false),
            );
          }),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  const ServiceWidget(
      {Key? key,
      required this.width,
      required this.function,
      required this.asset,
      required this.title,
      required this.multiplier,
      this.hasBorder = false,
      this.selectedText = ""})
      : super(key: key);

  final double width;
  final Function() function;
  final String asset;
  final String title;
  final String selectedText;
  final double multiplier;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: InkWell(
        onTap: function,
        child: Container(
          height: width * 0.4,
          width: width * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: hasBorder
                ? const Border.fromBorderSide(
                    BorderSide(color: Color(0xffEC8B20)))
                : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: width * 0.15,
                width: width * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(asset),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Text.rich(
                TextSpan(
                    text: '',
                    children: highlightOccurrences(title, selectedText)),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Color(0xffEC8B20)),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
