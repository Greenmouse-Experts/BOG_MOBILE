import 'package:bog/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AppRadioButton extends StatefulWidget {
  final List<String> options;
  const AppRadioButton({super.key, required this.options});

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  late String option;

  @override
  void initState() {
    option = widget.options[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.options.length, (index){
        return ListTile(
          title: Text(widget.options[index], style: AppTextStyle.subtitle1.copyWith(color: Colors.black87),),
          leading:  Radio(  
             activeColor: AppColors.primary,
            value: widget.options[index],  
            groupValue: option,  
            onChanged: ( value) {  
              setState(() {  
                option = value.toString();  
              });  
            },  
          ),
        );
      }),
    );
  }
}