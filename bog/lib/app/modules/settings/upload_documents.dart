import 'dart:convert';
import 'dart:io';

import 'package:bog/app/data/model/read_document_model.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/page_input.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../data/providers/api.dart';
import '../../data/providers/api_response.dart';
import 'package:flutter/material.dart';

import '../../global_widgets/app_loader.dart';
import 'package:dio/dio.dart' as dio;

import '../../global_widgets/overlays.dart';
import '../../global_widgets/pdf_page_viewer.dart';
import '../../global_widgets/photo_view_page.dart';

class UploadDocuments extends StatefulWidget {
    final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const UploadDocuments({super.key, required this.kycScore, required this.kycTotal});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  late Future<ApiResponse> getDocuments;
  late String userType;

  TextEditingController companyProfileController = TextEditingController();
  TextEditingController organizationalChartController = TextEditingController();
  TextEditingController cORController = TextEditingController();
  TextEditingController cACController = TextEditingController();
  TextEditingController meOAController = TextEditingController();
  TextEditingController hseController = TextEditingController();
  TextEditingController qMPController = TextEditingController();
  TextEditingController taxClearanceCertController = TextEditingController();
  TextEditingController vatRegCertController = TextEditingController();
  TextEditingController companyStatementController = TextEditingController();
  TextEditingController referenceFromBankController = TextEditingController();
  TextEditingController nsitfController = TextEditingController();
  TextEditingController mdPassPortController = TextEditingController();
  TextEditingController financeAuditController = TextEditingController();
  TextEditingController operationalController = TextEditingController();
  TextEditingController vendorsController = TextEditingController();




  TextEditingController companyProfileController1 = TextEditingController();
  TextEditingController organizationalChartController1 =
      TextEditingController();
  TextEditingController cORController1 = TextEditingController();
  TextEditingController cACController1 = TextEditingController();
  TextEditingController meOAController1 = TextEditingController();
  TextEditingController hseController1 = TextEditingController();
  TextEditingController qMPController1 = TextEditingController();
  TextEditingController taxClearanceCertController1 = TextEditingController();
  TextEditingController vatRegCertController1 = TextEditingController();
  TextEditingController companyStatementController1 = TextEditingController();
  TextEditingController referenceFromBankController1 = TextEditingController();
  TextEditingController nsitfController1 = TextEditingController();
  TextEditingController mdPassPortController1 = TextEditingController();
  TextEditingController financeAuditController1 = TextEditingController();
  TextEditingController operationalController1 = TextEditingController();
  TextEditingController vendorsController1 = TextEditingController();

  int countNonEmptyControllers(List<TextEditingController> controllers) {

  List<TextEditingController> nonEmptyControllers = controllers.where((controller) => controller.text.isNotEmpty).toList();

  return nonEmptyControllers.length;
}

  ReadDocumentModel? companyProfile1;
  ReadDocumentModel? orgChart1;
  ReadDocumentModel? certReg1;
  ReadDocumentModel? cac1;
  ReadDocumentModel? moa1;
  ReadDocumentModel? hse1;
  ReadDocumentModel? qmp1;
  ReadDocumentModel? taxCert1;
  ReadDocumentModel? refFromBank1;
  ReadDocumentModel? vat1;
  ReadDocumentModel? companyStatement1;
  ReadDocumentModel? nsitf1;
  ReadDocumentModel? passportMd1;
  ReadDocumentModel? auditedFinancials1;
  ReadDocumentModel? operationPhoto1;
  ReadDocumentModel? passportOfVendors1;

