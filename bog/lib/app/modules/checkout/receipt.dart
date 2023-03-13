import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppReceipt extends StatelessWidget {
  final String message;
  const AppReceipt({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return  AppBaseView(child: Scaffold(
      body: Center(child: Text(message),),
    ));
  }
}