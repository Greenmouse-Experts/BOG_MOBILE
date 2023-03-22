import 'package:flutter/material.dart';

class SimpleHeader extends StatefulWidget {
  final dynamic item;
  final Function onChange;
  final int position;
  const SimpleHeader({super.key, this.item, required this.onChange, required this.position});

  @override
  State<SimpleHeader> createState() => _SimpleHeaderState();
}

class _SimpleHeaderState extends State<SimpleHeader> {
  dynamic item;
  @override
  void initState() {
    item = widget.item;
    // widget.onChange(widget.position, item['label']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget.onChange(widget.position, item['label']);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            item['label'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
