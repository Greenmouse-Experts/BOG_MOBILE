import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../../data/model/my_products.dart';
import '../../data/model/shop_category.dart';
import '../../data/providers/api.dart';
import '../../data/providers/api_response.dart';

import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';
import '../../global_widgets/page_dropdown.dart';

import 'package:dio/dio.dart' as dio;

import 'add_product_success.dart';

class AddProject extends StatefulWidget {
  final MyProducts? myProduct;
  const AddProject({Key? key, this.myProduct}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  List<ShopCategory> savedPosts = [];
  ShopCategory selectedCategory = ShopCategory();
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  Future<List<MultipartFile>> getParts(List<File> pickedFiles) async {
    List<MultipartFile> response = [];

    for (var x in pickedFiles) {
      response.add(
        await dio.MultipartFile.fromFile(x.path,
            filename: x.path.split('/').last) as MultipartFile,
      );
    }
    return response;
  }

  var nameController = TextEditingController();
  var productController = TextEditingController();
  var priceController = TextEditingController();
  var fileController = TextEditingController();
  var unitController = TextEditingController();
  var quantityController = TextEditingController();
  var minController = TextEditingController();
  var maxController = TextEditingController();

  var locationController = TextEditingController();
  var lgaController = TextEditingController(text: 'Eti Osa');
  var sizeController = TextEditingController(text: '0 - 1000 sq.m');
  var typeController = TextEditingController(text: 'Residential');
  var surveyController = TextEditingController(text: 'Perimeter Survey');

  late Future<ApiResponse> createProd;

  File? pickedFile;

  List<File>? pickedFiles;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    createProd = controller.userRepo.getData("/product/category");
    initEdit();
    super.initState();
  }

