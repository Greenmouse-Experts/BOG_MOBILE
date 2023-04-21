import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../data/model/order_details.dart';

class OrderDetailsBuilder extends StatelessWidget {
  final List<OrderDetailItem> orderItems;
  const OrderDetailsBuilder({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: orderItems.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.width * 0.175,
                  width: Get.width * 0.175,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(
                            orderItems[i].product!.image ??
                                'https://res.cloudinary.com/greenmouse-tech/image/upload/v1669563824/BOG/logo_1_1_ubgtnr.png',
                          ),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: Get.width * 0.5,
                        child: Text('Name: ${orderItems[i].product!.name}')),
                    Text('QTY: ${orderItems[i].quantity.toString()}')
                  ],
                ),
                 const Spacer(),
                SizedBox(
                  width: Get.width * 0.15,
                  child: Text(
                    'Price: ${orderItems[i].amount.toString()}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        });
  }
}

class FeeSection extends StatelessWidget {
  final String leading;
  final String content;
  const FeeSection({super.key, required this.leading, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(content),
          )
        ],
      ),
    );
  }
}
