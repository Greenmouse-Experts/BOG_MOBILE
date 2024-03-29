import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../data/model/my_products.dart';

class ItemCounter extends StatefulWidget {
  const ItemCounter(
      {Key? key,
      this.onCountChanged,
      this.initialCount,
      required this.maxCount,
      required this.itemIncrement,
      required this.prod,
      required this.itemDecrement})
      : super(key: key);

  final int? initialCount;
  final int maxCount;
  final MyProducts prod;
  final VoidCallback itemIncrement;
  final VoidCallback itemDecrement;
  final Function(int count)? onCountChanged;

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  int count = 1;

  @override
  initState() {
    super.initState();
    count = widget.initialCount ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PageIconButton(
          icon: FeatherIcons.minus,
          hasBorder: true,
          onPressed: () {
            setState(() {
              if (count <= (widget.prod.minQty ?? 1)) {
                Get.snackbar("Error",
                    "You can't order less than the minimum order quantity of this product",
                    backgroundColor: Colors.red, colorText: Colors.white);
              } else if (count > 1) {
                count--;
                widget.itemDecrement();
                if (widget.onCountChanged != null) {
                  widget.onCountChanged!(count);
                }
              } else {
                if (count > 1) {
                  count--;
                  widget.itemDecrement();
                  if (widget.onCountChanged != null) {
                    widget.onCountChanged!(count);
                  }
                }
              }
            });
          },
          iconColor: count == 1 ? Colors.grey.withOpacity(.5) : Colors.white,
          containerColor:
              count == 1 ? Colors.grey.withOpacity(.2) : AppColors.primary,
        ),
        const SizedBox(width: 7),
        Text('$count'),
        const SizedBox(width: 7),
        _PageIconButton(
            icon: FeatherIcons.plus,
            onPressed: () {
              setState(() {
                if (count < widget.maxCount) {
                  count++;
                  widget.itemIncrement();
                  if (widget.onCountChanged != null) {
                    widget.onCountChanged!(count);
                  }
                }
              });
            },
            iconColor: (count < widget.maxCount
                ? Colors.white
                : Colors.grey.withOpacity(.5)),
            containerColor: (count < widget.maxCount
                ? AppColors.onyx
                : Colors.grey.withOpacity(.2))),
      ],
    );
  }
}

class _PageIconButton extends StatelessWidget {
  const _PageIconButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.iconColor = Colors.white,
    this.containerColor = AppColors.onyx,
    this.hasBorder = false,
  }) : super(key: key);

  final Function()? onPressed;
  final IconData icon;
  final Color iconColor;
  final Color containerColor;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: hasBorder ? Colors.transparent : containerColor,
          borderRadius: BorderRadius.circular(5),
          border: hasBorder ? Border.all(color: containerColor) : null,
        ),
        child: Icon(
          icon,
          color: hasBorder ? containerColor : iconColor,
          size: 18,
        ),
      ),
    );
  }
}
