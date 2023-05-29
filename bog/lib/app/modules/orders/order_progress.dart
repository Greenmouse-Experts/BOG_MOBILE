
import 'package:flutter/material.dart';

import '../../global_widgets/new_app_bar.dart';

class OrderProgressPage extends StatelessWidget {
  const OrderProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBarBack(context, 'Order Progress'),
      body: SafeArea(
        child: Column(
          children: const [
            Text('data'),
          ],
        ),
      ),
    );
  }
}
