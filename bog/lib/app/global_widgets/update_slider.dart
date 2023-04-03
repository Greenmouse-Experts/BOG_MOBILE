import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateSlider extends StatefulWidget {
  final double val;
  const UpdateSlider({super.key, required this.val});

  @override
  State<UpdateSlider> createState() => _UpdateSliderState();
}

class _UpdateSliderState extends State<UpdateSlider> {
  late double newVal;
  //double valueMunch = 10;

  @override
  void initState() {
    newVal = widget.val;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.75,
      child: Slider(
          max: 100,
          min: 0,
          value: newVal,
          onChanged: (val) {
            setState(() {
              newVal = val;
            });
          }),
    );
  }
}