  void initEdit() {
    if (widget.myProduct != null) {
      final myProduct = widget.myProduct!;
      nameController.text = myProduct.name ?? '';
      productController.text = myProduct.description ?? '';
      priceController.text = myProduct.price ?? '';
      unitController.text = myProduct.unit ?? '';
      quantityController.text = myProduct.quantity ?? '';
      fileController.text = myProduct.image ?? '';
      if (myProduct.minQty != null) {
        minController.text = myProduct.minQty.toString();
      }
      if (myProduct.maxQty != null) {
        maxController.text = myProduct.maxQty.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'AddProject',
          builder: (controller) {
            return Scaffold(
              appBar: newAppBarBack(context, 'Add Product'),
              backgroundColor: AppColors.backgroundVariant2,
              body: FutureBuilder<ApiResponse>(
                  future: createProd,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data!.isSuccessful) {
                      final posts =
                          ShopCategory.fromJsonList(snapshot.data!.data);

                      savedPosts = posts;
                      selectedCategory = savedPosts[0];

                      if (widget.myProduct != null) {}
                      return Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: width * 0.04,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageInput(
                                      hint: "Enter your product name ",
                                      label: "Product Name",
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter the name of your property";
                                        }
                                        return null;
                                      },
                                      controller: nameController,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: AppInput(
                                      hintText: "Tell us about your product",
                                      label: "Product Description",
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter the location of your property";
                                        }
                                        return null;
                                      },
                                      controller: productController,
                                      maxLines: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageInput(
                                      hint: "Enter your product price",
                                      label: "Product Price",
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter the location of your property";
                                        }
                                        return null;
                                      },
                                      controller: priceController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageDropButton(
                                      label: "Product Category",
                                      hint: '',
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      onChanged: (val) {
                                        selectedCategory = val;
                                        unitController.text =
                                            selectedCategory.unit ?? '';
                                      },
                                      value: posts.first,
                                      items: posts
                                          .map<DropdownMenuItem<ShopCategory>>(
                                              (ShopCategory value) {
                                        return DropdownMenuItem<ShopCategory>(
                                          value: value,
                                          child: Text(value.name.toString()),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageInput(
                                      hint: "Pick images to upload",
                                      label: "Upload Product Photos",
                                      controller: fileController,
                                      pickImages: true,
                                      isMultiple: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please pick a picture to upload";
                                        }
                                        return null;
                                      },
                                      onMultipleFilesPicked: (p0) {
                                        pickedFiles = p0;
                                      },
                                      // onFilePicked: (file) {
                                      //   pickedFile = file;
                                      // },
                                      isFilePicker: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageInput(
                                      //  readOnly: true,
                                      hint: 'Input a unit type, e.g bags',
                                      label: 'Unit of Measurement',
                                      controller: unitController,
                                      validator: MinLengthValidator(3,
                                          errorText: 'Enter a valid unit'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageInput(
                                      hint: 'Enter quantity available',
                                      label: 'Product Quantity',
                                      controller: quantityController,
                                      keyboardType: TextInputType.number,
                                      validator: MinLengthValidator(1,
                                          errorText: 'Minimum quantity is 1'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageInput(
                                      hint: 'Enter minimum order quantity',
                                      label: 'Minimum Order Quantity',
                                      controller: minController,
                                      keyboardType: TextInputType.number,
                                      validator: MinLengthValidator(1,
                                          errorText: 'Minimum quantity is 1'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: PageInput(
                                      hint: 'Enter maximum order quantity',
                                      label: 'Maximum Order Quantity',
                                      controller: maxController,
                                      keyboardType: TextInputType.number,
                                      validator: MinLengthValidator(1,
                                          errorText: 'Minimum quantity is 1'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: AppButton(
                                      title: "Submit Product",
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          Map<String, dynamic> bodyForEdit = {};
                                          List<dio.MultipartFile> files = [];

                                          if (pickedFiles != null) {
                                            for (var filePath in pickedFiles!) {
                                              files.add(await dio.MultipartFile
                                                  .fromFile(
                                                filePath.path,
                                                filename: filePath.path
                                                    .split('/')
                                                    .last,
                                              ));
                                            }
                                          }

                                          if (widget.myProduct != null) {
                                            bodyForEdit = pickedFiles == null
                                                ? {
                                                    "categoryId": widget
                                                            .myProduct!
                                                            .categoryId ??
                                                        '',
                                                    "name": nameController.text,
                                                    "price":
                                                        priceController.text,
                                                    "quantity":
                                                        quantityController.text,
                                                    "unit": unitController.text,
                                                    "status": widget.myProduct!
                                                            .status ??
                                                        "draft",
                                                    "description":
                                                        productController.text,
                                                    "productId":
                                                        widget.myProduct!.id,
                                                    "min_qty":
                                                        minController.text,
                                                    "max_qty":
                                                        maxController.text
                                                  }
                                                : {
                                                    "categoryId": widget
                                                            .myProduct!
                                                            .categoryId ??
                                                        '',
                                                    "name": nameController.text,
                                                    "price":
                                                        priceController.text,
                                                    "photos": files,
                                                    "quantity":
                                                        quantityController.text,
                                                    "unit": unitController.text,
                                                    "status": widget.myProduct!
                                                            .status ??
                                                        'draft',
                                                    "description":
                                                        productController.text,
                                                    "productId":
                                                        widget.myProduct!.id,
                                                    "min_qty":
                                                        minController.text,
                                                    "max_qty":
                                                        maxController.text
                                                  };
                                          }

                                          var body = pickedFiles == null
                                              ? {
                                                  "categoryId": selectedCategory
                                                      .id
                                                      .toString(),
                                                  "name": nameController.text,
                                                  "price": priceController.text,
                                                  "quantity":
                                                      quantityController.text,
                                                  "unit": unitController.text,
                                                  "status": "draft",
                                                  "description":
                                                      productController.text,
                                                  "min_qty": minController.text,
                                                  "max_qty": maxController.text
                                                }
                                              : {
                                                  "categoryId": selectedCategory
                                                      .id
                                                      .toString(),
                                                  "name": nameController.text,
                                                  "price": priceController.text,
                                                  "photos": files,
                                                  "quantity":
                                                      quantityController.text,
                                                  "unit": unitController.text,
                                                  "status": "draft",
                                                  "description":
                                                      productController.text,
                                                  "min_qty": minController.text,
                                                  "max_qty": maxController.text
                                                };

                                          var formData =
                                              dio.FormData.fromMap(body);
                                          var editFormData =
                                              dio.FormData.fromMap(bodyForEdit);
                                          var response = (widget.myProduct !=
                                                  null)
                                              ? await controller.userRepo.patchData(
                                                  '/product/${widget.myProduct!.id}',
                                                  editFormData)
                                              : await Api().postData(
                                                  "/products",
                                                  body: formData,
                                                  hasHeader: true);

                                          if (response.isSuccessful) {
                                            if (widget.myProduct == null) {
                                              Get.to(() =>
                                                  const AddProductSuccess());
                                            } else {
                                              AppOverlay.successOverlay(
                                                  message:
                                                      'Product Updated Successfully',
                                                  onPressed: () {
                                                    Get.back();
                                                    Get.back();
                                                  });
                                            }
                                          } else {
                                            Get.snackbar(
                                                "Error",
                                                response.message ??
                                                    'An error occurred',
                                                colorText: AppColors.background,
                                                backgroundColor: Colors.red);
                                          }
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      if (savedPosts.isNotEmpty) {
                        final posts = savedPosts;
                        return Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: width * 0.04,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageInput(
                                    hint: "Enter your product name ",
                                    label: "Product Name",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter the name of your property";
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: AppInput(
                                    hintText: "Tell us about your product",
                                    label: "Product Description",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter the location of your property";
                                      }
                                      return null;
                                    },
                                    controller: productController,
                                    maxLines: 10,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageInput(
                                    hint: "Enter your product price",
                                    label: "Product Price",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter the location of your property";
                                      }
                                      return null;
                                    },
                                    controller: priceController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageDropButton(
                                    label: "Product Category",
                                    hint: '',
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    onChanged: (val) {
                                      selectedCategory = val;
                                      unitController.text =
                                          selectedCategory.unit ?? '';
                                    },
                                    value: posts.first,
                                    items: posts
                                        .map<DropdownMenuItem<ShopCategory>>(
                                            (ShopCategory value) {
                                      return DropdownMenuItem<ShopCategory>(
                                        value: value,
                                        child: Text(value.name.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageInput(
                                    hint: "Pick images to upload",
                                    label: "Upload Product Photos",
                                    isMultiple: true,
                                    controller: fileController,
                                    onMultipleFilesPicked: (p0) {
                                      pickedFiles = p0;
                                    },
                                    pickImages: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please pick a picture to upload";
                                      }
                                      return null;
                                    },
                                    // onFilePicked: (file) {
                                    //   pickedFile = file;
                                    // },
                                    isFilePicker: true,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageInput(
                                    hint: 'Input a unit type, e.g bags',
                                    label: 'Unit of Measurement',
                                    controller: unitController,
                                    validator: MinLengthValidator(3,
                                        errorText: 'Enter a valid unit'),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageInput(
                                    hint: 'Enter quantity available',
                                    label: 'Product Quantity',
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    validator: MinLengthValidator(1,
                                        errorText: 'Minimum quantity is 1'),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageInput(
                                    hint: 'Enter minimum order quantity',
                                    label: 'Minimum Order Quantity',
                                    controller: minController,
                                    keyboardType: TextInputType.number,
                                    validator: MinLengthValidator(1,
                                        errorText: 'Minimum quantity is 1'),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: PageInput(
                                    hint: 'Enter maximum order quantity',
                                    label: 'Maximum Order Quantity',
                                    controller: maxController,
                                    keyboardType: TextInputType.number,
                                    validator: MinLengthValidator(1,
                                        errorText: 'Minimum quantity is 1'),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05, right: width * 0.05),
                                  child: AppButton(
                                    title: "Submit Product",
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        Map<String, dynamic> bodyForEdit = {};

                                        if (widget.myProduct != null) {
                                          bodyForEdit = pickedFile == null
                                              ? {
                                                  "categoryId": widget
                                                      .myProduct!.categoryId,
                                                  "name": nameController.text,
                                                  "price": priceController.text,
                                                  "quantity":
                                                      quantityController.text,
                                                  "unit": unitController.text,
                                                  "status": "draft",
                                                  "description":
                                                      productController.text,
                                                  "productId":
                                                      widget.myProduct!.id,
                                                  "min_qty": minController.text,
                                                  "max_qty": maxController.text
                                                }
                                              : {
                                                  "categoryId": widget
                                                          .myProduct!
                                                          .categoryId ??
                                                      '',
                                                  "name": nameController.text,
                                                  "price": priceController.text,
                                                  "photos": [
                                                    await dio.MultipartFile
                                                        .fromFile(
                                                            pickedFile!.path,
                                                            filename:
                                                                pickedFile!.path
                                                                    .split('/')
                                                                    .last),
                                                  ],
                                                  "quantity":
                                                      quantityController.text,
                                                  "unit": unitController.text,
                                                  "status": "draft",
                                                  "description":
                                                      productController.text,
                                                  "productId":
                                                      widget.myProduct!.id,
                                                  "min_qty": minController.text,
                                                  "max_qty": maxController.text
                                                };
                                        }

                                        var body = pickedFile == null
                                            ? {
                                                "categoryId": selectedCategory
                                                    .id
                                                    .toString(),
                                                "name": nameController.text,
                                                "price": priceController.text,
                                                "quantity":
                                                    quantityController.text,
                                                "unit": unitController.text,
                                                "status": "draft",
                                                "description":
                                                    productController.text,
                                                "min_qty": minController.text,
                                                "max_qty": maxController.text
                                              }
                                            : {
                                                "categoryId": selectedCategory
                                                    .id
                                                    .toString(),
                                                "name": nameController.text,
                                                "price": priceController.text,
                                                "photos": [
                                                  await dio.MultipartFile
                                                      .fromFile(
                                                          pickedFile!.path,
                                                          filename: pickedFile!
                                                              .path
                                                              .split('/')
                                                              .last),
                                                ],
                                                "quantity":
                                                    quantityController.text,
                                                "unit": unitController.text,
                                                "status": "draft",
                                                "description":
                                                    productController.text,
                                                "min_qty": minController.text,
                                                "max_qty": maxController.text
                                              };

                                        var formData =
                                            dio.FormData.fromMap(body);
                                        var editFormData =
                                            dio.FormData.fromMap(bodyForEdit);

                                        var response = (widget.myProduct !=
                                                null)
                                            ? await controller.userRepo.patchData(
                                                '/product/${widget.myProduct!.id}',
                                                editFormData)
                                            : await Api().postData("/products",
                                                body: formData,
                                                hasHeader: true);

                                        if (response.isSuccessful) {
                                          if (widget.myProduct == null) {
                                            Get.to(() =>
                                                const AddProductSuccess());
                                          } else {
                                            AppOverlay.successOverlay(
                                                message:
                                                    'Product Updated Successfully',
                                                onPressed: () {
                                                  Get.back();
                                                  Get.back();
                                                });
                                          }
                                        } else {
                                          Get.snackbar(
                                              "Error", response.message ?? '',
                                              colorText: AppColors.background,
                                              backgroundColor: Colors.red);
                                        }
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: Get.width,
                          height: Get.height * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Products Categories Found",
                                style: AppTextStyle.subtitle1.copyWith(
                                    fontSize: multiplier * 0.07,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox(
                        height: Get.height * 0.7,
                        width: Get.width,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      );
                    }
                  }),
              bottomNavigationBar: HomeBottomWidget(
                  isHome: false, controller: controller, doubleNavigate: false),
            );
          }),
    );
  }
}
