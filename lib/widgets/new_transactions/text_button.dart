import 'package:flutter/material.dart';
import 'package:money_management/screens/new_transactions.dart';

import '../../constant.dart';

class TransactionTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const TransactionTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(backgroundColor: cIndigoColor),
          child: Text(
            text,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
