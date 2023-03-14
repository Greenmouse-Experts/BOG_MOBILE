import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:flutter/material.dart';

class AppReceipt extends StatelessWidget {
  final String message;
  const AppReceipt({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('This is receipt page'),
      ),
      body: Center(
        child: Text(message),
      ),
    ));
  }
}
