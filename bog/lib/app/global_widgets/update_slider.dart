import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/gradient_helper.dart';

class UpdateSlider extends StatefulWidget {
  final double val;
  final TextEditingController controller;
  const UpdateSlider({super.key, required this.val, required this.controller});

  @override
  State<UpdateSlider> createState() => _UpdateSliderState();
}

class _UpdateSliderState extends State<UpdateSlider> {
  late double newVal;
  late TextEditingController controller;
  //double valueMunch = 10;

  @override
  void initState() {
    newVal = widget.val;
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = const LinearGradient(
 colors: <Color> [
  Colors.red,
  Colors.yellow,
  Colors.green,
 ]
);
    return SizedBox(
    //  
      child: Row(
        children: [
          SizedBox(
            width: Get.width * 0.65,
            child: SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.green,
                trackShape: GradientRectSliderTrackShape(gradient: gradient, darkenInactive: true),
              ),
              child: Slider(        
                  max: 100,
                  min: 0,
                  value: newVal,
                  inactiveColor: Colors.black12,
                  onChanged: (val) {
                    setState(() {
                      newVal = val;
                      controller.text = val.toStringAsFixed(0);
                    });
                  }),
            ),
          ),
                         Text(
                          '${controller.text} %',
                          style:const TextStyle(fontWeight: FontWeight.bold),
                        )
        ],
      ),
    );
  }
}
