import 'package:flutter/material.dart';

import '../../constant.dart';

class MoneyInfoWidget extends StatelessWidget {
  final String firstTitle;
  final String firstPrice;
  final String secondTitle;
  final String secondPrice;

  const MoneyInfoWidget({
    super.key,
    required this.firstTitle,
    required this.firstPrice,
    required this.secondTitle,
    required this.secondPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            firstTitle,
            style: const TextStyle(fontSize: 12.5),
          ),
          Expanded(
            child: Text(
              firstPrice,
              style: const TextStyle(fontSize: 15, color: cIndigoColor),
            ),
          ),
          Text(
            secondTitle,
            style: const TextStyle(fontSize: 12.5),
          ),
          Expanded(
            child: Text(
              secondPrice,
              style: const TextStyle(fontSize: 15, color: cIndigoColor),
            ),
          ),
        ],
      ),
    );
  }
}
