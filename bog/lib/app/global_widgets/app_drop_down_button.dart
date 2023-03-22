import 'package:flutter/material.dart';

import '../../core/theme/app_styles.dart';
// import '../data/model/nearest_address.dart';
import 'page_dropdown.dart';

class AppDropDownButton extends StatefulWidget {
  final List<String> options;
  final String label;
  final Function? action;
  final Function? onChanged;
  final int? position;

  const AppDropDownButton(
      {super.key,
      required this.options,
      required this.label,
      this.action,
      this.position,
      this.onChanged});

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
    return PageDropButton(
      label: widget.label,
      hint: '',
      padding: const EdgeInsets.symmetric(horizontal: 10),
      style: AppTextStyle.bodyText2.copyWith(color: Colors.black),
      items: widget.options.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(
            items,
            style: AppTextStyle.bodyText2.copyWith(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
        if (widget.action != null) {
          widget.action!(widget.position!, newValue);
        }
        setState(() {
          option = newValue!;
        });
      },
      value: option,
    );
  }
}

// class NearAddressDropDown extends StatefulWidget {
//   final Future<List<NearestAddress>> nearestAddresses;
//   const NearAddressDropDown({super.key, required this.nearestAddresses});

//   @override
//   State<NearAddressDropDown> createState() => _NearAddressDropDownState();
// }

// class _NearAddressDropDownState extends State<NearAddressDropDown> {
//   late List<NearestA> addresses;
//   late String option;
//   @override
//   void initState() {
    
//     option = widget.nearestAddresses[0].address.toString();
//     super.initState();
//   }


//   Future<void> resolve()async{
//      final addresses =  await widget.nearestAddresses;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return PageDropButton(
//       label: 'Nearest Address',
//       hint: 'Select Nearest Address',
//       items: widget.nearestAddresses.map((NearestAddress items) {
//         return DropdownMenuItem(
//           value: items,
//           child: Text(
//             items.address.toString(),
//             style: AppTextStyle.bodyText2.copyWith(color: Colors.black),
//           ),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         setState(() {
//           option = newValue!;
//         });
//       },
//       value: option,
//     );
//   }
// }
