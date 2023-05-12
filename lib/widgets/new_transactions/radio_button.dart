import 'package:flutter/material.dart';

import '../../constant.dart';

class TransactionRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String label;

  const TransactionRadioButton({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: cIndigoColor,
        ),
        Text(label),
      ],
    );
  }
}
