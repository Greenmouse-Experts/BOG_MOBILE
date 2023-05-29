import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  static const route = '/updateProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Image.asset(
          'assets/images/wayagram.png',
          width: Get.width * 0.3,
        ),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  const [],
      ),
    );
  }
}