  File? companyProfileFile;
  File? orgChartFile;
  File? certRegFile;
  File? cacFile;
  File? moaFile;
  File? hseFile;
  File? qmpFile;
  File? taxCertFile;
  File? refFromBankFile;
  File? vatFile;
  File? companyStatementFile;
  File? nsitfFile;
  File? passportMdFile;
  File? auditedFinancialsFile;
  File? operationPhotoFile;
  File? passportOfVendorsFile;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getDocuments =
        controller.userRepo.getData('/kyc-documents/fetch?userType=$userType');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
        child: Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder<ApiResponse>(
              future: getDocuments,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isSuccessful) {
                  if (snapshot.data!.data != null) {
                    final response = snapshot.data!.data as List<dynamic>;
                    final documents = <ReadDocumentModel>[];
                    for (var element in response) {
                      documents.add(ReadDocumentModel.fromJson(element));
                    }
                    ReadDocumentModel? getParticularData(String identifier) {
                      ReadDocumentModel? result;
                      try {
                        result = documents.firstWhere(
                            (element) => element.name == identifier);
                      } catch (e) {
                        result = null;
                      }
                      return result;
                    }

                    final companyProfile =
                        getParticularData('Company_Corporate_Profile');
                    companyProfile1 = companyProfile;
                    final orgChart = getParticularData('Organizational_Chart');
                    orgChart1 = orgChart;
                    final certReg =
                        getParticularData('Certificate_of_Registration');
                    certReg1 = certReg;
                    final cac = getParticularData('CAC');
                    cac1 = cac;
                    final moa = getParticularData('Memorandum_of_Association');
                    moa1 = moa;
                    final hse = getParticularData('HSE_Policies');
                    hse1 = hse;
                    final qmp =
                        getParticularData('Quality_Management_Procedure');
                    qmp1 = qmp;
                    final taxCert = getParticularData('TAX_Certificate');
                    taxCert1 = taxCert;
                    final refFromBank =
                        getParticularData('reference_from_bank');
                    refFromBank1 = refFromBank;
                    final vat = getParticularData('VAT_Certificate');
                    vat1 = vat;
                    final companyStatement =
                        getParticularData('Company_statement');
                    companyStatement1 = companyStatement;
                    final nsitf = getParticularData('Workmen_Insurance_NSITF');
                    nsitf1 = nsitf;
                    final passportMd = getParticularData('passport_of_MD');
                    passportMd1 = passportMd;
                    final auditedFinancials =
                        getParticularData('audited_financials');
                    auditedFinancials1 = auditedFinancials;
                    final operationPhoto =
                        getParticularData('photograph_of_operational');
                    operationPhoto1 = operationPhoto;
                    final passportOfVendors =
                        getParticularData('Passport_of_vendors');
                    passportOfVendors1 = passportOfVendors;
                    companyProfileController.text =
                        companyProfile == null ? '' : companyProfile.name!;
                    organizationalChartController.text =
                        orgChart == null ? '' : orgChart.name!;
                    cORController.text = certReg == null ? '' : certReg.name!;
                    cACController.text = cac == null ? '' : cac.name!;
                    meOAController.text = moa == null ? '' : moa.name!;
                    hseController.text = hse == null ? '' : hse.name!;
                    qMPController.text = qmp == null ? '' : qmp.name!;
                    taxClearanceCertController.text =
                        taxCert == null ? '' : taxCert.name!;
                    referenceFromBankController.text =
                        refFromBank == null ? '' : refFromBank.name!;
                    vatRegCertController.text = vat == null ? '' : vat.name!;
                    companyStatementController.text =
                        companyStatement == null ? '' : companyStatement.name!;
                    nsitfController.text = nsitf == null ? '' : nsitf.name!;
                    mdPassPortController.text =
                        passportMd == null ? '' : passportMd.name!;
                    financeAuditController.text = auditedFinancials == null
                        ? ''
                        : auditedFinancials.name!;
                    operationalController.text =
                        operationPhoto == null ? '' : operationPhoto.name!;
                    vendorsController.text = passportOfVendors == null
                        ? ''
                        : passportOfVendors.name!;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(title: 'Upload Document'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            companyProfileController.text.isEmpty
                                ? PageInput(
                                    hint: 'Company Profile',
                                    label: "Company's Corporate Profile",
                                    controller: companyProfileController1,
                                    onFilePicked: (file) {
                                      companyProfileFile = file;
                                    },
                                    isFilePicker: true)
                                : DocButton(
                                    title: "Company's Corporate Profile",
                                    file: companyProfile1!.file!,
                                    id: companyProfile1!.id!),
                            const SizedBox(height: 15),
                            organizationalChartController.text.isEmpty
                                ? PageInput(
                                    controller: organizationalChartController1,
                                    onFilePicked: (file) {
                                      orgChartFile = file;
                                    },
                                    hint: '',
                                    label: "Organizational Chart",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'Organizational Chart',
                                    file: orgChart1!.file!,
                                    id: orgChart1!.id!,
                                  ),
                            const SizedBox(height: 15),
                            cORController.text.isEmpty
                                ? PageInput(
                                    controller: cORController1,
                                    onFilePicked: (file) {
                                      certRegFile = file;
                                    },
                                    hint: '',
                                    label: "Certificate of Incorporation",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'Certificate of Incorporation',
                                    file: certReg1!.file!,
                                    id: certReg1!.id!),
                            const SizedBox(height: 15),
                            cACController.text.isEmpty
                                ? PageInput(
                                    controller: cACController1,
                                    onFilePicked: (file) {
                                      cacFile = file;
                                    },
                                    hint: '',
                                    label: "Form CO7 and Form CO2",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'CAC',
                                    id: cac1!.id!,
                                    file: cac1!.file!),
                            const SizedBox(height: 15),
                            meOAController.text.isEmpty
                                ? PageInput(
                                    controller: meOAController1,
                                    onFilePicked: (file) {
                                      moaFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "Memorandum and Articles of Association",
                                    isFilePicker: true)
                                : DocButton(
                                    title:
                                        'Memorandum and Articles of Association',
                                    file: moa1!.file!,
                                    id: moa1!.id!),
                            const SizedBox(height: 15),
                            hseController.text.isEmpty
                                ? PageInput(
                                    controller: hseController1,
                                    onFilePicked: (file) {
                                      hseFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "Health, Safety and Environmental (HSE) Policies",
                                    isFilePicker: true)
                                : DocButton(
                                    title: '(HSE) Policies',
                                    id: hse1!.id!,
                                    file: hse1!.file!,
                                  ),
                            const SizedBox(height: 15),
                            qMPController.text.isEmpty
                                ? PageInput(
                                    controller: qMPController1,
                                    onFilePicked: (file) {
                                      qmpFile = file;
                                    },
                                    hint: '',
                                    label: "Quality Management Procedure",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'Quality Management Procedure',
                                    file: qmp1!.file!,
                                    id: qmp1!.id!),
                            const SizedBox(height: 15),
                            taxClearanceCertController.text.isEmpty
                                ? PageInput(
                                    controller: taxClearanceCertController1,
                                    onFilePicked: (file) {
                                      taxCertFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "Three years TAX Clearance Certificate",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'Tax Clearance',
                                    id: taxCert1!.id!,
                                    file: taxCert1!.file!),
                            const SizedBox(height: 15),
                            vatRegCertController.text.isEmpty
                                ? PageInput(
                                    controller: vatRegCertController1,
                                    onFilePicked: (file) {
                                      vatFile = file;
                                    },
                                    hint: '',
                                    label: "VAT Registration Certificate",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'VAT Registration',
                                    id: vat1!.id!,
                                    file: vat1!.file!,
                                  ),
                            const SizedBox(height: 15),
                            referenceFromBankController.text.isEmpty
                                ? PageInput(
                                    controller: referenceFromBankController1,
                                    onFilePicked: (file) {
                                      refFromBankFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "A reference letter from the company's bank",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'Reference letter from Bank',
                                    file: refFromBank1!.file!,
                                    id: refFromBank1!.id!),
                            const SizedBox(height: 15),
                            companyStatementController.text.isEmpty
                                ? PageInput(
                                    controller: companyStatementController1,
                                    onFilePicked: (file) {
                                      companyStatementFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "Company's six(6) months bank statement",
                                    isFilePicker: true)
                                : DocButton(
                                    title: 'Bank Statement',
                                    file: companyStatement1!.file!,
                                    id: companyStatement1!.id!),
                            const SizedBox(height: 15),
                            nsitfController.text.isEmpty
                                ? PageInput(
                                    controller: nsitfController1,
                                    onFilePicked: (file) {
                                      nsitfFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "Workmen's Compensation Insurance (NSITF)",
                                    isFilePicker: true)
                                : DocButton(
                                    file: nsitf1!.file!,
                                    title: 'NSTIF Insurance',
                                    id: nsitf1!.id!),
                            const SizedBox(height: 15),
                            mdPassPortController.text.isEmpty
                                ? PageInput(
                                    controller: mdPassPortController1,
                                    onFilePicked: (file) {
                                      passportMdFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "One(1) passport sized photograph of MD/Rep",
                                    isFilePicker: true)
                                : DocButton(
                                    file: passportMd1!.file!,
                                    title: 'MD Passport Photo',
                                    id: passportMd1!.id!),
                            const SizedBox(height: 15),
                            financeAuditController.text.isEmpty
                                ? PageInput(
                                    controller: financeAuditController1,
                                    onFilePicked: (file) {
                                      auditedFinancialsFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "Last three(3) years audited financials of the company",
                                    isFilePicker: true)
                                : DocButton(
                                    file: auditedFinancials1!.file!,
                                    title: 'Audited Financials',
                                    id: auditedFinancials1!.id!),
                            const SizedBox(height: 15),
                            operationalController.text.isEmpty
                                ? PageInput(
                                    controller: operationalController1,
                                    onFilePicked: (file) {
                                      operationPhotoFile = file;
                                    },
                                    hint: '',
                                    label:
                                        "Three(3) sided photograph of Operational Area",
                                    isFilePicker: true)
                                : DocButton(
                                    file: operationPhoto1!.file!,
                                    title: 'Operational Area Photo',
                                    id: operationPhoto1!.id!),
                            const SizedBox(height: 15),
                            vendorsController.text.isEmpty
                                ? PageInput(
                                    onFilePicked: (file) {
                                      passportOfVendorsFile = file;
                                    },
                                    controller: vendorsController,
                                    hint: '',
                                    label:
                                        "Passport of vendors and all directors",
                                    isFilePicker: true)
                                : DocButton(
                                    file: passportOfVendors1!.file!,
                                    title: 'Vendors Passport Photo',
                                    id: passportOfVendors1!.id!),
                            const SizedBox(height: 25),
                            AppButton(
                              title: 'Submit',
                              onPressed: () async {
                                final controller = Get.find<HomeController>();
                                userType =
                                    controller.currentType == 'Product Partner'
                                        ? 'vendor'
                                        : 'professional';
                                final files = {
                                  'Company_Corporate_Profile':
                                      companyProfileFile,
                                  "Organizational_Chart": orgChartFile,
                                  "Certificate_of_Registration": certRegFile,
                                  "CAC": cacFile,
                                  "Memorandum_of_Association": moaFile,
                                  "HSE_Policies": hseFile,
                                  "Quality_Management_Procedure": qmpFile,
                                  "TAX_Certificate": taxCertFile,
                                  "reference_from_bank": refFromBankFile,
                                  "VAT_Certificate": vatFile,
                                  "Company_statement": companyStatementFile,
                                  "Workmen_Insurance_NSITF": nsitfFile,
                                  "audited_financials": auditedFinancialsFile,
                                  "photograph_of_operational":
                                      operationPhotoFile,
                                  "Passport_of_vendors": passportOfVendorsFile,
                                  'passport_of_MD': passportMdFile,
                                };
                                dio.FormData formData = dio.FormData();
                                formData.fields
                                    .add(MapEntry('userType', userType));
                                for (var entry in files.entries) {
                                  if (entry.value != null) {
                                    formData.files.add(MapEntry(
                                      entry.key,
                                      (await dio.MultipartFile.fromFile(
                                        entry.value!.path,
                                        filename:
                                            entry.value!.path.split('/').last,
                                      )),
                                    ));
                                  }
                                }
                                  List<TextEditingController> countControllers = [companyProfileController,organizationalChartController,cORController,cACController,meOAController,hseController,qMPController,taxClearanceCertController ,vatRegCertController,companyStatementController ,referenceFromBankController ,nsitfController ,mdPassPortController ,financeAuditController,operationalController,vendorsController];
                                  final kycScore = widget.kycScore;

                                  final newCount = countNonEmptyControllers(countControllers);
                             
                           

                                kycScore['uploadDocument'] = formData.fields.length + newCount - 1;
                                 final updateAccount = await controller
                                        .userRepo
                                        .patchData('/user/update-account', {
                                    "kycScore": jsonEncode(kycScore),
                                    "kycTotal": jsonEncode(widget.kycTotal)
                                  });
                                var response = await Api().postData(
                                    "/kyc-documents/create",
                                    body: formData,
                                    hasHeader: true);
                                if (response.isSuccessful && updateAccount.isSuccessful) {
                                    AppOverlay.successOverlay(
                                          message:
                                              'Documents Uploaded Successfully');
                                } else {
                                  Get.snackbar('Error', 'An error occurred',
                                      backgroundColor: Colors.red);
                                }
                             },
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return const Center(
                      child: Text('Network Error Occurred'),
                    );
                  }
                  return const AppLoader();
                }
              })),
    ));
  }
}

class DocButton extends StatelessWidget {
  final String title;
  final String id;
  final String file;
  const DocButton(
      {super.key, required this.title, required this.id, required this.file});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundVariant2,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: TextButton(
            onPressed: () {
              if (file.endsWith('.jpg') ||
                  file.endsWith('.png') ||
                  file.endsWith('.jpeg')) {
                Get.to(() => PhotoViewPage(url: file));
              } else if (file.endsWith('.pdf')) {
                Get.to(() => PdfViewerPage(path: file));
              } else {
                Get.snackbar('Error', 'File type not supported currently',
                    backgroundColor: Colors.red);
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            child: const Text('View Document')),
        trailing: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete')),
      ),
    );
  }
}
