
import 'package:flutter/material.dart';

import '../../core/theme/app_styles.dart';
import 'page_dropdown.dart';

class AppDropDownButton extends StatefulWidget {
  final List<String> options;
  final String label;
  const AppDropDownButton({super.key, required this.options, required this.label});

  @override
  State<AppDropDownButton> createState() => _AppDropDownButtonState();
}

class _AppDropDownButtonState extends State<AppDropDownButton> {
  late String option;

   @override
  void initState() {
    option = widget.options[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageDropButton(label: widget.label, hint: '',
       padding: const EdgeInsets.symmetric(horizontal: 10),
       style: AppTextStyle.bodyText2.copyWith(color: Colors.black), 
       items:  widget.options.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          
                          child: Text(items, style:AppTextStyle.bodyText2.copyWith(color: Colors.black) ,),
                        );
                      }).toList(),
       onChanged: ( newValue) { 
                        setState(() {
                          option = newValue!;
                        });
                      },
          value: option,

    );
  }
}