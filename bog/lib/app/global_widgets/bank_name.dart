// import 'package:bog/app/data/model/bank_details_model.dart';
// import 'package:bog/app/data/providers/api_response.dart';
// import 'package:bog/app/global_widgets/global_widgets.dart';
// import 'package:bog/core/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// import '../controllers/home_controller.dart';

// class BankNameWidget extends StatefulWidget {
//   final TextEditingController nameController;
//   final TextEditingController accountController;
//   final HomeController controller;
//   final String bankCode;

//   const BankNameWidget(
//       {super.key,
//       required this.nameController,
//       required this.controller,
//       required this.bankCode,
//       required this.accountController});

//   @override
//   State<BankNameWidget> createState() => _BankNameWidgetState();
// }

// class _BankNameWidgetState extends State<BankNameWidget> {
//   @override
//   Widget build(BuildContext context) {
//     print(widget.bankCode);
//     print(widget.accountController.text);
//     return FutureBuilder<ApiResponse>(
//         future: widget.controller.userRepo.getData(
//           '/bank/verify-account',
    
//         ),
//         builder: (ctx, snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data!.isSuccessful) {
//               final bankDetail = BankDetailsModel.fromJson(snapshot.data!.data);
//               widget.nameController.text = bankDetail.accountName!;

//               return DisabledPageInput(
//                 hint: '',
//                 label: 'Bank Account Name',
//                 controller: widget.nameController,
//               );
//             } else {
//               return const Text('Enter a valid account');
//             }
//           } else if (snapshot.hasError) {
//             return const Text('Enter a valid account number');
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.primary,
//               ),
//             );
//           }
//         });
//   }
// }




// final String apiUrl = 'https://your-backend-api.com/verify-account';

// class AccountVerificationPage extends StatefulWidget {
//   @override
//   _AccountVerificationPageState createState() => _AccountVerificationPageState();
// }

// class _AccountVerificationPageState extends State<AccountVerificationPage> {
//   final TextEditingController _inputController = TextEditingController();
//   final TextEditingController _outputController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _inputController.addListener(_verifyAccount);
//   }

//   void _verifyAccount() async {
//     final accountNumber = _inputController.text;
//     if (accountNumber.length == 10) {
//       final response = await http.post(Uri.parse(apiUrl), body: {'accountNumber': accountNumber});

//       if (response.statusCode == 200) {
//         // Verification successful, display the response in the output text field
//         _outputController.text = response.body;
//       } else {
//         // Verification failed, clear the output text field and show an error message
//         _outputController.clear();
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Failed to verify account number'),
//               actions: [
//                 TextButton(
//                   child: Text('OK'),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else {
//       // Clear the output text field if the input is less than 10 digits
//       _outputController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Account Verification'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Enter account number:'),
//             TextField(controller: _inputController, keyboardType: TextInputType.number),
//             SizedBox(height: 16.0),
//             Text('Verification result:'),
//             TextField(controller: _outputController, readOnly: true),
//           ],
//         ),
//       ),
//     );
//   }
// }
