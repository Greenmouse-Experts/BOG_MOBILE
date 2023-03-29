import 'dart:convert';

import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/page_dropdown.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
import '../data/model/nearest_address.dart';

class AddressPicker extends StatefulWidget {
  final TextEditingController textController;
  final HomeController controller;
  final Function updateDeliveryFee;
  const AddressPicker(
    this.updateDeliveryFee, {
    super.key,
    required this.textController,
    required this.controller,
  });

  @override
  State<AddressPicker> createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  var _selectedOption;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
      future: widget.controller.userRepo
          .getData('/address/view/all?q=${widget.textController.text}'),
      builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
        if (snapshot.hasData) {
          final nearestAddresses = <NearestAddress>[];
          for (var element in snapshot.data!.data as List<dynamic>) {
            nearestAddresses.add(NearestAddress.fromJson(element));
          }

          if (nearestAddresses.isEmpty) {
            return const Center(child: Text('No nearest address available'));
          } else {
            // _selectedOption = nearestAddresses[0].address.toString();
            return PageDropButton(
              hint: '',
              label: 'Select Nearest Address',
              value: _selectedOption,
              onChanged: (newValue) {
                setState(() {
                  _selectedOption = newValue!;
                  widget.updateDeliveryFee(newValue!);
                });
              },
              items: nearestAddresses.map((value) {
                return DropdownMenuItem<String>(
                  value: jsonEncode(value),
                  child: Text(value.address.toString()),
                );
              }).toList(),
            );
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // Show a loading indicator while the data is being fetched
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        );
      },
    );
  }
}
